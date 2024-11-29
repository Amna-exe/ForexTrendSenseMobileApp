import requests
import os
import json
from textblob import TextBlob
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

NEWS_API_KEY = os.getenv('NEWS_API_KEY')

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
        data = response.json()
        print(json.dumps(data, indent=4))  # Print the full JSON response for inspection
        articles = data.get('articles', [])
        if not articles:
            print("No articles found.")
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

def get_sentiment_data():
    """
    Fetch news articles and analyze their sentiment.
    :return: List of dictionaries containing news titles and sentiment
    """
    news_articles = fetch_news('forex trading', page_size=20)
    if not news_articles:
        print("No news articles to analyze.")
        return []

    sentiment_results = []

    for article in news_articles:
        sentiment = analyze_sentiment(article)
        sentiment_results.append({'text': article, 'sentiment': sentiment})

    return sentiment_results
