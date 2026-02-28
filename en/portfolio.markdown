---
layout: default
lang: en
title: Portfolio
permalink: /en/portfolio/
---

# Portfolio

A selection of Raquel Neriz's work in restoration, conservation and kintsugi practice.

{% for section in site.data.portfolio.sections %}
{% assign section_title = section.title %}
{% case section.id %}
  {% when 'restauracion' %}{% assign section_title = 'Restoration' %}
  {% when 'kintsugi' %}{% assign section_title = 'Kintsugi' %}
  {% when 'mis-obras' %}{% assign section_title = 'Artworks' %}
  {% when 'tatuaje' %}{% assign section_title = 'Tattoo' %}
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
    <p><a href="{{ item.link }}" target="_blank" rel="noopener noreferrer">See more</a></p>
    {% endif %}
  </article>
  {% endfor %}
</div>
{% else %}
<p class="portfolio-empty">No images published in this section yet.</p>
{% endif %}

{% endfor %}
