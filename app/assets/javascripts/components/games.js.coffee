@Games = React.createClass
  getInitialState: ->
    games: @props.data
  getDefaultProps: ->
    games: []
  render: ->
    React.DOM.div
      className: 'games'
      React.DOM.h2
        className: 'users.first'
        'ALL GAMES'
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'GM'
            React.DOM.th null, 'Start Date'
            React.DOM.th null, 'Players'
          React.DOM.tbody null,
            for game in @state.games
              React.createElement Game, key: game.id, game: game
