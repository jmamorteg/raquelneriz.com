---
layout: default
title: Portfolio
permalink: /portfolio/
lang: es
---

# Portfolio

Una selección de trabajos de Raquel Neriz en restauración, conservación y práctica de kintsugi.

{% for section in site.data.portfolio.sections %}
## {{ section.title }} {#{{ section.id }}}

{% if section.items and section.items.size > 0 %}
<div class="portfolio-grid">
  {% for item in section.items %}
  <article class="portfolio-card">
    {% if item.image %}
    <img src="{{ item.image | relative_url }}" alt="{{ item.title }}" class="portfolio-image" />
    {% endif %}
    <h3>{{ item.title }}</h3>
    {% if item.description %}
    <p>{{ item.description }}</p>
    {% endif %}
    {% if item.hashtags %}
    <p class="portfolio-hashtags">{{ item.hashtags }}</p>
    {% endif %}
    {% if item.link %}
    <p><a href="{{ item.link }}" target="_blank" rel="noopener noreferrer">Ver más</a></p>
    {% endif %}
  </article>
  {% endfor %}
</div>
{% else %}
<p class="portfolio-empty">Esta sección todavía no tiene imágenes publicadas.</p>
{% endif %}

{% endfor %}
