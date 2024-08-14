#!/usr/bin/python3
"""
Uses Reddit API to returns the titles of the first 10 hot posts
for a given subreddit.
"""
import requests


def top_ten(subreddit):
    """
    Returns the titles of the first 10 hot posts for a given subreddit.
    """

    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {'User-Agent': 'request'}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code != 200:
        print(None)
        return

    data = response.json().get("data", {})
    posts = data.get("children", [])
    titles = [post.get("data", {}).get("title", "") for post in data]

    print("\n".join(titles))
