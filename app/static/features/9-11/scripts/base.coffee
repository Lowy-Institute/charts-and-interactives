$(document).ready =>
  
  {qs, qsa, add, remove, toggle} = require "utils"

  menu = qs '#menu'
  modal = qs '#menu-modal'
  btn = qs '#menu-button'
  btnarr = qs '#menu-button g'
  btntxt = qs '#menu-button .word'

  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight

  btn.onclick = () -> 
    if not body.classList.contains "landing"
      toggle menu,"collapsed"
      toggle modal,"hidden"
      btntxt.textContent = if btntxt.textContent is "menu" then "close" else "menu"      
