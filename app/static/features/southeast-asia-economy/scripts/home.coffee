$(document).ready =>

  {qs, add, remove, toggle} = require "utils"

  gallery = qs ".post-gallery"
  header = qs "header"
  button = qs "#menu-toggle"
  
  y = 0
  yp = 0
  
  toggleMenu = ->
    toggle gallery, "scrolling"

  button.addEventListener "click", toggleMenu
  
  onScroll = () ->
    yp = y
    y = window.scrollY

    if yp < y && y > 50
      add gallery, "scrolling"
    else remove gallery, "scrolling"

  window.onscroll = onScroll
