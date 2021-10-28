$(document).ready =>
  
  {qs, qsa, add, remove, toggle} = require "utils"

  menu = qs '#menu'

  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight

  menu.onclick = () -> 
    toggle body, "menu-open"
