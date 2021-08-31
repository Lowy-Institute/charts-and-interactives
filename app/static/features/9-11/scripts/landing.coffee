$(document).ready =>
  
  {qs, qsa, add, remove, toggle} = require "utils"

  pdf = qs '#pdf'
  logo = qs '#logo'
  title = qs '#title'
  credits = qs '#credits'
  img = qs '#landing-img'
  scrollbtns = qsa '.scroll-button'
  scrollbtn = qs '[scroll-to-menu]'
  scrolled = false

  body = document.body
  vw = window.innerWidth
  vh = window.innerHeight
  isMobile = vw <= 800
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
    isMobile = vw <= 800

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
      pdf.style.opacity = 1 - dy / (vh * 0.4)
      title.style.opacity = 1 - dy / (vh * 0.4)
      credits.style.opacity = 1 - dy / (vh * 0.4)
      
      if dy > 0
        add title, "no-ptr"

      if not isMobile
        if dy / vh > .1 then add scrollbtns[0], "disabled"
        else remove scrollbtns[0], "disabled"
        
      if dy / vh > .5
        if isMobile or dy / vh > 1.3
          logo.style.opacity = 1
          remove scrollbtns[1], "disabled"  
          
      else
        logo.style.opacity = 0
        if isMobile
          add scrollbtns[1], "disabled"
        
      if dy is my
        add scrollbtns[1], "disabled"
    
    scrollbtns[0].onclick = () -> scroll.scrollTo qs("#slide-2"), {duration: 4500, easing: [0.1,0.75,0.9,0.25]}
    scrollbtns[1].onclick = () -> scroll.scrollTo qs("#slide-3"), {duration: 500}
    
    scrollbtn.onclick = () -> scroll.scrollTo qs("#slide-3"), {duration: 500}

  
  update = () ->
    scroll.update()
  
  fold = (d,n) ->
    els = qsa 'p',d
    offset = els[0].offsetTop
    target = els[n].offsetTop
    d.style.maxHeight = target - offset + 5 + "px"
    update()
    
  unfold = (e) ->
    els = qsa '[fold] p'
    top = els[ els.length - 1 ].offsetTop
    target = qs("[fold]")
    target.style.maxHeight = top + target.offsetHeight + "px"
    e.target.style.display = 'none'
    setTimeout(update, 400)
    
  fold(qs("[fold]"),1)
  qs("[unfold]").addEventListener "click", unfold
