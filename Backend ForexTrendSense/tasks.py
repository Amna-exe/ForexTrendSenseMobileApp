import requests
import os
import json
import schedule
import time
from textblob import TextBlob
from sentiment_utils import get_sentiment_data
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

NEWS_API_KEY = os.getenv('NEWS_API_KEY')

if not NEWS_API_KEY:
    raise ValueError("NEWS_API_KEY not found. Please set it in the .env file.")

def fetch_news(query, page_size=10):
    """
    Fetch news articles based on the query.
    :param query: Search term for the news
    :param page_size: Number of articles to fetch
    :return: List of article titles
    """
    base_url = "https://newsapi.org/v2/everything"
    params = {
        'q': query,
        'from': '2024-11-29',
        'sortBy': 'publishedAt',
        'apiKey': NEWS_API_KEY,
        'pageSize': page_size
    }
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        articles = response.json().get('articles', [])
        return [article['title'] for article in articles if 'title' in article]
    else:
        print(f"Error: {response.status_code}, {response.text}")
        raise Exception(f"Error fetching news: {response.json().get('message')}")

def analyze_sentiment(text):
    """
    Analyze the sentiment of a given text.
    :param text: Input text
    :return: Sentiment category (Positive, Neutral, Negative)
    """
    blob = TextBlob(text)
    polarity = blob.sentiment.polarity  # Range: [-1, 1]

    if polarity > 0.1:
        return 'Positive'
    elif polarity < -0.1:
        return 'Negative'
    else:
        return 'Neutral'

def update_daily_data():
    """
    Update daily sentiment data and save it to a file.
    """
    data = get_sentiment_data()
    with open('data/sentiment_data.json', 'w') as file:
        json.dump(data, file)
    print("Sentiment data updated.")

# Schedule to run update_daily_data every day at midnight
schedule.every().day.at("00:00").do(update_daily_data)

# Run the scheduler
while True:
    schedule.run_pending()
    time.sleep(1)
