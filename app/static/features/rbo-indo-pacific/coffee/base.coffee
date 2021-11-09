$(document).ready =>
  
  {qs, qsa, add, has, remove, toggle} = require "utils"

  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  dh = body.offsetHeight
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
    dh = body.offsetHeight
  
  window.onscroll = () ->

    y = window.scrollY
    
    if has body,"landing"
      p = 100 * ((y - vh) / (dh - 2 * vh))
    else
      p = 100 * y / (dh - vh)
    
    progress.style.width = p + "%"
