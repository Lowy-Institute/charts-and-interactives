$(document).ready =>
  
  {qs, qsa, add, remove, toggle} = require "utils"

  menu = qs '#menu-modal'
  menubtn = qs '#menu-button'

  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight

  menubtn.onclick = () -> 
    if not body.classList.contains "landing"
      toggle menu,"hidden"
