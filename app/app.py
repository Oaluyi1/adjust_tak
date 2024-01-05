from flask import Flask, jsonify

app = Flask(__name__)


# Check if the application is in debug mode
if app.config.get('DEBUG'):
    print("Running in debug mode!")


# Endpoint to return a JSON response with the message "Hello World"
@app.route('/hello', methods=['GET'])
def hello_world():
    response = {'message': 'Hello World'}
    return jsonify(response)


# Endpoint to check the health of the application
@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy"})


if __name__ == '__main__':
    # Run the application with debug mode
    app.run(port=5000, debug=True)
