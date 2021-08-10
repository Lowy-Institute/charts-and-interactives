$(document).ready =>
  
  {qs, qsa, add, remove, toggle} = require "utils"

  logo = qs '#logo'
  title = qs '#title'
  img = qs '#landing-img'
  scrollbtns = qsa '.scroll-button'
  scrolled = false

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
      smartphone: {
        smooth: true
      },
      tablet: {
        smooth: true
      },
      lerp: 0.15
    })
    
    scroll.on 'scroll',
      (args) ->
        my = args.limit.y
        dy = args.scroll.y
        
        img.style.opacity = 1 - dy / (vh * 0.8)
        title.style.opacity = 1 - dy / (vh * 0.4)
        
        if !scrolled and dy > 0
          add scrollbtns[0], "disabled"

        if dy / vh > 1.3
          logo.style.opacity = 1
          remove scrollbtns[1], "disabled"

        else
          logo.style.opacity = 0
          
        if dy is my
          add scrollbtns[1], "disabled"
      
      scrollbtns[0].onclick = () -> scroll.scrollTo qs("#slide-2"), {duration: 2000, easing: [0.25,0.46,0.45,0.94]}
      scrollbtns[1].onclick = () -> scroll.scrollTo qs("#slide-3"), {duration: 500}

    return
