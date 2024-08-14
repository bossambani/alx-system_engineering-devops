#!/usr/bin/python3
"""
Uses Reddit API to returns a list containing the titles
of all hot articles for a given subreddit.
"""
import requests


def recurse(subreddit, hot_list=[]):
    """
    Returns a list of hot articles.
    """
    after = ""
    if after is None:
        return []

    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    url += f"?limit=100&after={after}"
    headers = {'User-Agent': 'request'}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code != 200:
        return None

    r_json = response.json()
    hot_posts = r_json.get("data").get("children")

    for post in hot_posts:
        hot_list.append(post.get("data").get("title"))

    return hot_list + recurse(subreddit, [], r_json.get("data").get("after"))
