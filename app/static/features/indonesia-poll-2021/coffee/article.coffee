$(document).ready =>

  {qs, qsa, add, has, remove, toggle} = require "utils"

  progress = qs "#progress"
  header = qs "header"
  
  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  dh = body.offsetHeight
  y = 0
  yp = 0
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
    dh = body.offsetHeight
  
  onScroll = () ->
    yp = y
    y = window.scrollY
    progress.style.width = (100 * y / (dh - vh)) + "%"

    if yp > y
      add header, "visible"
    else remove header, "visible"
        
  window.onscroll = onScroll
