#!/usr/bin/python3
"""
1-top_ten
"""
import requests

def top_ten(subreddit):
    """
    Queries the Reddit API and prints the titles of the first 10 hot posts
    for a given subreddit.
    If the subreddit is invalid, print None.
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {'User-Agent': 'custom-agent'}

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        if response.status_code == 200:
            data = response.json().get('data', {}).get('children', [])
            if not data:
                print("No posts found.")
                return

            for post in data[:10]:
                print(post['data']['title'])
        else:
            print(None)
    except requests.RequestException as e:
        print(None)
