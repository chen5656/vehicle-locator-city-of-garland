define(['dojo/_base/declare', "dojo/on", "dojo/query", "dojo/dom-construct", "dojo/dom-attr",
		'jimu/BaseWidget',
		"esri/SpatialReference", "esri/tasks/GeometryService", "esri/tasks/ProjectParameters", "esri/tasks/AreasAndLengthsParameters",
		"esri/tasks/LengthsParameters",
		"dojo/domReady!", "dojo/parser"
	],
	function (declare, on, domQuery, domConstruct, domAttr,
		BaseWidget,
		SpatialReference, GeometryService, ProjectParameters,
		AreasAndLengthsParameters, LengthsParameters
	) {
		var map;
		var geoFactsActionLink;

		var TaskCalculateGeometry;

		function geoFactsClick() {
			domAttr.set(geoFactsActionLink, "innerHTML", "Calculating...");
			var feature = map.infoWindow.getSelectedFeature();
			var calculator = new TaskCalculateGeometry([feature.geometry], feature._layer.geometryType);
			calculator.excute();
		}

		function removeEvent(link, type, handler) {
			if (link.detachEvent) {
				link.detachEvent('on' + type, handler);
			} else {
				link.removeEventListener(type, handler);
			}
		}

		//To create a widget, you need to derive from BaseWidget.
		return declare([BaseWidget], {
			// Custom widget code goes here        

			baseClass: 'geoFacts-widget',

			geoFactsParameters: {
				parentLayers: [],
				layers: {}
			},
			geoFactsSelectedLayer: {},


			postCreate: function () {
				var self = this;
				this.inherited(arguments);
				var settings = this.config.settings;
				var geometryService = new GeometryService(settings.geometryServiceUrl);
				var prjParams = new ProjectParameters();
				var lengthParams = new LengthsParameters();
				var areasAndLengthParams = new AreasAndLengthsParameters();


				prjParams.outSR = new SpatialReference({
					wkid: settings.outSpatialReferenceWkid
				});

				lengthParams.calculationType = settings.geometryCalculationType;
				lengthParams.lengthUnit = GeometryService[settings.geometryCalculationLengthUnit.value];

				areasAndLengthParams.lengthUnit = GeometryService[settings.geometryCalculationLengthUnit.value];
				areasAndLengthParams.areaUnit = GeometryService[settings.geometryCalculationAreaUnit.value];
				areasAndLengthParams.calculationType = settings.geometryCalculationType;

				TaskCalculateGeometry = function (geometries, geometryType) {
					this.geometries = geometries;
					this.geometryType = geometryType;
				}
				TaskCalculateGeometry.prototype.excute = function () {
					var thisTask = this;
					switch (this.geometryType) {
						case "esriGeometryPoint":
							prjParams.geometries = this.geometries;
							geometryService.project(prjParams).then(function (newGeometries) {
								var newGeometry = newGeometries[0];
								var data = {
									"Longitude": newGeometry.x.toFixed(6),
									"Latitude": newGeometry.y.toFixed(6)
								};

								thisTask.display(data);
							})
							break;
						case "esriGeometryPolyline":
							lengthParams.polylines = this.geometries;
							geometryService.lengths(lengthParams, function (results) {
								var data = {
									"Length": results.lengths[0].toLocaleString("en", {
										'minimumFractionDigits': 0,
										'maximumFractionDigits': 2
									}).toLocaleString('en').concat(" ",settings.geometryCalculationLengthUnit.name)
								}
								thisTask.display(data);
							});
							break;
						case "esriGeometryPolygon":
							areasAndLengthParams.polygons = this.geometries;
							geometryService.areasAndLengths(areasAndLengthParams, function (results) {
								var data = {
									"Perimeter": results.lengths[0].toLocaleString("en", {
										'minimumFractionDigits': 0,
										'maximumFractionDigits': 2
									}).concat(" ",settings.geometryCalculationLengthUnit.name),
									"Area": results.areas[0].toLocaleString("en", {
										'minimumFractionDigits': 0,
										'maximumFractionDigits': 2
									}).concat(" ",settings.geometryCalculationAreaUnit.name)
								};
								thisTask.display(data);
							});
					}
				}
				TaskCalculateGeometry.prototype.display = function (data) {
					var esriViewPopupNode;
					domAttr.set(geoFactsActionLink, "innerHTML", "GeoFacts");
					//add geoFacts				
					if (document.getElementById("geoFactsResult")) {
						esriViewPopupNode = document.getElementById("geoFactsResult");
					} else {
						esriViewPopupNode = domConstruct.create("div", {
							"class": "geoFactsResult",
							"id": "geoFactsResult"
						}, domQuery(".esriViewPopup", map.infoWindow.domNode)[0], "first");
					}
					esriViewPopupNode.innerHTML = "";

					var table = domConstruct.create("table", {
						style: "width:90%"
					}, esriViewPopupNode);

					var str = "";
					for (var key in data) {
						str = str.concat("<tr>",
							"<td>", key, "</td>",
							"<td>", data[key], "</td>",
							"</tr>");
					}
					table.innerHTML = str;

					domConstruct.create("div", {
						class: "hzLine"
					}, esriViewPopupNode);

				}
				console.log('postCreate');
			},

			startup: function () {
				this.inherited(arguments);
				console.log('startup');
				self = this;
				map = this.map;
			},

			onOpen: function () {
				console.log('onOpen');
				//create a link that we'll the map's popup window.
				//The link section of the popup has a class called actionList assigned so we can
				//use dojo/query to find the elements with this class name. 
				geoFactsActionLink = domConstruct.create("a", {
					"class": "action",
					// "id": "statsLink",
					"title": "Show latitude/ longitude of point data, length of line data, and perimeter /area of polygon data.",
					"innerHTML": "GeoFacts",
					"href": "javascript: void(0);"
				}, domQuery(".actionList", this.map.infoWindow.domNode)[0]);

				//when the link is clicked register a function that will run 
				on(geoFactsActionLink, "click", geoFactsClick);
			},

			onClose: function () {
				console.log('onClose');
				removeEvent(geoFactsActionLink, 'click', geoFactsClick);
				dojo.destroy(geoFactsActionLink);


			}
		});
	});