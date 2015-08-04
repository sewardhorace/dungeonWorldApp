@UserForm = React.createClass
  getInitialState: ->
    username: ''
    email: ''
    password: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.username && @state.email && @state.password
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { user: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    ,'JSON'
    
  render: ->
    React.DOM.form
      className: 'form-inline'
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Email'
          name: 'email'
          value: @state.email
          onChange: @handleChange
      React.DOM.input
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Username'
          name: 'username'
          value: @state.username
          onChange: @handleChange
      React.DOM.input
        className: 'form-group'
        React.DOM.input
          type: 'password'
          className: 'form-control'
          placeholder: 'Password'
          name: 'password'
          value: @state.password
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Sign Up'
