$(document).ready =>

  {qs, qsa, add, remove, toggle} = require "utils"

  current = 0
  links = qsa '#submenu a'
  progress = qs '#progress'
  sections = qsa '[data-section]'
  
  links.forEach (link) ->
    link.addEventListener "click", () ->
      return unless not window.CSS?.supports("scroll-behavior: smooth")
      target = qs(link.getAttribute "href")
      $("html, body").animate { scrollTop: target.offsetTop }
  
  onscroll = () ->

    y = window.scrollY
    j = current
    
    progress.style.width = (100 * y / (document.body.offsetHeight - window.innerHeight)) + "%"
    
    sections.forEach (s,i) ->
      if y > (s.offsetTop - 10) then j = i

    if j isnt current
      add links[j],"current"
      remove links[current],"current"
      current = j
  
  console.log links
    
    
  window.onscroll = onscroll
  # window.addEventListener "scroll", onscroll
  # document.addEventListener "scroll", onscroll
