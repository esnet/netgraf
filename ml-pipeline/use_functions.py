from datetime import timedelta
import pandas as pd
import numpy as np

import plotly.graph_objects as go
from plotly.subplots import make_subplots

from statsmodels.tsa.vector_ar.vecm import coint_johansen
from statsmodels.tsa.vector_ar.var_model import VAR 

from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import MinMaxScaler

import tensorflow as tf 
from tensorflow.keras.models import Model, Sequential, load_model

import warnings
warnings.simplefilter(action='ignore') 



def forecast_plot(df1, df2, pred, names, model_name):
    fig = make_subplots(rows=6, cols=1, subplot_titles=df1.columns,
                    vertical_spacing=0.05)

    for i, col in enumerate(df1.columns):
        fig.add_trace(go.Scatter(name=names[0], x=df1.index, y=df1[col],  
                                marker = dict(size = 10, 
                                            color = 'blue'),
                                textfont=dict(
                                    color='black',
                                    size=18,  
                                    family='Times New Roman')),
                    row=i+1, col=1)
        fig.add_trace(go.Scatter(name=names[1], x=df2.index, y=df2[col],  
                                marker = dict(size = 10, 
                                            color = 'red')),
                    row=i+1, col=1) 
        fig.add_trace(go.Scatter(name=names[2], x=df2.index, y=pred[:, i],  
                                marker = dict(size = 10, 
                                            color = 'green')),
                    row=i+1, col=1) 
        
    fig.update_xaxes(
        rangeselector=dict(
            buttons=list([
                dict(count=1, label="1m", step="month", stepmode="backward"),
                dict(count=6, label="6m", step="month", stepmode="backward"),
                dict(count=1, label="YTD", step="year", stepmode="todate"),
                dict(count=1, label="1y", step="year", stepmode="backward"),
                dict(step="all")
            ])
        )
    )
    fig.update_layout(autosize=False,
        width=1300,
        height=1500,
        title={
            'text': f"{model_name} Model Plot",
            'y':0.98,
            'x':0.5,
            'xanchor': 'center',
            'yanchor': 'top', 
            'font': {'size': 20}}
        )
    fig.update_layout(legend=dict(
        orientation="h",
        yanchor="bottom",
        y=1.02,
        xanchor="right",
        x=1
    ))
    # remove duplicate legends in plot 
    # https://stackoverflow.com/questions/26939121/how-to-avoid-duplicate-legend-labels-in-plotly-or-pass-custom-legend-labels/62162555#62162555
    names = set()
    fig.for_each_trace(
        lambda trace:
            trace.update(showlegend=False)
            if (trace.name in names) else names.add(trace.name))

    return fig 
    
    
def rmse_results(actual, pred):
    result = dict()
    # check rmse
    for i, col in enumerate(df.columns):
        result[f'{col} RMSE'] = np.sqrt(mean_squared_error(actual[:, i], pred[:, i])).round(3)
    return result

# https://machinelearningmastery.com/multivariate-time-series-forecasting-lstms-keras/
def series_to_supervised(data, n_in=1, n_out=1, dropnan=True):
	"""
	Frame a time series as a supervised learning dataset.
	Arguments:
		data: Sequence of observations as a list or NumPy array.
		n_in: Number of lag observations as input (X).
		n_out: Number of observations as output (y).
		dropnan: Boolean whether or not to drop rows with NaN values.
	Returns:
		Pandas DataFrame of series framed for supervised learning.
	"""
	n_vars = 1 if type(data) is list else data.shape[1]
	df = pd.DataFrame(data)
	cols, names = list(), list()
	# input sequence (t-n, ... t-1)
	for i in range(n_in, 0, -1):
		cols.append(df.shift(i))
		names += [('var%d(t-%d)' % (j+1, i)) for j in range(n_vars)]
	# forecast sequence (t, t+1, ... t+n)
	for i in range(0, n_out):
		cols.append(df.shift(-i))
		if i == 0:
			names += [('var%d(t)' % (j+1)) for j in range(n_vars)]
		else:
			names += [('var%d(t+%d)' % (j+1, i)) for j in range(n_vars)]
	# put it all together
	agg = pd.concat(cols, axis=1)
	agg.columns = names
	# drop rows with NaN values
	if dropnan:
		agg.dropna(inplace=True)
	return agg 

def fit_predict_var(df):
    # forecast for next 65 days 
    n_obs = 65 * 24
    df_train, df_test = df[0:-n_obs], df[-n_obs:]
    
    # fit the model
    model = VAR(endog=df_train)
    model_fit = model.fit() 
    
    # Get the lag order
    lag_order = model_fit.k_ar
    
    # Input data for forecasting
    forecast_input = df_train.values[-lag_order:]
    forecast_input.shape  
    
    # Forecast
    fc = model_fit.forecast(y=forecast_input, steps=n_obs)
    
    return df_train, df_test, fc

def fit_predict_lstm(df):
    # normalize features
    scaler = MinMaxScaler(feature_range=(0, 1))
    scaled = scaler.fit_transform(df.values)
    df_reframed = series_to_supervised(scaled) 
    
    # split into train and test sets
    values = df_reframed.values
    n_train_hours = 300 * 24 # first 300 days for train 
    train = values[:n_train_hours, :]
    test = values[n_train_hours:, :]
    
    # split into input and outputs
    train_X, train_y = train[:, :-6], train[:, -6:]
    test_X, test_y = test[:, :-6], test[:, -6:] 
    
    # reshape input to be 3D [samples, timesteps, features]
    train_X = train_X.reshape((train_X.shape[0], 1, train_X.shape[1]))
    test_X = test_X.reshape((test_X.shape[0], 1, test_X.shape[1]))
    
    # load model
    lstm_model = load_model('models/LSTM.h5')
    
    # make a prediction
    yhat = lstm_model.predict(test_X)
    
    # invert scaling for forecast and actual 
    inv_yhat = scaler.inverse_transform(yhat)
    inv_y = scaler.inverse_transform(test_y)
    
    return n_train_hours, inv_y, inv_yhat 
    
    