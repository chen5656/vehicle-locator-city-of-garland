//need to add:      "showLabels":true   to the config.json, under:     "mapOptions": {

define(['dojo/_base/declare','dojo/_base/lang','dojo/_base/html','dojo/dom',"dojo/_base/array","dojo/on","dojo/topic",
		'jimu/BaseWidget',
		"esri/symbols/SimpleMarkerSymbol",'esri/symbols/TextSymbol','esri/renderers/SimpleRenderer',"esri/symbols/Font","esri/Color",				
 "esri/layers/LabelClass",		 "esri/tasks/query",		"esri/dijit/Search"	,"esri/tasks/locator","esri/geometry/Extent",
		"esri/config",
 "esri/graphic", "esri/InfoTemplate", "esri/map",
 "esri/geometry/Multipoint", "esri/geometry/Point",
 "esri/layers/FeatureLayer","esri/dijit/ColorPicker",
 "dojo/json", "dojox/data/CsvStore",
 "dojox/encoding/base64",
 "dojo/domReady!",
"dijit/form/Select",
 "dojo/parser"
],
function(declare, lang, html,dom,array,on,topic,
BaseWidget, 
SimpleMarkerSymbol,TextSymbol, SimpleRenderer, Font,Color,
		 LabelClass,Query,Search,Locator,Extent,
		  esriConfig, Graphic, InfoTemplate, Map, 
   Multipoint, Point, 
   FeatureLayer, ColorPicker,
  JSON,  CsvStore
		 ){
			   
	var file; //file data
	var addressStrings = ["address", "addr", "location"];
    var labelStrings = ["label", "name"];
	var LayerList = [];
	var layerAddedTimes = 0;
	var symbolColor="#98e600";
	var fontColor="#000000";
	var featureCollection;
    var EmptyAddress = [];
	
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
      this.map.showLabels = true;
	
  },

   onOpen: function(){
		 console.log('onOpen');	
       	
		 
		 var colorPicker = new ColorPicker({
			 color : symbolColor,
			 required : true,
			 showTransparencySlider : false
		 }, this._ImportAddrMarkerColor);
		 
		 var colorPicker1 = new ColorPicker({
			 color : fontColor,
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
	 
	 _ImportAddresses: function(){
		 var that = this;	 
		 var result = dom.byId("ImportAddressesResult");
		 result.innerHTML ="";
		 file = dom.byId("theFile").files[0];
			  
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
		  	var result = dom.byId("ImportAddressesResult");
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
			 var addressField,labelField;
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
                
             array.forEach(fieldNames, function (fieldName) {
                var matchId;
                matchId = array.indexOf(labelStrings,
                 fieldName.toLowerCase());
                if (matchId !== -1) {
                    labelField = fieldName;
                }
			 });
             if (!labelField){
					labelField = addressField;
					
			  }
                
             
				
						 
			 var s = new Search({
				  sources: [{
						locator: new  Locator("http://cogmap.garlandtx.gov/arcgis/rest/services/GIS_AddressLocator/GeocodeServer"),
						name: "Garland Address Finder",
						maxResults: 1
				  }]
			  });
				
				s.startup();
				
				var i =0 ;
				
			 // Add records in this CSV store as graphics		
			 array.forEach(items, function (item) {
				 
					var attrs = csvStore.getAttributes(item),
					 attributes = {};
					// Read all the attributes for this record/item
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
                            
                                                    
                            attributes["__MatchedAddress"] = response[0][0].name;
                            
                            

							graphic.setAttributes(attributes);

							featureCollection.featureSet.features.push(graphic);	
						}else{
							EmptyAddress.push(attributes[addressField]);
						}
						
                        if (i==items.length){
								console.log("Finished Geocoding");
								topic.publish("ImportAdresses/Geocoder", 
                                              {
                                    count: items.length,
                                    addressField:addressField,
                                    labelField:labelField,
                                    popupInfo:popupInfo,
                                    infoTemplate:infoTemplate,                                    
                                    
                                });
						}
					});


				 });

			 
			 var topicHandle = topic.subscribe("ImportAdresses/Geocoder", function(e){
				 //Add layer and label to map
				 console.timeEnd("geocoding");
				 console.log("Drawing layer... " );	
                 
				 layerAddedTimes=layerAddedTimes+1;				 
				 var layerid;
				 if(file.name.length>30){
					 layerid = file.name.substring(0,25);
				 }else{
					 layerid = file.name.substring(0,file.name.length - 4);
					 
				 }
				 
				 var featureLayer = new FeatureLayer(featureCollection, {
					infoTemplate: e.infoTemplate,
					id: "_" + layerid + "_" + layerAddedTimes ,
					 outFields: [e.addressField,e.labelField]
				 });
				 
				 featureLayer.__popupInfo = e.popupInfo;
				 				 
				 var symbol = new SimpleMarkerSymbol().setColor(symbolColor);
				 symbol.setSize("6");
				 var renderer = new SimpleRenderer(symbol);
				 featureLayer.setRenderer(renderer); 				 
				 
				 //label
                 var json = {
                     "labelExpressionInfo": {"value":  "{" + e.labelField + "}"}
                 };
                var labelClass = new LabelClass(json);
                var labelsymbol=new TextSymbol().setColor(new Color(fontColor));
                labelsymbol.font.setSize("10pt");
                labelsymbol.font.setFamily("arial");   
                labelClass.symbol = labelsymbol;
                featureLayer.setLabelingInfo([ labelClass ]);
  
				 that.map.addLayer(featureLayer);
				 that.zoomToData(featureLayer);	
				 
				 LayerList.push(featureLayer);			 
				 
				 
                result.innerHTML = "<b>Result</b>: " + featureCollection.featureSet.features.length + " addresses have been added to the map. <br><br>" + EmptyAddress.length + " addresses can't find a match: <br>";
                result.style.color = "black";
                result.style.fontSize = "medium";
				 
				 array.forEach(EmptyAddress, function(item){
					 result.innerHTML = result.innerHTML + item + "<br>";
			
				 }, this);
                 

                 featureCollection=null;
                 EmptyAddress=[];

				 
			 });
			}
		 }); 

		 
	 },
 
	 
	getSeparator: function (string) {
	 var separators = [",", "   ", ";", "|","	"];
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
	 var layerDefinition = {
		"geometryType": "esriGeometryPoint",
		"objectIdField": "__OBJECTID",
		"type": "Feature Layer",
		"typeIdField": "",
		"drawingInfo": {
		 "renderer": {
			"type": "simple"
		 }
		},
		"fields": [
		 {
			"name": "__OBJECTID",
			"alias": "__OBJECTID",
			"type": "esriFieldTypeOID",
			"editable": false,
			"domain": null
		 },
         {
			"name": "__MatchedAddress",
			"alias": "__MatchedAddress",
			"type": "esriFieldTypeString",
			"editable": false,
			"domain": null
		 }
		],
		"types": [],
		"capabilities": "Query"
	 };
        
	 var featureCollection = {
		"layerDefinition": layerDefinition,
		"featureSet": {
		 "features": [],
		 "geometryType": "esriGeometryPoint"
		}
	 };


	 var fields = store.getAttributes(items[0]);
	 array.forEach(fields, function (field) {
		var value = store.getValue(items[0], field);
		var parsedValue = Number(value);
		if (isNaN(parsedValue)) { //check first value and see if it is a number
		 featureCollection.layerDefinition.fields.push({
			"name": field,
			"alias": field,
			"type": "esriFieldTypeString",
			"editable": true,
			"domain": null
		 });
		}
		else {
		 featureCollection.layerDefinition.fields.push({
			"name": field,
			"alias": field,
			"type": "esriFieldTypeDouble",
			"editable": true,
			"domain": null
		 });
		}
	 });
	 return featureCollection;
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
		 json.content += field.label + ": ${" + field.fieldName + "}<br>";
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
        LayerList = [];
	}

		

//methodso communication between widgets:

 });
});