$(document).ready =>

  {qs, qsa, add, has, remove, toggle} = require "utils"

  progress = qs "#progress"
  
  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  dh = body.offsetHeight
  
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
    dh = body.offsetHeight
  
  onScroll = () ->
    y = window.scrollY
    progress.style.width = (100 * y / (dh - vh)) + "%"
    
  
  window.onscroll = onScroll
