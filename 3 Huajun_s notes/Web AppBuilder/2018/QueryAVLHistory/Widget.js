

define([ 'dojo/_base/declare', 'jimu/BaseWidget',     "esri/map", "esri/layers/FeatureLayer", 
        "esri/tasks/query", "esri/geometry/Circle",
        "esri/dijit/PopupTemplate",
        "esri/graphic", "esri/symbols/SimpleMarkerSymbol","esri/layers/LabelClass",	'esri/symbols/TextSymbol',
        "esri/symbols/SimpleLineSymbol", "esri/symbols/SimpleFillSymbol", "esri/renderers/SimpleRenderer",
        "esri/config", "esri/Color", "dojo/dom", "dojo/domReady!"
],
function(
        declare, BaseWidget,  Map, FeatureLayer,
        Query, Circle,PopupTemplate,
        Graphic, SimpleMarkerSymbol,LabelClass,TextSymbol,
        SimpleLineSymbol, SimpleFillSymbol, SimpleRenderer,
        esriConfig, Color, dom
              ) {
    
    var map;
    var VehicleID;
    var fontColor="#0000ff";
	var layerAddedTimes = 0;
    
  //To create a widget, you need to derive from BaseWidget.
  return declare([BaseWidget], {
    // Custom widget code goes here 
	
    baseClass: 'example-widget',
    
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
    },

     onOpen: function(){
      console.log('onOpen');

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
    
    isDate:function (val) { 
        
	    var d = new Date(val);
	    return !isNaN(d.valueOf());
		},
		
    validateDateInput: function (){
            
			if (dom.byId("DateTimeFrom").value=="") {				
				return false;
			};
			
			if (dom.byId("DateTimeTo").value=="") {				
				return false;
			};	
			
			if (this.isDate(dom.byId("DateTimeFrom").value)==false) {				
				return false;
			};
			
			if  (this.isDate(dom.byId("DateTimeTo").value)==false) {				
				return false;
			};
			
			if (new Date(dom.byId("DateTimeFrom").value)>=new Date(dom.byId("DateTimeTo").value)) {				
				return false;
			};		
			return true;
		},

    _onClick_ApplyQuery: function(){
        
           map=this.map;
        layerAddedTimes++;
        
        console.log('initial');
        dom.byId("QueryCount").innerHTML = "";		
	    dom.byId("ErrorMsg").innerHTML = "";	
        
          
        //debugger;
        if (this.validateDateInput()==false){	 	
				console.log('time validate false');
			 	dom.byId("ErrorMsg").innerHTML = "Date time input ERROR. Please check the value you entered.";	
			 	return;
        };
        
        
        var Avl_History = "https://cogmap.garlandtx.gov/arcgis/rest/services/Water_and_VehicleLocator/Vehicle_Locator_History/MapServer/0";
        //select Id, Vehicle, LoginName, CrewId, CrewNumber, DeptId, Speed, Heading, LocationDate, Location from AVL.dbo.AVL_History         
        //-- indentify filed: Vehicle and LocationDate                
        
        var featureLayer = new FeatureLayer(Avl_History,{outFields: ["*"]});    

          var query = new Query();
        
        VehicleID=dom.byId("VehicleID").value.replace(/\s+/g,'').trim();
        if (VehicleID=="*")	{ 
            query.where = " ";
        }else{query.where  = "Vehicle ='" + VehicleID + "' and ";
        };
          query.where = query.where + " LocationDate>= '" + dom.byId("DateTimeFrom").value.replace("T", " ") +  "' and LocationDate<= '" + dom.byId("DateTimeTo").value.replace("T", " ") + "'";
          
          // Use an objectIds selection query (should not need to go to the server)
          featureLayer.selectFeatures(query, FeatureLayer.SELECTION_NEW, function(results){
            var countOfResults =results.length;
            if(countOfResults==1000){							
                dom.byId("ErrorMsg").innerHTML =  "Query did not draw completely. Only first 1000 features have been added to the map. Please consider displaying a shorter amount of time and therefore a smaller data selection. ";	
                console.log('Too many records to draw');	
                added_features= DisplayResults(results);
            }else if(countOfResults==0){
                dom.byId("ErrorMsg").innerHTML = "0 features matched the input query.";	
                console.log('no record found');	
	
            }else{	
                dom.byId("QueryCount").innerHTML = countOfResults + " features matched the input query";		
                added_features= DisplayResults(results);
 				
            };	              
          });
        
        
        function DisplayResults(features) {
             //create a feature collection 
            var featureCollection = {
                "layerDefinition": null,
                "featureSet": {
                "features": [],
                "geometryType": "esriGeometryPoint"
                }
            };
            featureCollection.layerDefinition = {
                "geometryType": "esriGeometryPoint",
                "objectIdField": "ObjectID",
                "drawingInfo": {
                "renderer": {
                "type": "simple",
                "symbol": {
                "type": "esriPMS",
                "url": "widgets/QueryAVLHistory/images/symbol.png",
                "contentType": "image/png",
                "width": 12,
                "height": 12
                }
                }
                },
                "fields": [{
                "name": "ObjectID",
                "alias": "ObjectID",
                "type": "esriFieldTypeOID"
                }, {
                "name": "Vehicle",
                "alias": "Vehicle",
                "type": "esriFieldTypeString"
                }, {
                "name": "LocationDate",
                "alias": "LocationDate",
                "type": "esriFieldTypeDate"
                }]
            };

         //define a popup template
        var popupTemplate = new PopupTemplate({
          title: "{Vehicle}",
          description: "{LocationDate}"
        });           
            
            
        //create a feature layer based on the feature collection
        featureLayer = new FeatureLayer(featureCollection, {
          id: 'VehicleHistory'  + "_" +  VehicleID + "_" +  layerAddedTimes,
          infoTemplate: popupTemplate 
        });            
            
            
            //label
                 var json = {
                     "labelExpressionInfo": {"value":  "{LocationDate}"},
                     "fieldInfos": [{fieldName: "LocationDate",format: { "dateFormat": "shortDateShortTime"}}]
                 };
                var labelClass = new LabelClass(json);
                var labelsymbol=new TextSymbol().setColor(new Color(fontColor));
                labelsymbol.font.setSize("10pt");
                labelsymbol.font.setFamily("arial");   
                labelClass.symbol = labelsymbol;
                featureLayer.setLabelingInfo([ labelClass ]);
            
        map.addLayers([featureLayer]);
            
            if(dom.byId("chkShowLabel").checked==true){                
                featureLayer.showLabels=true;
            }else{                
                featureLayer.showLabels=false;
            }
    
                   featureLayer.applyEdits(features, null, null,function(addResults,updateResults,DeleteResults){   
                       var fl = featureLayer;                       
                       var ft = features;                       
                       var ar = addResults;       
                   });
            
            return features;
        }
  	}, 					
      
      

  });
});