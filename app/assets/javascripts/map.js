$.ajax({
  type: "GET",
contentType: "application/json; charset=utf-8",
url: '/map/data',
dataType: 'json',
success: function (data) {
  draw(data);
},
error: function (result) {
  error();
}
});

function draw(data) {
  var color = d3.scale.category20b();
  var width = 420,
      barHeight = 20;

  var x = d3.scale.linear()
    .range([0, width])
    .domain([0, d3.max(data)]);

  var chart = d3.select("#graph")
    .attr("width", width)
    .attr("height", barHeight * data.length);

  var bar = chart.selectAll("g")
    .data(data)
    .enter().append("g")
    .attr("transform", function (d, i) {
      return "translate(0," + i * barHeight + ")";
    });

  bar.append("rect")
    .attr("width", x)
    .attr("height", barHeight - 1)
    .style("fill", function (d) {
      return color(d)
    })

  bar.append("text")
    .attr("x", function (d) {
      return x(d) - 10;
    })
  .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .style("fill", "white")
    .text(function (d) {
      return d;
    });
}

function error() {
  console.log("error")
}


/*
// Orthographic map
var width = 960,
height = 500;

var projection = d3.geo.orthographic()
.scale(250)
.translate([width / 2, height / 2])
.clipAngle(90);

var path = d3.geo.path()
.projection(projection);

var λ = d3.scale.linear()
.domain([0, width])
.range([-180, 180]);

var φ = d3.scale.linear()
.domain([0, height])
.range([90, -90]);

var svg = d3.select("body").append("svg")
.attr("width", width)
.attr("height", height);

svg.on("mousemove", function() {
var p = d3.mouse(this);
projection.rotate([λ(p[0]), φ(p[1])]);
svg.selectAll("path").attr("d", path);
});

d3.json("/mbostock/raw/4090846/world-110m.json", function(error, world) {
if (error) throw error;

svg.append("path")
.datum(topojson.feature(world, world.objects.land))
.attr("class", "land")
.attr("d", path);
});
*/

/*
// World cloropleth
var format = function(d) {
d = d / 1000000;
return d3.format(',.02f')(d) + 'M';
}

var map = d3.geomap.choropleth()
.geofile('../../../d3-geomap/topojson/world/countries.json')
.colors(colorbrewer.YlGnBu[9])
.column('YR2010')
.format(format)
.legend(true)
.unitId('Country Code');

d3.csv('../../../data/sp.pop.totl_Indicator_en_csv_v2.csv', function(error, data) {
d3.select('#map')
.datum(data)
.call(map.draw, map);
});
*/




var map = new Datamap({element: document.getElementById('container')});





/*
//basic map config with custom fills, mercator projection
var map = new Datamap({
  scope: 'world',
    element: document.getElementById('container1'),
    projection: 'mercator',
    height: 500,
    fills: {
      defaultFill: '#f0af0a',
      lt50: 'rgba(0,244,244,0.9)',
      gt50: 'red'
    },

    data: {
      USA: {fillKey: 'lt50' },
      RUS: {fillKey: 'lt50' },
      CAN: {fillKey: 'lt50' },
      BRA: {fillKey: 'gt50' },
      ARG: {fillKey: 'gt50'},
      COL: {fillKey: 'gt50' },
      AUS: {fillKey: 'gt50' },
      ZAF: {fillKey: 'gt50' },
      MAD: {fillKey: 'gt50' }       
    }
})


//sample of the arc plugin
map.arc([
    {
      origin: {
        latitude: 40.639722,
        longitude: 73.778889
      },
      destination: {
        latitude: 37.618889,
        longitude: -122.375
      }
},
{
  origin: {
    latitude: 30.194444,
    longitude: -97.67
  },
  destination: {
    latitude: 25.793333,
    longitude: -0.290556
  }
}
], {strokeWidth: 2});


//bubbles, custom popup on
//hover template
map.bubbles([
    {
      name: 'Hot',
      latitude: 21.32,
      longitude: 5.32,
      radius: 10,
      fillKey: 'gt50'},
    {
      name:
      'Chilly',
      latitude:
      -25.32,
      longitude:120.32,
      radius: 18,
      fillKey:'lt50'},
    {
      name: 'Hot again',
      latitude:21.32,
      longitude:-84.32,
      radius:8,
      fillKey:'gt50'},
      ],{
      popupTemplate:function(geo,data){
      return "<div class='hoverinfo'>It is " + data.name + "</div>";
    }
});
*/
