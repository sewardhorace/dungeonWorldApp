@Game = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.game.id#users.first.username
      React.DOM.td null, @props.game.created_at
      React.DOM.td null, @props.game.players#.count
