$(document).ready =>
  
  {qs, qsa, add, remove, toggle} = require "utils"

  logo = qs '#logo'
  titles = qs '#titles'
  img = qs '#landing-img'
  scrollbtn = qs '#scroll-button'

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
        my = args.limit.y
        dy = args.scroll.y
        
        img.style.opacity = 1 - dy / (vh * 0.8)
        titles.style.opacity = 1 - dy / (vh * 0.4)
        
        if dy / vh > 1.3
          logo.style.opacity = 1
          scrollbtn.style.opacity = 1

        else
          logo.style.opacity = 0
          
        if dy is my
          scrollbtn.style.opacity = 0
      
      scrollbtn.onclick = () -> scroll.scrollTo qs("#slide-3"), {duration: 500}
    return
