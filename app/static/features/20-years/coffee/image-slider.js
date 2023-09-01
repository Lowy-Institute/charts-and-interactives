const qs = (q) => document.querySelector(q)
const qsa = (q) => document.querySelectorAll(q)

const moveBackgroundSliders = (e) => {
  const scroller = qs("#scroller")
  const sliders = qsa(".background-slider")

  sliders.forEach(el => {
    // get the #scroll-item-x
    const slide = qs(`#scroll-item-${el.dataset.slide}`)
    const nSlides = slide.dataset.nSlides

    // calculate % it has scrolled through the scroller
    let percent = (100 + 100 / (nSlides - 1)) * ((scroller.scrollTop + scroller.offsetTop) - slide.offsetTop) / (nSlides * scroller.offsetHeight)

    // clamp between 0 and 100
    percent = Math.max(Math.min(percent, 100), 0)
    
    // update background-position to 50% x%
    el.style.backgroundPosition = `${percent}% 50%`

    slide.classList[percent > 1 ? "add" : "remove"]("opacity-0")
  })
}


window.addEventListener("load", () => {
  const scroller = qs("#scroller")
  scroller.addEventListener("scroll", moveBackgroundSliders)
})