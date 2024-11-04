from flask import Flask, render_template, request, redirect, url_for
import boto3

app = Flask(__name__)

# In-memory storage for messages
messages = []

@app.route('/')
def index():
    return render_template('index.html', messages=messages)

@app.route('/hello/<name>')
def hello(name):
    return render_template('hello.html', name=name)

@app.route('/add_message', methods=['POST'])
def add_message():
    message = request.form.get('message')
    if message:
        messages.append(message)
    return redirect(url_for('index'))

@app.route('/json_example')
def json_example():
    return {
        'message': 'Hello from Flask!',
        'status': 'success',
        'data': messages
    }

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)