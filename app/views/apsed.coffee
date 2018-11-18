{ colors, font } = require("data/theme")

utils =
  toPercent: (n, d = 0) -> "#{(n * 100).toFixed(d)}%"
  toThousands: (n, d = 0) -> n.toFixed(d).replace(/\B(?=(\d{3})+(?!\d))/g, ",")

module.exports =
  class Chart extends Backbone.View
    data: window.chart
    events:
      "input select": "onSelection"

    onSelection: (e) ->
      @render _.find(@data.agencies, name: e.target.value)

    initialize: ->
      @listenTo this, "resize", @onResize
      @onResize()

    onResize: ->
      width = Math.min(900, @$el.width())
      buffer = 8
      labelW = 48

      @config =
        w: width
        h: 360
        duration: 400
        labelW: labelW
        buffer: buffer
        barsH: 20
        barsW: (width - labelW) / 3 - buffer / 1.5
        barsX: labelW
        barsY: 48

      @paper ?= window.Snap(@$(".chart").get(0), @config.w, @config.h)

      @render _.find(@data.agencies, name: @$("select").val())

    createLegend: (data) ->
      for year, i in @data.axis
        y = @config.barsY + i * @config.barsH + @config.buffer * i
        @paper.text(0, y + (@config.barsH / 2 + 5), year).attr(font.style.labelLeft)

      @levels = Snap.set()
      for key, i in _.keys(data)
        nb = @data.axis.length
        x = @config.barsX + (@config.barsW + @config.buffer) * i + @config.barsW / 2
        y = @config.barsY + nb * @config.barsH + @config.buffer * nb
        line = @paper.line(x, @config.barsY - @config.buffer, x, y)
        line.attr(stroke: "#e1e5e8")
        text = @paper.text(x, y + @config.buffer + 8, key)
        text.attr(font.style.labelMiddle)
        @levels.push Snap.set(line, text)

      mbox = @paper.rect(@config.w - 20, 6, 20, 20)
      mtxt = @paper.text(@config.w - 28, 21, "Male Staff").data("label": "Male Staff")
      fbox = @paper.rect(@config.w - 180, 6, 20, 20)
      ftxt = @paper.text(@config.w - 188, 21, "Female Staff").data("label": "Female Staff")

      ftxt.attr(font.style.labelRight)
      mtxt.attr(font.style.labelRight)

      fbox.attr("fill": colors.highlight, "stroke": "none")
      mbox.attr("fill": colors.dark, "stroke": "none")

      @legend = Snap.set(ftxt, mtxt)


    render: ({name, data}) ->
      ease = mina.easeinout

      if not @bars
        @createLegend(data)

      @bars ?= {}

      for key, j in _.keys(data)
        list = data[key]
        x = @config.barsX + j * (@config.barsW + @config.buffer)
        cx = x + @config.barsW / 2

        @bars[key] ?= []
        @levels.items[j].animate({x: cx, x1: cx, x2: cx}, @config.duration, ease)

        for [f, m], i in list
          y = @config.barsY + i * @config.barsH + @config.buffer * i
          empty = false

          if not f?
            empty = true
            ff = mf = 0

          else if not m?
            ff = f / 100
            mf = 1 - ff

          else
            ff = if f is 0 then 0 else f / (m + f)
            mf = if m is 0 then 0 else m / (m + f)

          if @bars[key][i]
            {bg, set} = @bars[key][i]
            [fr, mr] = set.children()

            if ff + mf > 0
              fr.stop().animate({opacity: 1, width: ff * @config.barsW, x}, @config.duration, ease)
              mr.stop().animate({opacity: 1, width: mf * @config.barsW, x: x + ff * @config.barsW}, @config.duration, ease)
            else
              fr.stop().animate({opacity: 0}, @config.duration, ease)
              mr.stop().animate({opacity: 0}, @config.duration, ease)

            if not f?
              bg.stop().animate({x, width: @config.barsW, fill: colors.muted}, @config.duration, ease)
            else
              bg.stop().animate({x, width: @config.barsW, fill: "#b6c1c6"}, @config.duration, ease)

          else
            bg = @paper.rect(x, y, @config.barsW, @config.barsH)
            fr = @paper.rect(x, y, ff * @config.barsW, @config.barsH)
            mr = @paper.rect(x + ff * @config.barsW, y, mf * @config.barsW, @config.barsH)
            set = @paper.group(fr, mr)
            @bars[key].push({ set, bg })
            bg.attr(fill: colors.muted, stroke: "none")
            fr.attr(fill: colors.highlight, stroke: "none")
            mr.attr(fill: colors.dark, stroke: "none")

            @bindMouseEvents(set)

          fr.data(value: f)
          mr.data(value: m)
          set.data({ff, mf, empty})

    bindMouseEvents: (set) ->
      ease = mina.easeinout

      set.mouseover =>
        f = set[0].data("value")
        m = set[1].data("value")

        return if set.data("empty")

        window.clearTimeout @timeout

        [fl, ml, bl] = @legend.items

        if f? and m?
          fl.attr({text: """
            #{utils.toThousands(f)} Women
            (#{utils.toPercent(set.data("ff"))})
          """})
          ml.attr({text: """
            #{utils.toThousands(m)} Men
            (#{utils.toPercent(set.data("mf"))})
          """
        else if set.data("ff")?
          fl.attr text: """
            Women (#{utils.toPercent(set.data("ff"))})
          """
          ml.attr text: """
            Men (#{utils.toPercent(1 - set.data("ff"))})
          """

        for key, bars of @bars
          for bar in bars when bar.set isnt set
            bar.set
              .stop()
              .animate({opacity: 0.5}, @config.duration, ease)

      set.mouseout =>
        for key, bars of @bars
          for bar in bars
            bar.set.stop().animate({opacity: 1}, @config.duration, ease)

        window.clearTimeout @timeout
        @timeout = window.setTimeout =>
          for el, i in set.children()
            @legend.items[i].attr({text: @legend.items[i].data("label")})

          # @legend.items[2].attr(text: @legend.items[2].data("label"))
        , 300
