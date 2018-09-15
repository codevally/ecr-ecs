import os
import socket
from flask import Flask, render_template
app = Flask(__name__)

hostname = socket.gethostname()

# two decorators, same function
@app.route('/')
@app.route('/index.html')
def index():
    return render_template('index.html', the_title='Welcome Docker + ECS', hostname=hostname)


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
