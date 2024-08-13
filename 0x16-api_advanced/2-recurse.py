#!/usr/bin/python3
"""
2-recurse
"""
import requests


def recurse(subreddit, hot_list=[], after=None):
    """
    Recursively queries the Reddit API and returns a i
    list containing the titles of all hot articles for a given subreddit.
    If no results are found, returns None.
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {'User-Agent': 'custom-agent'}
    params = {'limit': 100, 'after': after}

    try:
        response = requests.get(url, headers=headers,
                                params=params, allow_redirects=False)
        if response.status_code == 200:
            data = response.json().get('data', {})
            children = data.get('children', [])

            for post in children:
                hot_list.append(post['data']['title'])

            after = data.get('after')
            if after is not None:
                return recurse(subreddit, hot_list, after)
            else:
                return hot_list if hot_list else None
        else:
            return None
    except requests.RequestException as e:
        return None
