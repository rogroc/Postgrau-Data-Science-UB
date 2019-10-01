// Various accessors that specify the four dimensions of data to visualize.
function x(d) { return d.income; }
function y(d) { return d.lifeExpectancy; }
function radius(d) { return d.population; }
function color(d) { return d.region; }
function key(d) { return d.name; }

// Chart dimensions.
var margin = {top: 19.5, right: 19.5, bottom: 19.5, left: 59.5},
    width = 960 - margin.right,
    height = 500 - margin.top - margin.bottom;

// Various scales. These domains make assumptions of data, naturally.
var xScale = d3.scale.log().domain([300, 1e5]).range([0, width]),
    yScale = d3.scale.linear().domain([10, 85]).range([height, 0]),
    radiusScale = d3.scale.sqrt().domain([0, 5e8]).range([0, 40]),
    colorScale = d3.scale.category10();

// The x & y axes.
var xAxis = d3.svg.axis().orient("bottom").scale(xScale).ticks(12, d3.format(",d")),
    yAxis = d3.svg.axis().scale(yScale).orient("left");

// Create the SVG container and set the origin.
var svg = d3.select("#chart").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


// Add the x-axis.
svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);

// Add the y-axis.
svg.append("g")
    .attr("class", "y axis")
    .call(yAxis);

// Add an x-axis label.
svg.append("text")
    .attr("class", "x label")
    .attr("text-anchor", "end")
    .attr("x", width)
    .attr("y", height - 6)
    .text("income per capita, inflation-adjusted (dollars)");

// Add a y-axis label.
svg.append("text")
    .attr("class", "y label")
    .attr("text-anchor", "end")
    .attr("y", 6)
    .attr("dy", ".75em")
    .attr("transform", "rotate(-90)")
    .text("life expectancy (years)");

// Add the year label; the value is set on transition.
var label = svg.append("text")
    .attr("class", "year label")
    .attr("text-anchor", "end")
    .attr("y", height - 24)
    .attr("x", width)
    .text(1800);

// Load the data.
d3.json("nations.json", function(nations) {

  // A bisector since many nation's data is sparsely-defined.
  var bisect = d3.bisector(function(d) { return d[0]; });

  // Add a dot per nation. Initialize the data at 1800, and set the colors.
  var dot = svg.append("g")
      .attr("class", "dots")
      .selectAll(".dot")
      .data(interpolateData(1800))
      .enter().append("circle")
      .attr("class", "dot")
      .style("fill", function(d) { return colorScale(color(d)); })
      .call(position)
      .on("click", function(d) { 
		update_charts(d.name,d.index,nations,colorScale(color(d)));
	})
      .sort(order);

  // Add a title.
  dot.append("title")
      .text(function(d) { return d.name; });

  // Add an overlay for the year label to create an interaction. 
  var box = label.node().getBBox();
  var overlay = svg.append("rect")
        .attr("class", "overlay")
        .attr("x", box.x)
        .attr("y", box.y)
        .attr("width", box.width)
        .attr("height", box.height)
        .on("mouseover", enableInteraction);

  // Start a transition that interpolates the data based on year.
  svg.transition()
      .duration(10000)
      .ease("linear")
      .tween("year", tweenYear)
      .each("end", enableInteraction);

  // Positions the dots based on data.
  function position(dot) {
    dot .attr("cx", function(d) { return xScale(x(d)); })
        .attr("cy", function(d) { return yScale(y(d)); })
        .attr("r", function(d) { return radiusScale(radius(d)); });
  }

  // Defines a sort order so that the smallest dots are drawn on top.
  function order(a, b) {
    return radius(b) - radius(a);
  }

  // After the transition finishes, you can mouseover to change the year.
  function enableInteraction() {
    var yearScale = d3.scale.linear()
        .domain([1800, 2009])
        .range([box.x + 10, box.x + box.width - 10])
        .clamp(true);

    // Cancel the current transition, if any.
    svg.transition().duration(0);

    overlay
        .on("mouseover", mouseover)
        .on("mouseout", mouseout)
        .on("mousemove", mousemove)
        .on("touchmove", mousemove);

    function mouseover() {
      	label.classed("active", true);
    }

    function mouseout() {
      label.classed("active", false);
    }

    function mousemove() {
      displayYear(yearScale.invert(d3.mouse(this)[0]));
      
      
    }
  }

  // Tweens the entire chart by first tweening the year, and then the data.
  // For the interpolated data, the dots and label are redrawn.
  function tweenYear() {
	
    var year = d3.interpolateNumber(1800, 2009);

    return function(t) { 
		displayYear(year(t));

	};
  }

  // Updates the display to show the specified year.
  function displayYear(year) {
    dot.data(interpolateData(year), key).call(position).sort(order);
    label.text(Math.round(year));
  }

  // Interpolates the dataset for the given (fractional) year.
  function interpolateData(year) {
    return nations.map(function(d,index) {
      return {
        name: d.name,
        region: d.region,
        income: interpolateValues(d.income, year),
        population: interpolateValues(d.population, year),
        lifeExpectancy: interpolateValues(d.lifeExpectancy, year),
	index: index
      };
    });
  }

  // Finds (and possibly interpolates) the value for the specified year.
  function interpolateValues(values, year) {
    var i = bisect.left(values, year, 0, values.length - 1),
        a = values[i];
    if (i > 0) {
      var b = values[i - 1],
          t = (year - a[0]) / (b[0] - a[0]);
      return a[1] * (1 - t) + b[1] * t;
    }
    return a[1];
  }
});



/****************************************************************/
/** function that draws all three charts from a country         */
/**   Input: country_name, corresponing index,nations and color */
/****************************************************************/
function update_charts(country_name,index,nations,color){
  var populationData = nations[index].population.map(function(d) {return {x:d[0], y: d[1]/1000000}});
  var incomeData = nations[index].income.map(function(d) {return {x:d[0], y: d[1]}});
  var lifeData = nations[index].lifeExpectancy.map(function(d) {return {x:d[0], y: d[1]}});

  draw_chart(populationData,country_name,"populationChart",color);
  draw_chart(incomeData,country_name,"incomeChart",color);
  draw_chart(lifeData,country_name,"lifeExpectancyChart",color);
}

/****************************************************/
/** function that draws individual charts           */
/**   Input: data, svg id and color                 */
/****************************************************/
function draw_chart(data,name,chart_name,color){
  var margin = {top: 19.5, right: 19.5, bottom: 19.5, left: 59.5},
    width = 400 - margin.right,
    height = 200 - margin.top - margin.bottom;
    d3.select("#svg_"+chart_name).remove();
    var vis = d3.select('#'+chart_name)
      .append('svg')
      .attr("id","svg_"+chart_name)
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom);
  xRange = d3.scale.linear().range([margin.left, width - margin.right]).domain([d3.min(data, function(d) {
          return d.x;
        }), d3.max(data, function(d) {
          return d.x;
        })]),
  yRange = d3.scale.linear().range([height - margin.top, margin.bottom]).domain([d3.min(data, function(d) {
            return d.y;
        }), d3.max(data, function(d) {
          return d.y;
        })]),
  xAxis = d3.svg.axis()
        .scale(xRange)
        .tickSize(5)
        .tickSubdivide(true),
  yAxis = d3.svg.axis()
        .scale(yRange)
        .tickSize(5)
        .orient('left')
        .tickSubdivide(true);

  var label = vis.append("text")
    .attr("class", "country label")
    .attr("text-anchor", "init")
    .attr("y", height - 120)
    .attr("x", 80)
    .style("fill",color)
    .text(name);

  vis.append('svg:g')
        .attr('class', 'x axis')
        .attr('transform', 'translate(0,' + (height - margin.bottom) + ')')
        .call(xAxis);
 
  vis.append('svg:g')
         .attr('class', 'y axis')
         .attr('transform', 'translate(' + (margin.left) + ',0)')
         .call(yAxis);  

  var lineFunc = d3.svg.line()
                 .x(function(d) {
                     return xRange(d.x);
                 })
                 .y(function(d) {
                     return yRange(d.y);
                 })
                 .interpolate('linear');

  vis.append('svg:path')
        .attr('d', lineFunc(data))
        .attr('stroke', color)
        .attr('stroke-width', 2)
        .attr('fill', 'none');
}



