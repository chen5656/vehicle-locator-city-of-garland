

define(['dojo/_base/declare','dojo/_base/lang','dojo/_base/html','dojo/dom',"dojo/_base/array","dojo/on","dojo/topic",
		'jimu/BaseWidget',
		"esri/symbols/SimpleMarkerSymbol",'esri/symbols/TextSymbol','esri/renderers/SimpleRenderer',"esri/symbols/Font","esri/Color",				
  "esri/layers/LabelLayer",		  "esri/tasks/query",		"esri/dijit/Search"	,"esri/tasks/locator","esri/geometry/Extent",
		"esri/config",
  "esri/graphic",  "esri/InfoTemplate",  "esri/map",
  "esri/geometry/Multipoint",  "esri/geometry/Point",
  "esri/layers/FeatureLayer","esri/dijit/ColorPicker",
  "dojo/json",  "dojox/data/CsvStore",
  "dojox/encoding/base64",
  "dojo/domReady!",
"dijit/form/Select",
  "dojo/parser"
],
function(declare, lang, html,dom,array,on,topic,
BaseWidget, 
SimpleMarkerSymbol,TextSymbol, SimpleRenderer, Font,Color,
		  LabelLayer,Query,Search,Locator,Extent,
		   esriConfig,  Graphic, InfoTemplate, Map,  
     Multipoint, Point, 
     FeatureLayer,  ColorPicker,
    JSON,    CsvStore
		 ){
			     
	var file; //file data
	var featureCollection;
	var addressStrings = ["address", "addr", "location"];
	var result; //
	var LayerList = [];
	var layerAddedTimes = 0;
	var symbolColor="#FFFFFF";
	var fontColor="#FFFFFF";
	
  //To create a widget, you need to derive from BaseWidget.
  return declare([BaseWidget], {
    // Custom widget code goes here 
	
    baseClass: 'Labeling-widget',	  
	  	     
    //this property is set by the framework when widget is loaded.
     //name: 'CustomWidget',


//methods to communication with app container:

    postCreate: function() {
       this.inherited(arguments);
       console.log('postCreate');
    },

    startup: function() {
      this.inherited(arguments);
    // this.mapIdNode.innerHTML = 'map id:' + this.map.id;
          console.log('startup');
	
		 this.setupDropZone();
    },

     onOpen: function(){
		 console.log('onOpen');	
	
		 this.setupDropZone();
		 
		 var colorPicker = new ColorPicker({
			 color : "#FFFFFF",
			 required : true,
			 showTransparencySlider : false
		 }, this._ImportAddrMarkerColor);
		 
		 var colorPicker1 = new ColorPicker({
			 color : "#1A1A1A",
			 required : true,
			 showTransparencySlider : false
		 }, this._ImportLabelMarkerColor);
		 
		 colorPicker.on("color-change",function(ColorChange){
			 symbolColor=ColorChange.color;
		 });	
		 colorPicker1.on("color-change",function(ColorChange){
			 fontColor=ColorChange.color;
		 });			 
     },

     onClose: function(){
       console.log('onClose');	
     },

     onMinimize: function(){
       console.log('onMinimize');	
     },

     onMaximize: function(){
       console.log('onMaximize');
     },

     onSignIn: function(credential){
       /* jshint unused:false*/
       console.log('onSignIn');
     },

     onSignOut: function(){
      console.log('onSignOut');
     },
      
     onPositionChange: function(){
      console.log('onPositionChange');
    },

    resize: function(){
       console.log('resize');	
    },
	  
	setupDropZone:function  () {
		  // Let's verify that we have proper browser support, before
		  // moving ahead. You can also use a library like Modernizr
		  // to detect browser capabilities:
		  // http://www.modernizr.com/

		  var mapCanvas = dom.byId("ImportAddressesfile");
		  result = dom.byId("ImportAddressesResult");
		  // Reference
		  // http://www.html5rocks.com/features/file
		  // http://www.html5rocks.com/tutorials/dnd/basics/
		  // https://developer.mozilla.org/En/DragDrop/Drag_Operations
		  on(mapCanvas, "dragenter", function (event) {
			// If we don't prevent default behavior here, browsers will
			// perform the default action for the file being dropped i.e,
			// point the page to the file.
			event.preventDefault();
		  });

		  on(mapCanvas, "dragover", function (event) {
			event.preventDefault();
			  result.innerHTML = "";
		  });

		  on(mapCanvas, "drop", function (event) {
			  console.log("Drop: ", event);

			  this.value = "Drag file HERE";
			  file = null;

			  event.preventDefault();
			  // Reference
			  // http://www.html5rocks.com/tutorials/file/dndfiles/
			  // https://developer.mozilla.org/en/Using_files_from_web_applications
			  var dataTransfer = event.dataTransfer,
				files = dataTransfer.files;
				types = dataTransfer.types;

			  // File drop?
			  if (files && files.length === 1) {
				  file = files[0]; // that's right I'm only reading one file			  
				  console.log("[file -]" & file);
				  if (file.name.indexOf(".csv") !== -1 || file.name.indexOf(".txt") !== -1) {
					  this.value = file.name;
				  } 
				  else{	
					  this.value = "Drag file HERE";
					  file = null;
					  

					result.innerHTML = "Drag and drop is not supported for the file(s) you draged.";
					result.style.color = "red";
					result.style.fontSize = "large";
				  }
			  }
			  else{
				  this.value = "Drag file HERE";
				  file = null;
				  
				  result.innerHTML = "Drag and drop is not supported for the file(s) you draged.";
				  result.style.color = "red";
					result.style.fontSize = "large";
			  }
		});
		}, 
	  
	  _ImportAddresses: function(){
		  var that = this;
		  result.innerHTML ="";
		  if (file){
			var reader = new FileReader();
			reader.onload = function () {
			  console.log("Finished reading data ");
				console.time("geocoding");
			  that.processData(reader.result);
			};
			reader.readAsText(file);
			  
			  
		  }else{
			  result.innerHTML = "Select a file first";
			  result.style.color	 = "red";		  
					result.style.fontSize = "large";
		  }
		  
	  },  
	  
	processData: function(data){
		  
			result.innerHTML = "Request is processing. Please don't click any button.";
			result.style.color	 = "red";		  
			result.style.fontSize = "large";
		  
		  var that = this;
		  var newLineIndex = data.indexOf("\n");
		  var firstLine = lang.trim(data.substr(0, newLineIndex)); //remove extra whitespace, not sure if I need to do this since I threw out space delimiters
		  var separator = this.getSeparator(firstLine);
		  var csvStore = new CsvStore({
			data: data,
			separator: separator
		  });
		  		  
		  csvStore.fetch({
			onComplete: function (items) {
			  var objectId = 0;
			  featureCollection = that.generateFeatureCollectionTemplateCSV(csvStore, items);
			  var popupInfo = that.generateDefaultPopupInfo(featureCollection);
			  var infoTemplate = new InfoTemplate(that.buildInfoTemplate(popupInfo));
			  var addressField;
			  var fieldNames = csvStore.getAttributes(items[0]);
			  array.forEach(fieldNames, function (fieldName) {
				var matchId;
				matchId = array.indexOf(addressStrings,
				  fieldName.toLowerCase());
				if (matchId !== -1) {
				  addressField = fieldName;
				}
			  });
				if (!addressField){
					result.innerHTML = "Can't find Address Field";
					result.style.color = "red";
					result.style.fontSize = "large";
					return;
					
				}
				
						 
			 var s = new Search({
				   sources: [{
						locator: new   Locator("http://cogmap.garlandtx.gov/arcgis/rest/services/GIS_AddressLocator/GeocodeServer"),
						name: "Garland Address Finder",
						maxResults: 3,
					   showInfoWindowOnSelect:true
				   }]
			   });
				
				s.startup();
				
				var i =0 ;
				var EmptyAddress = [];
				
			  // Add records in this CSV store as graphics		
			  array.forEach(items, function (item) {
				  
					var attrs = csvStore.getAttributes(item),
					  attributes = {};
					// Read all the attributes for  this record/item
					array.forEach(attrs, function (attr) {
					  var value = Number(csvStore.getValue(item, attr));
					  attributes[attr] = isNaN(value) ? csvStore.getValue(item, attr) : value;
					});

					attributes["__OBJECTID"] = objectId;
					objectId++;


					  //geocoder
				  
					s.search(attributes[addressField]).then(function(response){
											
							i++;
						if (response){
							var geometry = response[0][0].feature.geometry ;
							var graphic = new Graphic(geometry);
							graphic.setAttributes(attributes);

							featureCollection.featureSet.features.push(graphic);	
						}else{
							EmptyAddress.push(attributes[addressField]);
						}
							if (i==items.length){
								console.log("Finished Geocoding");
								topic.publish("ImportAdresses/Geocoder", { count: items.length});
							}
					});


				  });

			  
			  var topicHandle =  topic.subscribe("ImportAdresses/Geocoder", function(e){
				  //Add layer and label to map
				  console.timeEnd("geocoding");
				  console.log("Drawing layer... " );	
				  
				  layerAddedTimes ++
				  
				  var layerid;
				  if(file.name.length>30){
					  layerid = file.name.substring(0,25);
				  }else{
					  layerid = file.name.substring(0,file.name.length - 4);
					  
				  }
				  
				  var featureLayer = new FeatureLayer(featureCollection, {
					infoTemplate: infoTemplate,
					id: "_" + layerid + "_" + layerAddedTimes,
					  outFields: [addressField],
					  showLabels: true					  
				  });
				  
				  featureLayer.__popupInfo = popupInfo;
				  				  
				  var symbol = new SimpleMarkerSymbol().setColor(symbolColor);
				  symbol.setSize("10");
				  var renderer = new SimpleRenderer(symbol);
				  featureLayer.setRenderer(renderer); 				  
				  
				  //label
				  var layerLabel = new TextSymbol().setColor(fontColor);
				  layerLabel.font.setSize("12pt");
				  layerLabel.font.setFamily("arial");
				  layerLabel.font.setWeight(Font.WEIGHT_BOLD);
				  var labelRenderer = new SimpleRenderer(layerLabel);
				  var labels = new LabelLayer({ id:"_l_" + layerid + "_" + layerAddedTimes});
				  labels.addFeatureLayer(featureLayer, labelRenderer, "{" + addressField + "}");
				 
				  that.map.addLayer(featureLayer);
				  that.map.addLayer(labels);
				  that.zoomToData(featureLayer);	
				  
				  LayerList.push(featureLayer);
				  LayerList.push(labels);
				  
				  
				  
					result.innerHTML = "Result: " + featureCollection.featureSet.features.length + " addresses have been added to the map. <br><br>" + EmptyAddress.length + " addresses can't find a match: <br>";
					result.style.color = "black";
					result.style.fontSize = "medium";
				  
				  array.forEach(EmptyAddress, function(item){
					  result.innerHTML = result.innerHTML  + item + "<br>";
					  
					  featureCollection=null;
					  EmptyAddress=[];
					  
				  }, this);
				  
			  });0
			}
		  }); 

		  
	  },
 
	  
	getSeparator: function (string) {
	  var separators = [",", "      ", ";", "|","	"];
	  var maxSeparatorLength = 0;
	  var maxSeparatorValue = "";
	  array.forEach(separators, function (separator) {
		var length = string.split(separator).length;
		if (length > maxSeparatorLength) {
		  maxSeparatorLength = length;
		  maxSeparatorValue = separator;
		}
	  });
	  return maxSeparatorValue;
	},
	
	zoomToData: function (featureLayer) {
    // Zoom to the collective extent of the data
      var multipoint = new Multipoint(map.spatialReference);
      array.forEach(featureLayer.graphics, function (graphic) {
        var geometry = graphic.geometry;
        if (geometry) {
          multipoint.addPoint({
            x: geometry.x,
            y: geometry.y
          });
        }
      });

      if (multipoint.points.length > 0) {
        this.map.setExtent(multipoint.getExtent().expand(1.25), true);
      }
    },


	generateFeatureCollectionTemplateCSV: function (store, items) {
	  //create a feature collection for the input csv file
	  var featureCollection1 = {
		"layerDefinition": null,
		"featureSet": {
		  "features": [],
		  "geometryType": "esriGeometryPoint"
		}
	  };
	  featureCollection1.layerDefinition = {
		"geometryType": "esriGeometryPoint",
		"objectIdField": "__OBJECTID",
		"type": "Feature Layer",
		"typeIdField": "",
		"drawingInfo": {
		  "renderer": {
			"type": "simple",
			"symbol": {
			  "type": "esriPMS",
			  "url": "http://static.arcgis.com/images/Symbols/Basic/RedSphere.png",
			  "imageData": "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",
			  "contentType": "image/png",
			  "width": 15,
			  "height": 15
			}
		  }
		},
		"fields": [
		  {
			"name": "__OBJECTID",
			"alias": "__OBJECTID",
			"type": "esriFieldTypeOID",
			"editable": false,
			"domain": null
		  }
		],
		"types": [],
		"capabilities": "Query"
	  };

	  var fields = store.getAttributes(items[0]);
	  array.forEach(fields, function (field) {
		var value = store.getValue(items[0], field);
		var parsedValue = Number(value);
		if (isNaN(parsedValue)) { //check first value and see if it is a number
		  featureCollection1.layerDefinition.fields.push({
			"name": field,
			"alias": field,
			"type": "esriFieldTypeString",
			"editable": true,
			"domain": null
		  });
		}
		else {
		  featureCollection1.layerDefinition.fields.push({
			"name": field,
			"alias": field,
			"type": "esriFieldTypeDouble",
			"editable": true,
			"domain": null
		  });
		}
	  });
	  return featureCollection1;
	},

	generateDefaultPopupInfo:function (featureCollection) {
	  var fields = featureCollection.layerDefinition.fields;
	  var decimal = {
		'esriFieldTypeDouble': 1,
		'esriFieldTypeSingle': 1
	  };
	  var integer = {
		'esriFieldTypeInteger': 1,
		'esriFieldTypeSmallInteger': 1
	  };
	  var dt = {
		'esriFieldTypeDate': 1
	  };
	  var displayField = null;
	  var fieldInfos = array.map(fields,
		lang.hitch(this, function (item) {
		  if (item.name.toUpperCase() === "NAME") {
			displayField = item.name;
		  }
		  var visible = (item.type !== "esriFieldTypeOID" &&
						 item.type !== "esriFieldTypeGlobalID" &&
						 item.type !== "esriFieldTypeGeometry");
		  var format = null;
		  if (visible) {
			var f = item.name.toLowerCase();
			var hideFieldsStr = ",stretched value,fnode_,tnode_,lpoly_,rpoly_,poly_,subclass,subclass_,rings_ok,rings_nok,";
			if (hideFieldsStr.indexOf("," + f + ",") > -1 ||
				f.indexOf("area") > -1 || f.indexOf("length") > -1 ||
				f.indexOf("shape") > -1 || f.indexOf("perimeter") > -1 ||
				f.indexOf("objectid") > -1 || f.indexOf("_") == f.length - 1 ||
				f.indexOf("_i") == f.length - 2) {
			  visible = false;
			}
			if (item.type in integer) {
			  format = {
				places: 0,
				digitSeparator: true
			  };
			}
			else if (item.type in decimal) {
			  format = {
				places: 2,
				digitSeparator: true
			  };
			}
			else if (item.type in dt) {
			  format = {
				dateFormat: 'shortDateShortTime'
			  };
			}
		  }

		  return lang.mixin({}, {
			fieldName: item.name,
			label: item.alias,
			isEditable: false,
			tooltip: "",
			visible: visible,
			format: format,
			stringFieldOption: 'textbox'
		  });
		}));

	  var popupInfo = {
		title: displayField ? '{' + displayField + '}' : '',
		fieldInfos: fieldInfos,
		description: null,
		showAttachments: false,
		mediaInfos: []
	  };
	  return popupInfo;
	},

	buildInfoTemplate:function (popupInfo) {
	  var json = { 
		content: ""
	  };

	  array.forEach(popupInfo.fieldInfos, function (field) {
		if (field.visible) {
		  json.content +=  field.label + ": ${" + field.fieldName + "}<br>";
		}
	  });
	  return json;
	}, 

	_ImportAddressesRemoveAll:function(){
		var map = this.map;


		array.forEach(LayerList, function (item) {
			map.removeLayer(item);
		});

		layerAddedTimes =0 ;
	}

		

//methodso communication between widgets:

  });
});