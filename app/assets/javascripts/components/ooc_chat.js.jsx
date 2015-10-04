var ChatBox = React.createClass({
  loadChatsFromServer: function(){
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  optimisticUpdateData: function(chat) {
    var chats = this.state.data;
    chat.username = window.user.username;
    var newChats = chats.concat([chat]);
    this.setState({data: newChats});
  },
  handleChatSubmit: function(chat) {
    this.optimisticUpdateData(chat);
    chat = {chat:{text:chat.text}};
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
  snapToBottom: function(scrollingElement){
    setTimeout(function() {
      scrollingElement.scrollTop(scrollingElement[0].scrollHeight);
    }, 1);
  },
  componentDidUpdate: function(prevProps, prevState) {
    if (this.state.data.length != prevState.data.length){
      this.snapToBottom($('.chat-list'));
    }
  },
  render: function() {
    return (
      <div className="chat-component">
        <h3>Chat:</h3>
        <ChatList data={this.state.data}/>
        <ChatForm onChatSubmit={this.handleChatSubmit}/>
      </div>
    );
  }
});

var ChatList = React.createClass({
  render: function() {
    var chatNodes = this.props.data.map(function (chat) {
      var timestamp = moment(chat.created_at).format("MMM D, h:mm a");
      return (
        <div>
          <Chat
            key={chat.id}
            author={chat.username}
            text={chat.text}
            timestamp={timestamp}
          ></Chat>
        </div>
      );
    });
    return (
      <div className="chat-list">
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
    this.props.onChatSubmit({text: text});
    React.findDOMNode(this.refs.text).value = '';
    return;
  },
  render: function() {
    return (
      <form onSubmit={this.handleSubmit}>
        <div className="form-group">
          <textarea className="form-control chat-textarea" type="text" ref="text" rows="2" placeholder="Chat out of character"/>
          <input className="form-control" type="submit" value="Post" />
        </div>
      </form>
    );
  }
});

var Chat = React.createClass({
  render: function() {
    return (
      <div className="chat-box">
          <p>{this.props.text}</p>
          <div>
            <p className="salutation">
              <strong>{this.props.author}</strong>
              <small>{this.props.timestamp}</small>
            </p>
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
