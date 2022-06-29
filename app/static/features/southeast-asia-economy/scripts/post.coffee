$(document).ready =>

  {qs, qsa, add, has, remove, toggle} = require "utils"

  gallery = qs ".post-gallery"
  header = qs "header"
  button = qs "#menu-toggle"
  title = qs ".title-block"
  
  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  th = title.offsetHeight

  y = 0
  yp = 0
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
    th = title.offsetHeight

  toggleMenu = ->
    toggle gallery, "active"

  button.addEventListener "click", toggleMenu
  
  onScroll = () ->
    yp = y
    y = window.scrollY
    # progress.style.width = (100 * y / (dh - vh)) + "%"

    if y > th
      add header, "invert"
    else remove header, "invert"

  window.onscroll = onScroll
