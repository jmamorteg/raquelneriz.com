---
layout: default
---

# Bienvenidos a Raquel Neriz

Explorar mi trabajo como restauradora.

## Últimos Posts

<ul>
{% for post in site.posts limit:5 %}
  <li>
    <a href="{{ post.url }}">{{ post.title }}</a>
    <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
  </li>
{% endfor %}
</ul>

## Sobre mí

Soy Raquel Neriz, restauradora/conservadora.

[Conoce más sobre mi trabajo](/about.html)
