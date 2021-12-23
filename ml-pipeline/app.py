import streamlit as st

import pandas as pd
import numpy as np

from statsmodels.tsa.vector_ar.vecm import coint_johansen
from statsmodels.tsa.vector_ar.var_model import VAR

from use_functions import ( forecast_plot, rmse_results, fit_predict_lstm,
                           fit_predict_var )

import warnings
warnings.simplefilter(action='ignore')


def main():
    st.set_page_config(layout = "wide")
    page = st.sidebar.selectbox('Select Algorithm:', ['VAR','LSTM'])
    st.title('NetGraf ML Predict Dashboard')

    # load dataframe
    df = pd.read_csv('datasets/throughput.csv', parse_dates=['Time'], index_col='Time')
    df_print = pd.read_csv('datasets/throughput.csv', parse_dates=['Time'])

    st.markdown('#### Dataset:')
    st.write(df_print)
    st.write(f'Dataset shape: {df.shape}')

    st.markdown('#### NetGraf Dataset Statistics:')
    st.write(df.describe().T)

    # missing value treatment
    for i in ['Node 138.68.173.232', 'Node 192.5.86.169']:
        df[i][df[i] == 0] = df[i].mean()

    st.markdown("#### NetGraf Test vs Prediction Plot:")


    if page == 'VAR':
        df_train, df_test, fc = fit_predict_var(df)
        fig = forecast_plot(df_train, df_test, fc, ['Train', 'Test', 'Predict'], 'VAR')
        st.plotly_chart(fig)

    else:
        n_train_hours, inv_y, inv_yhat = fit_predict_lstm(df)
        df_train, df_test = df.iloc[:n_train_hours, :], df.iloc[n_train_hours:, :]
        fig = forecast_plot(df_train, df_test, inv_yhat, ['Train', 'Test', 'Predict'], 'LSTM')
        st.plotly_chart(fig)

if __name__ == "__main__":
    main()
