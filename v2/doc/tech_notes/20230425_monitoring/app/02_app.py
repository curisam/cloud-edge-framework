from flask import Flask, render_template
import sqlite3
import plotly
import plotly.graph_objs as go

app = Flask(__name__)

@app.route('/')
def home():
    """
    Display temperature and CPU usage on homepage
    """
    
    '''
    conn = sqlite3.connect('monitoring.db')
    c = conn.cursor()
    c.execute("SELECT cpu_temperature, cpu_usage, timestamp FROM data ORDER BY id DESC LIMIT 10")
    data = c.fetchall()
    c.close()
    conn.close()

    temperature_data = [d[0] for d in data]
    cpu_usage_data = [d[1] for d in data]
    timestamp_data = [d[2] for d in data]

    temperature_fig = go.Figure(
        data=[go.Scatter(x=timestamp_data, y=temperature_data)],
        layout=go.Layout(title="Temperature")
    )

    cpu_usage_fig = go.Figure(
        data=[go.Scatter(x=timestamp_data, y=cpu_usage_data)],
        layout=go.Layout(title="CPU Usage")
    )

    temperature_graph = temperature_fig.to_html(full_html=False)
    cpu_usage_graph = cpu_usage_fig.to_html(full_html=False)

    return render_template('index.html', temperature_graph=temperature_graph, cpu_usage_graph=cpu_usage_graph)
    '''
    return render_template('index.html')


# Entry point
# if __name__ == '__main__:'
if True:
    app.run(debug=True, port=8004) # 28004

