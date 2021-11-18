import os
import shutil
import pandas as pd
import plotly.express as px


def generate_site():
    try:
        os.makedirs('dist')
    except FileExistsError:
        pass
    shutil.copyfile('templates/index.html', 'dist/index.html')

    df = pd.read_csv('combine_plot_buffersize_512.csv')

    create_plot_iframe(df, 'time(s)', 'Throughput_5mb(mbps)', 'dist/5mb.html')

    create_plot_iframe(df, 'time(s)', 'Throughput_10mb(mbps)', 'dist/10mb.html')
        
    create_plot_iframe(df, 'time(s)', 'Throughput_20mb(mbps)', 'dist/20mb.html')

    create_plot_iframe(df, 'time(s)', 'Throughput_30mb(mbps)', 'dist/30mb.html')

    create_plot_iframe(df, 'time(s)', 'Throughput_50mb(mbps)', 'dist/50mb.html')

    create_plot_iframe(df, 'time(s)', 'Throughput_100mb(mbps)', 'dist/100mb.html')



    # create_plot_iframe(df, 'petal_width', 'petal_length', 'dist/petal_plot.html',
    #                    'Iris dataset - petal size scatter plot')


def create_plot_iframe(df, x_name, y_name, outpath):
    plot = px.line(data_frame=df, x=x_name, y=y_name)
    plot.update_layout(
        margin=dict(l=0, r=0, t=0, b=0),
    )
    plot.write_html(outpath,
                    full_html=True,
                    include_plotlyjs='cdn')


if __name__ == '__main__':
    generate_site()
