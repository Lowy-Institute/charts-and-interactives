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
      @data.delay ?= 0

    enter: ->
      
      parent = @el
      data = @data
      
      @lines = qsa ".line", @el
      
      if not @words
        @el.innerHTML = ''
        @lines.forEach (l) ->
          l.textContent.split(' ').forEach (word,i) ->
            e = document.createElement 'span'
            add e, "word"
            e.style.animationDelay = (data.delay + 100*i) + "ms"
            e.textContent = word
            parent.appendChild e
      
      @words = qsa ".word",@el
      add @el, "split"
      
      # repeat = 
      # 
      # @timeout = window.setTimeout =>
      #   @interval = window.setInterval(repeat, @data.duration / total)
      # , @data.delay

    exit: ->
      return unless @words
      console.log "exit", @words
      @words.forEach (w) -> ""

  module.exports = TypeView
