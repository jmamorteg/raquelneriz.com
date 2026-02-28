---
layout: default
lang: ca
title: Blog
permalink: /ca/blog/
---

# Blog

<div class="posts-grid">
    {% for post in site.posts %}
    <article class="post-card">
        <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        <p class="post-meta">{{ post.date | date: "%d de %B, %Y" }}</p>
        <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 150 }}</p>
        <a href="{{ post.url | relative_url }}" class="read-more">Llegeix més</a>
    </article>
    {% endfor %}
</div>

{% if site.posts.size == 0 %}
<div class="no-posts">
    <p>Encara no hi ha publicacions. Aviat hi haurà nou contingut.</p>
</div>
{% endif %}
