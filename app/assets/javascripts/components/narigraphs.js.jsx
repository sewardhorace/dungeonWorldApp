
var NarigraphBox = React.createClass({
  loadNarigraphsFromServer: function(){
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
        <NarigraphForm />
      </div>
    );
  }
});

var NarigraphList = React.createClass({
  render: function() {
    var narigraphNodes = this.props.data.map(function (narigraph) {
      return (
        <Narigraph key={narigraph.id} author={narigraph.character_id}>
          {narigraph.text}
        </Narigraph>
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
  render: function() {
    return (
      <div>
        Hello, world! I am eventually going to be a form.
      </div>
    );
  }
});

var Narigraph = React.createClass({
  render: function() {
    return (
      <div>
        <h2>
          {this.props.author}
        </h2>
        {this.props.children}
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
