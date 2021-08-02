$(document).ready =>
  
  {qs, qsa, add, remove} = require "utils"

  p = 0
  i = 0

  menu = qs '#menu'
  menubtn = qs '#menubtn'
  scale = qs '#scale'
  img = qs '#landing-img'
  title = qs '.title'
  scroller = qs '#scroller'
  controls = qs '#controls'
  question = qs '#question-panel'

  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
  
  
  do ->
    scroll = new LocomotiveScroll({
      el: qs('[data-scroll-container]'),
      smooth: true,
      lerp: 0.15
    })
    scroll.on 'scroll',
      (args) ->
        dy = args.scroll.y
        img.style.opacity = 1 - dy / (vh * 0.8)
        if dy > 0
          console.log 'bing'
          add controls,'compact'
        else
          remove controls,'compact'
        # console.log args
        # # Get all current elements : args.currentElements
        # if typeof args.currentElements['hey'] is 'object'
        #     let progress = args.currentElements['hey'].progress
    return


  # next.onclick = () -> trigger i+1

  enter = (i) ->
    switch i
      when 0 then next.textContent = "ENTER"
      when 2
        descale = () -> remove scale,"hidden"
        setTimeout descale, 3000

  exit = (i) ->
    switch i
      when 0 then next.textContent = "NEXT"
