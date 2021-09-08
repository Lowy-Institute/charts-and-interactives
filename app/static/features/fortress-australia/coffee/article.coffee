$(document).ready =>

  {qs, qsa, add, has, remove, toggle} = require "utils"

  progress = qs "#progress"
  header = qs "header"
  
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
    
    if y > 0 and y < (dh - vh - 140)
      if not has header, "visible" 
        add header, "visible"
    else if has header, "visible"
        remove header, "visible"
    
  
  window.onscroll = onScroll
