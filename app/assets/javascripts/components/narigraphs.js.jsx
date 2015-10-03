
var NarigraphBox = React.createClass({
  loadNarigraphsFromServer: function(){
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
        console.log("something happened with the narigraph loading");
      }.bind(this)
    });
  },
  handleNarigraphSubmit: function(narigraph) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: narigraph,
      success: function(data) {
        // this.setState({data: data});
        console.log("sweet, dude, we got your post");
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
        console.log("narigraph json submit error");
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
    this.loadNarigraphsFromServer();
    setInterval(this.loadNarigraphsFromServer, this.props.pollInterval);
  },
  render: function() {
    return (
      <div>
        <h1>Gameplay Log</h1>
        <NarigraphList data={this.state.data}/>
        <NarigraphForm onNarigraphSubmit={this.handleNarigraphSubmit}/>
      </div>
    );
  }
});

var NarigraphList = React.createClass({
  render: function() {
    var narigraphNodes = this.props.data.map(function (narigraph) {
      var timestamp = moment(narigraph.created_at).format("MMM D h:mm a");
      return (
        <Narigraph
          key={narigraph.id}
          author={narigraph.character_name}
          text={narigraph.text}
          timestamp={timestamp}
        ></Narigraph>
      );
    });
    return (
      <div>
        {narigraphNodes}
      </div>
    );
  }
});

var NarigraphForm = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    var text = React.findDOMNode(this.refs.text).value.trim();
    if (!text) {
      return;
    }
    this.props.onNarigraphSubmit({narigraph: {text: text}});
    React.findDOMNode(this.refs.text).value = '';
    return;
  },
  render: function() {
    return (
      <form className="narigraphForm" onSubmit={this.handleSubmit}>
       <div className="form-group">
        <textarea className="form-control" type="text" placeholder="What do you do?" ref="text" rows="3"/>
        <input type="submit" value="Post" className="form-control btn btn-default"/>
        </div>
      </form>
    );
  }
});

var Narigraph = React.createClass({
  render: function() {
    return (
      <div className="bold-narigraph">
        <div className="row">
          <div className="col-xs-12">
            <p className="message">{this.props.text}</p>
          </div>
            <div className="col-xs-12">
              <div className="pull-right">
                <p>
                  <strong>- {this.props.author}</strong>
                  <small>{this.props.timestamp}</small>
                </p>
              </div>
          </div>
        </div>
      </div>
    );
  }
});

$(function() {
  var $content = $("#narigraphs-panel");
  if($content.length > 0) {
    var game_id = /games\/(\d+)/.exec(window.location.href)[1];
    var url = "/api/v1/narigraphs.json?game_id=".concat(game_id);
    var pollInterval = 2000;
    React.render(
      <NarigraphBox url={url} pollInterval={pollInterval}/>,
      document.getElementById("narigraphs-panel")
    );
  }
});
