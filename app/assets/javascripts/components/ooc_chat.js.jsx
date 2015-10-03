var ChatBox = React.createClass({
  loadChatsFromServer: function(){
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
        console.log("data loaded and stuff");
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
        console.log("something happened with the chat loading");
      }.bind(this)
    });
  },
  handleChatSubmit: function(chat) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: chat,
      success: function(data) {
        // this.setState({data: data});
        console.log("sweet, dude, we got your post");
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
        console.log("chat json submit error");
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
    this.loadChatsFromServer();
    setInterval(this.loadChatsFromServer, this.props.pollInterval);
  },
  render: function() {
    return (
      <div>
        <h3>OOC Chat:</h3>
        <ChatList data={this.state.data}/>
        <ChatForm onChatSubmit={this.handleChatSubmit}/>
      </div>
    );
  }
});

var ChatList = React.createClass({
  render: function() {
    var chatNodes = this.props.data.map(function (chat) {
      return (
        <Chat
          key={chat.id}
          author={chat.username}
          text={chat.text}
          timestamp={chat.created_at}
        ></Chat>
      );
    });
    return (
      <div>
        {chatNodes}
      </div>
    );
  }
});

var ChatForm = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    var text = React.findDOMNode(this.refs.text).value.trim();
    if (!text) {
      return;
    }
    this.props.onChatSubmit({chat: {text: text}});
    React.findDOMNode(this.refs.text).value = '';
    return;
  },
  render: function() {
    return (
      <form className="row" onSubmit={this.handleSubmit}>
        <div className="form-group">
          <input className="form-control" type="text" ref="text"/>
          <input className="form-control" type="submit" value="Post" />
        </div>
      </form>
    );
  }
});

var Chat = React.createClass({
  render: function() {
    return (
      <div className="row chat-box">
        <div className="col-xs-12">
          <p>{this.props.text}</p>
        </div>
        <div className="col-xs-12">
          <div>
            <p>
              <strong>{this.props.author}</strong>
              <small>- {this.props.timestamp}</small>
            </p>
          </div>
        </div>
      </div>
    );
  }
});

$(function() {
  var $content = $("#chats-panel");
  if($content.length > 0) {
    var game_id = /games\/(\d+)/.exec(window.location.href)[1];
    var url = "/api/v1/chat.json?game_id=".concat(game_id);
    var pollInterval = 2000;
    React.render(
      <ChatBox url={url} pollInterval={pollInterval}/>,
      document.getElementById("chats-panel")
    );
  }
});
