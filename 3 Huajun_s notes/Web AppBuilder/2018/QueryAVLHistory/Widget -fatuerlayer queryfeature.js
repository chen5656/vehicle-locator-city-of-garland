

define(['dojo/_base/declare', "dojo/_base/Color",'dojo/_base/lang',   'dojo/_base/html','dojo/dom',
				'jimu/BaseWidget',
				'esri/tasks/QueryTask','esri/tasks/query','esri/symbols/SimpleMarkerSymbol', 'esri/InfoTemplate',"esri/symbols/TextSymbol", "esri/layers/FeatureLayer",'esri/renderers/SimpleRenderer', "esri/layers/LabelClass",	"esri/symbols/SimpleLineSymbol",
				"esri/graphic"
],
function(declare,Color, lang, html,dom,
BaseWidget, 
QueryTask,Query,SimpleMarkerSymbol, InfoTemplate,TextSymbol, FeatureLayer,SimpleRenderer,LabelClass,SimpleLineSymbol,
Graphic) {
    
    var map;
    var VehicleID;
    var fontColor="#000000";
    
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
			
			if (dom.byId("DateTimeFrom").value >= dom.byId("DateTimeTo").value) {				
				return false;
			};		
			return true;
		},

    _onClick_ApplyQuery: function(){
        
            map=this.map;
			
    var featureLayer = new FeatureLayer("https://cogmap.garlandtx.gov/arcgis/rest/services/Water_and_VehicleLocator/Vehicle_Locator_History/MapServer/0",{
          outFields: ["*"]
        });
		 	
		        var symbol = new SimpleMarkerSymbol(
          SimpleMarkerSymbol.STYLE_CIRCLE, 
          12, 
          new SimpleLineSymbol(
            SimpleLineSymbol.STYLE_NULL, 
            new Color([247, 34, 101, 0.9]), 
            1
          ),
          new Color([207, 34, 171, 0.5])
        );
        featureLayer.setSelectionSymbol(symbol); 
        
               // Make unselected features invisible
        var nullSymbol = new SimpleMarkerSymbol().setSize(0);
        featureLayer.setRenderer(new SimpleRenderer(nullSymbol)); 
        
        
              map.addLayer(featureLayer);  
        
         var query = new Query();
  			
			query.where = "Vehicle ='400-1593' and  LocationDate>= '2017-09-14 09:09 AM' and LocationDate<= '2017-09-14 11:11 AM'"	
            
            featureLayer.queryFeatures(query, FeatureLayer.SELECTION_NEW, function(results){
                
                
                var r="";
            });
            	
  	}, 					
      
      

  });
});