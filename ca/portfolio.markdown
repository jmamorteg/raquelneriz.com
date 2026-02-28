---
layout: default
lang: ca
title: Portfoli
permalink: /ca/portfolio/
---

# Portfoli

Una selecció de treballs de Raquel Neriz en restauració, conservació i pràctica de kintsugi.

{% for section in site.data.portfolio.sections %}
{% assign section_title = section.title %}
{% case section.id %}
  {% when 'restauracion' %}{% assign section_title = 'Restauració' %}
  {% when 'kintsugi' %}{% assign section_title = 'Kintsugi' %}
  {% when 'mis-obras' %}{% assign section_title = 'Les meves obres' %}
  {% when 'tatuaje' %}{% assign section_title = 'Tatuatge' %}
{% endcase %}

## {{ section_title }} {#{{ section.id }}}

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
    <p><a href="{{ item.link }}" target="_blank" rel="noopener noreferrer">Veure més</a></p>
    {% endif %}
  </article>
  {% endfor %}
</div>
{% else %}
<p class="portfolio-empty">Aquesta secció encara no té imatges publicades.</p>
{% endif %}

{% endfor %}
