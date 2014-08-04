class alchemy.models.Edge
    constructor: (edge) ->
        # Merge undefined edgeStyle keys from conf.
        # Works with undefined @edgeStyle
        conf = alchemy.conf
        @id = if edge.id? then edge.id else "#{edge.source}-#{edge.target}"
        @edgeStyle = _.merge(conf.edgeStyle, @edgeStyle)
        @classes = {'active': true} #assign active class to edges by default
        @_rawEdge = edge
        @_d3 = {
            'id': @id
            'source': @_rawEdge.source,
            'target': @_rawEdge.target
            }

        # Add id to source/target's edgelist
        alchemy._nodes["#{edge.source}"].addEdge @id
        alchemy._nodes["#{edge.target}"].addEdge @id

    toPublic: =>
        keys = _.keys(@_rawEdge)
        _.pick(@, keys)

    setProperty: (property, value) =>
        @[property] = value

    setD3Property: (property, value) =>
        @_d3[property] = value
        
