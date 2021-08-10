$(document).ready =>

  {qs, qsa, add, remove, toggle} = require "utils"

  current = 0
  links = qsa '#submenu a'
  sections = qsa '[data-section]'
  
  window.onscroll = onscroll
  window.addEventListener "scroll", onscroll
  document.addEventListener "scroll", onscroll
  
  links.forEach (link) ->
    link.addEventListener "click", () ->
      return unless not window.CSS?.supports("scroll-behavior: smooth")
      target = qs(link.getAttribute "href")
      $("html, body").animate { scrollTop: target.offsetTop }
  
  onscroll = () ->
    console.log current
    y = window.scrollY
    j = current
    sections.forEach (s,i) ->
      if s.offsetTop > y then j = i

    if j isnt current
      add submenu[j],"current"
      remove submenu[current],"current"
      current = j
  
  console.log links
    
    
