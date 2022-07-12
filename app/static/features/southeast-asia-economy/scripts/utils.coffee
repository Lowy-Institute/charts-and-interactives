require.register "utils", (exports, require, module) ->
  module.exports =

    qs:  (q, p = document) -> p.querySelector q
    qsa: (q, p = document) -> p.querySelectorAll q

    add:    (e,c) -> e.classList.add(c)
    has:    (e,c) -> e.classList.contains(c)
    remove: (e,c) -> e.classList.remove(c)
    toggle: (e,c) -> e.classList.toggle(c)

    rect: (e) ->  e.getBoundingClientRect()