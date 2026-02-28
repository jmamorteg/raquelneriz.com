---
layout: default
lang: en
title: Blog
permalink: /en/blog/
---

# Blog

<div class="posts-grid">
    {% for post in site.posts %}
    <article class="post-card">
        <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        <p class="post-meta">{{ post.date | date: "%B %d, %Y" }}</p>
        <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 150 }}</p>
        <a href="{{ post.url | relative_url }}" class="read-more">Read more</a>
    </article>
    {% endfor %}
</div>

{% if site.posts.size == 0 %}
<div class="no-posts">
    <p>No posts yet. New content coming soon.</p>
</div>
{% endif %}
