

define(['dojo/_base/declare','dojo/_base/lang','dojo/_base/html','dojo/dom',"dojo/_base/array","dojo/on", 
'jimu/BaseWidget',
         "esri/layers/FeatureLayer",  "esri/tasks/query","esri/geometry/Geometry",	
           "esri/symbols/SimpleFillSymbol", "esri/symbols/SimpleLineSymbol", "esri/Color","esri/request",	
            'esri/InfoTemplate',		
				"dojo/domReady!", "dojo/parser"

],
function(declare, lang, html,dom,array,on, 
		  BaseWidget, 
		  FeatureLayer,  Query, Geometry,    
		  SimpleFillSymbol, SimpleLineSymbol, Color, esriRequest,
		  InfoTemplate) {
			     
	var featureLayer;
	var clickEvt;
  //To create a widget, you need to derive from BaseWidget.
  return declare([BaseWidget], {
    // Custom widget code goes here        
	
    baseClass: 'calgeometry-widget',
    
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
      this._buildLayerList();
    },

     onOpen: function(){
      console.log('onOpen');
     },

     onClose: function(){
       console.log('onClose');
		 this._EndSel();
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
	  
	  _buildLayerList:function () {	
	  console.log('_buildLayerList');
	  var layerlist= dom.byId("GeometryLayerList");
	//add parcel layer to list
	  layerlist.innerHTML = "<option value="+ "http://cogmap.garlandtx.gov/arcgis/rest/services/COGMAP/COGMAP_Base/MapServer/2" + ">" + "Parcels" + "</option>";
	  var layerUrl, layerName;

	  //get rest service layer list
	  var arrRestlayer = this.map.layerIds;  
		  
	  for(i=2;i<= arrRestlayer.length-1;i++){ //0 is base map, 1 is COGMAP_Base
			var restlayer = this.map.getLayer(arrRestlayer[i]);
		  
			if (restlayer.visible = true){
				array.forEach(restlayer.layerInfos,function(item){ //get layer info;
		  
		  layerUrl = restlayer.url + "/" + item.id;
		  
		  var requestHandle = esriRequest({
			  "url": layerUrl,
			  "content": {
				  "f": "json"
			  },
			  "callbackParamName": "callback"
		  });
		  
		  requestHandle.then(function(response){	  
			  if(response.geometryType== "esriGeometryPolygon"){ //only shows polygon layers
				  array.forEach(restlayer.layerInfos,function(item){
					  if (item.name==response.name){
						   layerlist.innerHTML =  "<option value="+ restlayer.url + "/" + item.id + ">" + response.name + "</option>" + layerlist.innerHTML;	
						  return 1;
					  };				  
				  }, this);		  
			  };
		  });		
	  },this);	
			}
	  }
		  	  
	  	
	 },
	  
	  _ToolOn: function(){  
		  
		  this.map.setInfoWindowOnClick(false);
		  
		  var layerUrl = dom.byId("GeometryLayerList").value;		  
	  
		  var selectionSymbol = new SimpleFillSymbol(
            SimpleFillSymbol.STYLE_NULL,
            new SimpleLineSymbol("solid",new Color("yellow"),2),
            null
		  ); 
		  
		  if (layerUrl=="http://cogmap.garlandtx.gov/arcgis/rest/services/COGMAP/COGMAP_Base/MapServer/2") {
			  //parcel 	  
			  featureLayer = new FeatureLayer(layerUrl,{
				  mode: FeatureLayer.MODE_SELECTION,
				  outFields: ["Shape_Length", "Shape_Area"]
			  }); 
			  var infoTemplate = new InfoTemplate("Attributes", "Area: ${Shape_Area:NumberFormat}<br>Length: ${Shape_Length:NumberFormat}");
		  }else{		  
			  featureLayer = new FeatureLayer(layerUrl,{
				  mode: FeatureLayer.MODE_SELECTION,
				  outFields: ["SHAPE.AREA", "SHAPE.LEN"]
			  }); 
			  var infoTemplate = new InfoTemplate("Attributes", "Area: ${SHAPE.AREA:NumberFormat}<br>Length: ${SHAPE.LEN:NumberFormat}");
		  };
		  		  
		  featureLayer.setSelectionSymbol(selectionSymbol);
		  featureLayer.setInfoTemplate(infoTemplate);  
		  
		  this.map.addLayers([featureLayer]);
		  
		  //when users click on the map select the feature using the map point 
		  
		  clickEvt = this.map.on("click",lang.hitch(this,this._clickMap));
		  //this.clickEvt = on(this.map, "click", lang.hitch(this,this._clickMap));
		  
		  dom.byId("StartShowGeometry").className = "disable-button";
		  dom.byId("StartShowGeometry").disabled=true;			  
		  dom.byId("StopShowGeometry").className = "black-button";
		  dom.byId("StopShowGeometry").disabled=false;
		  dom.byId("GeometryLayerList").disabled=true;			  

	  }	,
	  
	  _clickMap: function(e){
		  
		  var layerIds = this.map.graphicsLayerIds;
		  var featureLayer = this.map.getLayer(layerIds[0]);
		  
		  var query = new Query();
		  query.geometry = e.mapPoint;
		  
		  var map = this.map

		  featureLayer.selectFeatures(query, FeatureLayer.SELECTION_NEW, function(selection) {
					  if (selection.length > 0) {
						//store the current feature
						updateFeature = selection[0];
						map.infoWindow.setTitle(selection[0].getLayer().name);
						map.infoWindow.setContent(selection[0].getContent());
						map.infoWindow.show(e.screenPoint, map.getInfoWindowAnchor(e.screenPoint));
					  }
					  else {
						map.infoWindow.hide();
					  }
		  });

	  },
	  
	  _EndSel: function(){
		  
		   //remove the feature layer. 
		  this.map.removeLayer(featureLayer);
		  		  
		  // turn map's setInfoWindowOnClick on
		  this.map.setInfoWindowOnClick(true);
		  
		  clickEvt.remove();
		  //this.map.off("click",this._clickMap);
		  
		  dom.byId("StartShowGeometry").className = "black-button";
		  dom.byId("StartShowGeometry").disabled=false;			  
		  dom.byId("StopShowGeometry").className = "disable-button";
		  dom.byId("StopShowGeometry").disabled=true;		  
		  dom.byId("GeometryLayerList").disabled=false;	
		  
           
		}

//methodso communication between widgets:

  });
});