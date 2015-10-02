
var NewCharacterBox = React.createClass({
  loadKlassesFromServer: function(){
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
        console.log("something happened with the klass loading");
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
    this.loadKlassesFromServer();
    setInterval(this.loadKlassesFromServer, this.props.pollInterval);
  },
  render: function() {
    return (
      <div>
        <h3>Options:</h3>
        <DumbThing data={this.state.data}/>
      </div>
    );
  }
});

var DumbThing = React.createClass({
  render: function() {
    var klassNodes = this.props.data.map(function (klass) {
      return (
        <div>
          <h3>{klass.name}</h3>
          <div>{klass.klass_data.name}</div>
        </div>
      );
    });
    return (
      <div>
        {klassNodes}
      </div>
    );
  }
});

$(function() {
  var $content = $("#new-character-panel");
  if($content.length > 0) {
    var url = "/api/v1/klasses.json";
    var pollInterval = 2000;
    React.render(
      <NewCharacterBox url={url} pollInterval={pollInterval}/>,
      document.getElementById("new-character-panel")
    );
  }
});
