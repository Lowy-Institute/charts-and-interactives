$(document).ready =>
  
  {qs, qsa, add, remove} = require "utils"

  p = 0
  i = 0

  img = qs '#collage'
  next = qs '#next'
  back = qs '#back'
  line = qs '#divider'
  scale = qs '#scale'
  circles = qs '#circles'
  title = qs '#title-panel'
  question = qs '#question-panel'

  body = document.body
  vh = window.innerHeight

  next.onclick = () -> trigger i+1
  back.onclick = () -> trigger i-1

  trigger = (j) ->
    add body,"slide-#{j}"
    remove body,"slide-#{i}"
    exit i
    enter j
    i = j

  animate = (e) ->
    # p = window.scrollY/vh
    p += 0.02
    img.style.opacity = 1 - (2 * p)
    title.style.opacity = 1 - (2 * p)
    if p > 0.5
      circles.style.opacity = 2 * (p - 0.5)
    if p < 1
      window.requestAnimationFrame animate
    return

  enter = (i) ->
    switch i
      when 0 then next.textContent = "ENTER"
      when 2
        descale = () -> remove scale,"hidden"
        setTimeout descale, 3000

  exit = (i) ->
    switch i
      when 0 then next.textContent = "NEXT"
