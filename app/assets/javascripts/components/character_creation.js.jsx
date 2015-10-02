
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
    var klass = this.state.data[0]
    console.log(klass);
    return (
      <div>
        <h3>name</h3>
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
