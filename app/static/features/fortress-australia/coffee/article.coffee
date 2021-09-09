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
    
    if vw >= 1000
      if y < (dh - vh - 140)
        if not has header, "visible"
          add header, "visible"
      else
        remove header, "visible"

    if vw < 1000
      if yp > y
        add header, "visible"
      else remove header, "visible"
        
  
  window.onscroll = onScroll
