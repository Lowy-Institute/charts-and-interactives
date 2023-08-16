am4core.useTheme(am4themes_animated);

var chart = am4core.create("animated-map", am4maps.MapChart);

// Set map definition
chart.geodata = am4geodata_worldLow;

// Set projection
chart.projection = new am4maps.projections.Orthographic();
chart.panBehavior = "rotateLongLat";
chart.deltaLatitude = 0;
chart.deltaLongitude = -150;
chart.padding(0, 0, 0, 0);

// Create map polygon series
var polygonSeries = chart.series.push(new am4maps.MapPolygonSeries());

polygonSeries.useGeodata = true;

// Configure graticule
var graticuleSeries = chart.series.push(new am4maps.GraticuleSeries());
graticuleSeries.mapLines.template.line.stroke = am4core.color("#d8d3ce");
graticuleSeries.mapLines.template.line.strokeOpacity = 0.05;
graticuleSeries.fitExtent = false;

// Configure series
var polygonTemplate = polygonSeries.mapPolygons.template;
polygonTemplate.fill = am4core.color("#002b45");
polygonTemplate.stroke = am4core.color("#d8d3ce");
polygonTemplate.strokeWidth = 0.25;
polygonTemplate.strokeOpacity = 0.5;

polygonSeries.data = [{
  "id": "AU",
  "fill": am4core.color("#004b78"),
  "stroke": am4core.color("#ffc52c"),
  "strokeWidth": 1,
  "strokeOpacity": 1,
}];

polygonTemplate.propertyFields.fill = "fill";
polygonTemplate.propertyFields.stroke = "stroke";
polygonTemplate.propertyFields.strokeWidth = "strokeWidth";
polygonTemplate.propertyFields.strokeOpacity = "strokeOpacity";

chart.backgroundSeries.mapPolygons.template.polygon.fillOpacity = 1;
chart.backgroundSeries.mapPolygons.template.polygon.fill = am4core.color("#001525");

let animationLon;
let animationLat;

const DURATION = 20 * 60 * 1000;

setTimeout(() => {
  animationLon = chart.animate({ property: "deltaLongitude", to: -150 + 10 * 360 }, DURATION);
  // animationLat = chart.animate({ property: "deltaLatitude", to: 0 }, DURATION);
}, 2000);