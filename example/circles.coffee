{ Template, domify } = window.dynamictemplate
{ random, floor, min } = Math
running = yes

svgns = "http://www.w3.org/2000/svg"


button = (tag, id, value) ->
    tag.$input
        class:'button'
        type:'button'
        id:id
        value:value
        title:id


createCircle = (tag, o) ->
    tag.$tag 'circle', {
        xmlns:svgns
        fill:"none"
        stroke:"rgba(#{o.r},#{o.g},#{o.b},#{o.a})"
        style:"stroke-width:#{o.size}"
        cx:"#{o.x}"
        cy:"#{o.y}"
        r:"#{o.radius}"
    }, step = ->
        setTimeout =>
            @attr 'r', "#{o.radius+=o['+']}"
            if --o.life then step.call(this) else @remove()
        ,60



tplops = schema:5
svg = domify new Template tplops, ->
    tplops.self_closing += " circle"
    tplops.self_closing += " svg"

    @$div class:'controls', ->
        button this, "start", "▸"
        button this, "stop",  "■"
        @$a href:"./circles.coffee", "Source Code"
    @$div class:'canvas', ->
        @$tag 'svg', {
            xmlns:svgns
            version:"1.1"
            height:"100px"
            width:"100px"
            preserveAspectRatio:"none"
            viewBox:"0 0 100 100"
            }, ->
                setInterval =>
                    return unless running
                    createCircle this,
                        '+':(0.00001 + 2 * random())
                        life:floor(5 + 42 * random())
                        radius:floor(3 + 20 * random())
                        size:floor(5 + 10 * random())
                        x:floor(100 * random())
                        y:floor(100 * random())
                        r:floor(255 * random())
                        g:floor(255 * random())
                        b:floor(255 * random())
                        a:min(0.8, 0.01 + random())
                , 200


# initialize

svg.ready ->
    for el in svg.dom
        $('body').append el

    $('#start').live 'click', ->
        console.log "animation paused."
        running = yes

    $('#stop').live 'click', ->
        console.log "animation resumed."
        running = no

console.log 'coffeescript loaded.'
