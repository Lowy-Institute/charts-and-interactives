require.register "views/scroller", (exports, require, module) ->
  easie = require("lib/easie")
  utils = require("lib/utils")

  class ScrollerView extends Backbone.View
    events:
      "show": "onShow"
      "hide": "onHide"

    initialize: ->
      @data = @$el.data()

      @data.slideHeights = $(".scroll-item").map (i, e) => +e.dataset.nSlides

      @data.support = window.CSS?.supports("scroll-snap-type: y mandatory")

      @$elements =
        pager: $(@$el.data("pager"))
        index: $(@$el.data("index"))

      timeout = null

      $("#btn-prev").click (e) => @onPrev(e)
      $("#btn-next").click (e) => @onNext(e)

      @$el.on("scroll", (e) =>
        @onScroll()
        window.clearTimeout timeout
        timeout = window.setTimeout =>
          @onScrollEnd()
        , if @data.support then 10 else 300
      )

      timeout = window.setTimeout =>
        @onScrollEnd()
      , 1

    # sum heights array sequentially until sum > index
    # index should be set to the interator value minus 1
    # this is to allow for slides with over 100% height
    getIndex: (index) -> 
      j = 0
      aggregate = 0

      while aggregate <= index
        aggregate += @data.slideHeights[j]
        j++

      return j - 1

    sum: (arr) -> if arr.length then arr.reduce((a,b) => a + b) else 0

    onScroll: ->
      i  = Math.floor @el.scrollTop / @el.offsetHeight
      i2 = Math.floor @el.scrollTop / @el.offsetHeight + 0.5

      i = @getIndex i
      i  -= @data.min

      i2 = @getIndex i2
      i2 = Math.max(Math.min(i2, @data.max), @data.min)

      n = @data.slideHeights[i2]

      cumulativeSlideHeights = @sum @data.slideHeights.get().slice(0, i2)
      slideOffsetTop = @el.offsetHeight * cumulativeSlideHeights

      if (slideOffsetTop > @el.scrollTop)
        cumulativeSlideHeights = @sum @data.slideHeights.get().slice(0, i2 - 1)
        slideOffsetTop = @el.offsetHeight * cumulativeSlideHeights
        n = @data.slideHeights[i2 - 1]

      t1 = ((@el.scrollTop - slideOffsetTop) / (n * @el.offsetHeight)) % 1
      t2 = Math.sin(Math.PI * t1)

      if t1 < 0.5 and i < 0
        t2 = 1

      w = t2
      x = if t1 > 0.5 then (1-t2) else 0
      k = 0

      if i < 0
        k = 2
        x -= k
        w += k

      @$elements.index.html(i2)
      @$elements.pager.css "transform": "translateX(#{i * 200}%)"

      @$elements.pager.children().eq(0).css
        "transform": "translate3d(#{x * 400 + k * (1-t2) * 400}%, 0, 0)"

      @$elements.pager.children().eq(1).css
        "transform": "translate3d(#{-4 + x * 100 + k * (1-t2) * 100}%, 0, 0) scale(#{t2 * (k + 1) + 0.1}, 1)"

      @$elements.pager.children().eq(2).css
        "transform": "translate3d(#{(x + w) * 400}%, 0, 0)"

    onScrollEnd: ->
      index = Math.floor @el.scrollTop / @el.offsetHeight + 0.5
      index = @getIndex index

      unless @data.support
        @scrollTo(index)

      if index isnt @data.i
        # Somehow getting caught here in the class change??
        $("body")
          .addClass("page-#{index}")
          .removeClass("page-#{@data.i}")

        _.extend @data,
          y: @el.scrollTop
          h: @el.offsetHeight
          i: index

        for child, i in @el.children
          child.classList.toggle("active", i is @data.i)
          $("[data-view]", child).trigger(
            if i is @data.i then "show" else "hide"
          )

        window.ga?("send", "event", "Scroller", "show", document.title, index)

    onPrev: ->
      index = Math.floor @el.scrollTop / @el.offsetHeight + 0.5
      @scrollTo(index - 1)

    onNext: ->
      index = Math.floor @el.scrollTop / @el.offsetHeight + 0.5
      @scrollTo(index + 1)

    scrollTo: (i) ->
      @$el.addClass("scrolling")
      @$el.scrollTo i * @el.offsetHeight, =>
        @$el.removeClass("scrolling")

  module.exports = ScrollerView
