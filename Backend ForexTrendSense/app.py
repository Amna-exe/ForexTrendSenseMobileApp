from flask import Flask, jsonify
from flask_cors import CORS

# Initialize Flask app and CORS
app = Flask(__name__)
CORS(app)

@app.route('/sentiment', methods=['GET'])
def get_sentiment():
    """
    API endpoint to fetch sentiment data.
    """
    from sentiment_utils import get_sentiment_data  # Import function to avoid circular import
    data = get_sentiment_data()
    return jsonify(data)

@app.route('/sentiment/report', methods=['GET'])
def generate_report():
    """
    API endpoint to generate sentiment report.
    """
    from sentiment_utils import get_sentiment_data  # Import function to avoid circular import
    data = get_sentiment_data()
    report = {
        'positive': sum(1 for item in data if item['sentiment'] == 'Positive'),
        'neutral': sum(1 for item in data if item['sentiment'] == 'Neutral'),
        'negative': sum(1 for item in data if item['sentiment'] == 'Negative'),
    }
    return jsonify(report)

@app.route('/sentiment/chart', methods=['GET'])
def generate_chart_data():
    """
    API endpoint to generate chart data for the frontend.
    """
    from sentiment_utils import get_sentiment_data  # Local import to avoid circular import
    data = get_sentiment_data()

    # Count sentiment occurrences
    report = {
        'positive': sum(1 for item in data if item['sentiment'] == 'Positive'),
        'neutral': sum(1 for item in data if item['sentiment'] == 'Neutral'),
        'negative': sum(1 for item in data if item['sentiment'] == 'Negative'),
    }

    return jsonify(report)
if __name__ == '__main__':
    app.run(debug=True)
