$(document).ready =>

  {qs, qsa, add, has, remove, toggle} = require "utils"

  current = 0
  next = qs '#next'
  links = qsa '#submenu a'
  progress = qs '#progress'
  sections = qsa '[data-section]'
  
  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  dh = body.offsetHeight

  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
    dh = body.offsetHeight
  
  links.forEach (link) ->
    link.addEventListener "click", () ->
      return unless not window.CSS?.supports("scroll-behavior: smooth")
      target = qs(link.getAttribute "href")
      $("html, body").animate { scrollTop: target.offsetTop }
  
  onscroll = () ->

    y = window.scrollY
    j = current
    
    progress.style.width = (100 * y / (dh - vh)) + "%"
    
    sections.forEach (s,i) ->
      if y > (s.offsetTop - 200) then j = i

    if j isnt current
      add links[j],"current"
      remove links[current],"current"
      current = j
      
    if y > (dh - 2 * vh)
      add next, "visible"
    else if has next, "visible"
      remove next, "visible"

  window.onscroll = onscroll
