---
layout: default
---

# Bienvenidos a Raquel Neriz

Explorar las profundidades del conocimiento astrológico, psicológico y transpersonal.

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

Soy Raquel Neriz, exploradora de las profundidades del conocimiento astrológico, psicológico y transpersonal. En este espacio comparto reflexiones, análisis y descubrimientos sobre estos fascinantes campos del saber humano.

[Conoce más sobre mi trabajo](/about.html)
