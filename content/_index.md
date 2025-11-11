---
# Leave the homepage title empty to use the site title
title: ''
date: 2025-11-11
type: landing

design:
  # Default section spacing
  spacing: '6rem'

sections:
  - block: resume-biography-3
    id: about
    content:
      # Choose a user profile to display (a folder name within `content/authors/`)
      username: admin
      title: About Me
      text: ''
    design:
      avatar:
        size: medium
        shape: circle
  - block: collection
    id: publications
    content:
      title: Selected Publications
      text: ''
      filters:
        folders:
          - publications
        tag: 'selected'
        exclude_featured: false
    design:
      view: citation
  - block: collection
    id: posts
    content:
      title: Recent Posts
      subtitle: ''
      text: ''
      # Page type to display. E.g. post, talk, publication...
      page_type: blog
      # Choose how many pages you would like to display (0 = all pages)
      count: 5
      # Filter on criteria
      filters:
        folders:
          - blog
        author: ''
        category: ''
        tag: ''
        exclude_featured: false
        exclude_future: false
        exclude_past: false
        publication_type: ''
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: desc
    design:
      # Choose a layout view
      view: article-grid
      columns: 2
  - block: markdown
    id: contact
    content:
      title: Contact
      text: |-
        Feel free to reach out to me at the Department for Work and Organizational Psychology, University of Bern.

        **Email:** francisco.wilhelm@unibe.ch

        **Office:** [University of Bern](http://www.aop.psy.unibe.ch/ueber_uns/personen/fwilhelm/)
    design:
      columns: '2'
---
