$(document).ready =>
  
  {qs, qsa, add, has, remove, toggle} = require "utils"
  
  current = 0
  
  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  dh = body.offsetHeight
  
  links = qsa '#page-menu .links a'
  social = qs '#socials'
  sections = Array.from(links).map((l) -> qs(l.getAttribute "href"))
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
    dh = body.offsetHeight
    
  links.forEach (link) ->
    link.addEventListener "click", () ->
      return unless not window.CSS?.supports("scroll-behavior: smooth")
      target = qs(link.getAttribute "href")
      $("html, body").animate { scrollTop: target.offsetTop }
  
  window.onscroll = () ->

    j = current
    y = window.scrollY
    
    if has body,"landing" 
      p = 100 * ((y - vh) / (dh - 2 * vh))
    else p = 100 * y / (dh - vh)
    
    progress.style.width = p + "%"
    
    sections.forEach (s,i) ->
      if y > (s.offsetTop - 200) then j = i

    if j isnt current
      add links[j],"active"
      remove links[current],"active"
      current = j
      
    if y > 10 and not has social, "invert"
      add social, "invert"
    else if y < 10 and has social, "invert"
      remove social, "invert"
