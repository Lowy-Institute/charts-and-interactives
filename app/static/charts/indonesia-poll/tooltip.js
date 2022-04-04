const qs = (s) => document.querySelector(s)
const qsa = (s) => document.querySelectorAll(s)
const add = (el, c) => el.classList.add(c)
const rm = (el, c) => el.classList.remove(c)

let vw, vh

const uppers =
  /^([A-Z]{2,}|University|Australian*|China|Chinese|United States|India|Indonesia[n]*|Russia|Japan[ese]*|English|Taiwan[ese]*|Hong Kong|North Korea[n]*|United Kingdom|Xi|Jacinda|Vladimir|Scott|Boris|Anthony|Kim|Joko|Narendra|G20|Malaysia|Singapore|Netherlands|Saudi Arabia[n]*|United Arab Emirates|Tentara|Badan|Kementerian|Kepolisian)\b/

const formatPhrase = (str) => {
  return str
    .trim()
    .replace(/COVID-19/g, "Covid-19")
    .replace(/Joe Biden/g, "Joe&nbsp;Biden")
    .replace(/^Jacinda Ardern$/g, "New Zealand Prime Minister Jacinda Ardern")
    .replace(/^Scott Morrison$/g, "Australian Prime Minister Scott Morrison")
    .replace(/^Boris Johnson$/g, "UK Prime Minister Boris Johnson")
    .replace(
      /^Anthony Albanese$/g,
      "Australian Opposition leader Anthony Albanese"
    )
    .replace(/^Xi Jinping$/g, "Chinese President Xi&nbsp;Jinping")
    .replace(/^Kim Jong-Un$/g, "North Korean leader Kim Jong-un")
    .replace(/^Joko Widodo$/g, "Indonesian President Joko Widodo")
    .replace(/^Vladimir Putin$/g, "Russian President Vladimir Putin")
    .replace(/^Narendra Modi$/g, "Indian Prime Minister Narendra Modi")
    .replace(/^US$/g, "United States")
    .replace(/^UK$/g, "United Kingdom")
    .replace(/(^United States|^United Kingdom|^media)/, "the $1")
    .replace(/^Cyber attacks/g, "Cyberattacks")
}

const caseify = (str) =>
  str.match(uppers) ? str : str.charAt(0).toLowerCase() + str.slice(1)

const setPhrase = (el, phrase) => {
  const data = el.dataset
  el.dataset.phrase = formatPhrase(
    phrase
      .replace("{{variant}}", variant(data.response))
      .replace("{{response}}", caseify(data.response))
      .replace("{{category}}", caseify(data.category))
      .replace("{{value}}", data.value)
  )
}

const startTooltip = (e) => {
  add(tooltip.element, "active")
  tooltip.element.textContent = e.target.dataset.phrase
}

const moveTooltip = (e) => {
  let x = e.clientX
  let y = e.clientY
  let tt = tooltip.element

  if (x > vw - 150) {
    add(tt, "left")
    rm(tt, "right")
  } else if (x < 150) {
    add(tt, "right")
    rm(tt, "left")
  } else {
    rm(tt, "left")
    rm(tt, "right")
  }

  tt.style.top = `${y}px`
  tt.style.left = `${x}px`
}

const hideTooltip = () => {
  rm(tooltip.element, "active")
}

const initialise = () => {
  tooltip.targets.forEach((el) => setPhrase(el, phrase))
  tooltip.listeners.forEach((ev) => {
    document.addEventListener(
      ev.event,
      (e) => {
        if (e.target.dataset?.tooltip !== undefined) ev.fn(e)
      },
      true
    )
  })
}

const tooltip = {
  initialise,
  element: qs(".tooltip"),
  targets: qsa("[data-tooltip]"),
  listeners: [
    { event: "pointerenter", fn: startTooltip },
    { event: "pointermove", fn: moveTooltip },
    { event: "touchmove", fn: moveTooltip },
    { event: "pointerleave", fn: hideTooltip },
  ],
}

const resize = () => {
  vw = window.innerWidth
  vh = window.innerHeight
}

window.addEventListener("resize", resize)
window.addEventListener("DOMContentLoaded", () => {
  tooltip.initialise()
  resize()
})
