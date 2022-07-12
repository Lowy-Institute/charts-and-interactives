$(document).ready =>

  {qs, qsa, add, has, remove, toggle, rect} = require "utils"

  W_MOBILE = 450
  isHome  = has document.body, "homepage"

  header  = qs "header"
  button  = qs "#menu-toggle"
  title   = qs ".title-block"

  galleryEls = qsa ".post-gallery"
  galleryFxd = qs ".post-gallery.fixed"
  galleryRel = qs ".post-gallery.relative"
  
  body = document.body
  vw   = window.innerWidth
  vh   = window.innerHeight
  th   = title.offsetHeight
  gh   = galleryRel?.offsetHeight

  y = 0
  yp = 0
  my = 80
  
  window.onresize = () ->
    vw = window.innerWidth
    vh = window.innerHeight
    th = title.offsetHeight
    gh = galleryRel?.offsetHeight

  toggleMenu = ->
    toggle galleryFxd, "collapse"
    mobileGalleryScroll galleryFxd.firstElementChild

  button.addEventListener "click", toggleMenu
  
  onScroll = () ->
    yp = y
    y = window.scrollY
    threshold = if isHome then y > th + gh else y > th

    # progress.style.width = (100 * y / (dh - vh)) + "%"

    if threshold
      add header, "invert"
      add galleryFxd, "invert"
    else
      remove header, "invert"
      remove galleryFxd, "invert"


  mobileGalleryScroll = (e) ->
    return unless vw < W_MOBILE

    cx = 0.5 * vw 
    scroller = e.target or e
    items = qsa ".post", scroller
    active = qs ".active", scroller

    target = [...items].find((t) =>
      { left, width } = rect(t)
      return cx > left and cx < left + width
    )
    
    if active isnt target
      if active? then remove active, "active"
      if target? then add target, "active"

  window.onscroll = onScroll

  galleryEls.forEach (g) ->
    scroller = qs ".gallery-inner", g
    mobileGalleryScroll scroller
    scroller.addEventListener "scroll", mobileGalleryScroll
