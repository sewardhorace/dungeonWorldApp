
var NewCharacterBox = React.createClass({
  render: function() {
    return (
      <div>
        <h3>Class name</h3>
        <KlassNames data={this.state.data.names}/>
      </div>
    );
  }
});

var KlassNames = React.createClass({
  render: function(){
    var RaceNameNodes = this.props.data.map(function (race) {
      return (
        <RaceNames
          <ul>
          <em>race.name</em>
          <li>somethingsilly</li>
          </ul>

        ></RaceNames>
      );
    });
    return(
      <div>
        {RaceNameNodes}
      </div>
    );
  }
});

$(function() {
  var $content = $("#new-character-panel");
  var klass = {name:"generic", names:["ill","mike D", "mca"]};
  var data = [klass];
  if($content.length > 0) {
    React.render(
      <NewCharacterBox data={data}/>,
      document.getElementById("new-character-panel")
    );
  }
});
