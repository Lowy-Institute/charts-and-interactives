require.register "views/type", (exports, require, module) ->

  {qs, qsa, add, remove} = require "utils"
  easie = require("lib/easie")

  empty = ([0..4]).reduce ((m)-> m + "\u200b"), ""
  strip = (str) -> str.replace(/(\u200b)+$/,"")

  class TypeView extends Backbone.View
    events:
      "enter": "enter"
      "exit": "exit"

    initialize: (@data) ->
      @data.duration ?= 2000
      @data.stagger ?= 100
      @data.delay ?= 0
      @split()
      
    split: ->
      parent = @el
      data = @data
      
      @lines = qsa ".line", @el

      if not @words
        @el.innerHTML = ''
        @lines.forEach (l) ->
          l.textContent.split(' ').forEach (word,i) ->
            e = document.createElement 'span'
            add e, "word"
            e.style.animationDelay = (data.delay + i*data.stagger) + "ms"
            e.textContent = word
            parent.appendChild e

      @words = qsa ".word",@el

    enter: ->
      @shown = true
      if @data.callback is 'showScale' then @showScale()

    showScale: ->
      scale = qs "#scale-wrap"
      wait = @data.delay + @words.length * @data.stagger
      
      callback = () ->
        remove scale,"hidden"

      setTimeout callback, wait

    exit: ->
      return unless @shown and @data.norepeat?
      @words.forEach (w) ->
        w.style.animationDelay = '0s'
        w.style.animationDuration = '0s'

  module.exports = TypeView
