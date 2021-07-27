

define(['dojo/_base/declare','dojo/_base/lang','dojo/_base/html','dojo/dom',"dojo/_base/array",
				'jimu/BaseWidget',
				'esri/symbols/TextSymbol','esri/renderers/SimpleRenderer',"esri/symbols/Font","esri/Color",				
  "esri/layers/LabelLayer","esri/request", "esri/symbols/SimpleFillSymbol", "esri/symbols/SimpleLineSymbol",
		 "esri/layers/FeatureLayer",  "esri/layers/GraphicsLayer", "esri/tasks/query","esri/graphic","esri/geometry/Circle",
		"esri/dijit/ColorPicker",
"dojo/parser","dijit/form/Select"
],
function(declare, lang, html,dom,array,
BaseWidget, 
TextSymbol, SimpleRenderer, Font,Color,
		  LabelLayer,esriRequest,SimpleFillSymbol,SimpleLineSymbol,
		 FeatureLayer,GraphicsLayer, Query ,Graphic, Circle,
		 ColorPicker) {
			     
	var featureLayer, labelLayer ;
    var undoID;
	var clickEvt;
  //To create a widget, you need to derive from BaseWidget.
  return declare([BaseWidget], {
    // Custom widget code goes here 
	
    baseClass: 'Labeling-widget',	  
	  	     
    //this property is set by the framework when widget is loaded.
     //name: 'CustomWidget',


//methods to communication with app container:

    postCreate: function() {
       this.inherited(arguments);
        	   var labelGraphicsLayer = new GraphicsLayer();
               labelGraphicsLayer.id = "LabelGraphicsLayer";
               this.map.addLayer(labelGraphicsLayer);
               labelLayer = this.map.getLayer("LabelGraphicsLayer");

       console.log('postCreate');
    },

    startup: function() {
      this.inherited(arguments);
    // this.mapIdNode.innerHTML = 'map id:' + this.map.id;
          console.log('startup');
    },

     onOpen: function(){
		 console.log('onOpen');
		 this._buildLayerList();	
		 var colorPicker = new ColorPicker({
			 color : "#FFFFFF",
			 required : true,
			 showTransparencySlider : false
			 }, this._FontColor);
		 colorPicker.on("color-change",function(ColorChange){
						console.log("font color change " + ColorChange.color);
						var fontstyle = dom.byId("AddLabelFontStyle");	
						fontstyle.style.color =ColorChange.color.toHex();
						});	
		 this._UpdateFontSize();
     },

     onClose: function(){
       console.log('onClose');	 
		this._ToolOff();
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
		this._ToolOff();
    },
  
		
	_buildLayerList:function () {	
		
		console.log('_buildLayerList'); 
		var layerlist = dom.byId("AddLabelLayerList");
		layerlist.innerHTML = "";

		//get rest service layer list
		var arrRestlayer = this.map.layerIds;
		
		for(i=2;i<= arrRestlayer.length-1;i++){ //0 is base map, 1 is COGMAP_Base
			var restlayer = this.map.getLayer(arrRestlayer[i]);
			array.forEach(restlayer.visibleLayers.sort(),function(item){ //get layer info;
				if(item != -1 ){
					layerlist.innerHTML = layerlist.innerHTML +  "<option value="+ restlayer.url + "/" + item + ">" + restlayer.layerInfos[item].name + "</option>" ;
				};				
			}, this);		
		}
				
		var restlayer = this.map.getLayer(arrRestlayer[1]);//0 is base map, 1 is COGMAP_Base
		array.forEach(restlayer.visibleLayers.sort(),function(item){ //get layer info;
			if(item != -1 ){
				layerlist.innerHTML = layerlist.innerHTML +  "<option value="+ restlayer.url + "/" + item + ">" + restlayer.layerInfos[item].name + "</option>" ;
			};				
		}, this);
		
		this._getFieldList();
	},

	_getFieldList: function() {

		var fieldlist = dom.byId("AddLabelFieldList");
		fieldlist.innerHTML ="";

		var layerUrl = dom.byId("AddLabelLayerList").value;
		if (layerUrl==""){return;};
		console.log("get field list:" + layerUrl);
		
		var requestHandle = esriRequest({
			"url": layerUrl,
			"content": {
			  "f": "json"
			},
			"callbackParamName": "callback"
		});

		requestHandle.then(function(response){	 
			  array.forEach(response.fields,function(item){
				  fieldlist.innerHTML = fieldlist.innerHTML + "<option value="+ item.name + ">" + item.name+ "</option>" ;	
			  }, this);		
		});	
	},	  
	  
	_UpdateFontSize: function() {
		console.log('fontsize');
		dom.byId("AddLabelFontStyle").style.fontSize = dom.byId("AddLabelFontSize").value;
	},
	
	_ToolOn: function(){  
        
		
		this.map.setInfoWindowOnClick(false);

		var layerUrl = dom.byId("AddLabelLayerList").value;		
		
		var field=dom.byId("AddLabelFieldList").value;

		var selectionSymbol = new SimpleFillSymbol(
			SimpleFillSymbol.STYLE_NULL,
			new SimpleLineSymbol("solid",new Color("yellow"),2),
			null
		); 
        	  
		featureLayer = new FeatureLayer(layerUrl,{
		  mode: FeatureLayer.MODE_SELECTION,
		  outFields: [field ]
		}); 

		featureLayer.setSelectionSymbol(selectionSymbol);
		this.map.addLayers([featureLayer]);
		
		
		var that = this;
        
        undoID = 0;

		//when users click on the map select the feature using the map point 
		clickEvt = this.map.on("click",function(e){
            
                      
            //offset
            var offset_X =that.getDistanceForPixels(dom.byId("Offset_X").value);
            var offset_Y =that.getDistanceForPixels(dom.byId("Offset_Y").value);
			
			// in order to select point features, buffer map point by 10 pixels
			var tolerance_unit = dom.byId("tolerance_unit").value;
			var radius;
			var tolerance_value = dom.byId("tolerance").value;	
			if(tolerance_unit=="px"){
				radius = that.getDistanceForPixels(tolerance_value);
				radiusUnit=esri.Units.METERS;
			}else if(tolerance_unit=="feet"){
				radius = tolerance_value;
				radiusUnit=esri.Units.FEET;
			}else if(tolerance_unit=="miles"){
				radius= tolerance_value;
				radiusUnit=esri.Units.MILES;
			};
			var selectionArea = new Circle({
				center: e.mapPoint,
				radius: radius,
				radiusUnit: radiusUnit
			});
  
			var query = new Query();
			query.geometry = selectionArea;

			featureLayer.selectFeatures(query, FeatureLayer.SELECTION_NEW, function(selection) {
				console.log(selection.length + " features selected");
                 undoID =undoID+1;
                				
				array.forEach(selection,function(item){ 
					
					var graphicLabel = new Graphic();					
					
					if(item.geometry.type=="polyline" || item.geometry.type=="polygon"){
						//polyline geometry can't use TextSymbol as symbol.
						graphicLabel.geometry = item.geometry.getExtent().getCenter().offset(offset_X,offset_Y);
					}else{
						graphicLabel.geometry = item.geometry.offset(offset_X,offset_Y);}			
                    
					
					var symbol = new TextSymbol().setColor(new Color(dom.byId("AddLabelFontStyle").style.color));
					symbol.font.setSize(dom.byId("AddLabelFontSize").value);
					symbol.font.setFamily("arial");
					symbol.font.setWeight(Font.WEIGHT_BOLD);
					symbol.yoffset = 4;
					symbol.text= "" + item.attributes[field] + "";
					
					graphicLabel.setSymbol(symbol);		
                    graphicLabel.undoID = undoID;
					labelLayer.add(graphicLabel);	
				}, this);
			});

		  });

		dom.byId("StartAddLabels").className = "disable-button";
		dom.byId("StartAddLabels").disabled=true;			  
		dom.byId("StopAddLabels").className = "black-button";
		dom.byId("StopAddLabels").disabled=false;  
		dom.byId("AddLabelLayerList").disabled=true;		
		dom.byId("AddLabelFieldList").disabled=true;		  
		dom.byId("UndoButton").className = "black-button";
		dom.byId("UndoButton").disabled=false;     

	},
	  
	  // return the distance on the map of the givne number of pixels
	getDistanceForPixels: function (pixels) {
		var distancePerPixel = 0,
			distance = 0;
		distancePerPixel = this.map.extent.getWidth() / this.map.width;
		distance = pixels * distancePerPixel;
		return distance;
	},
	  
	_ToolOff:function() {
    
        if(clickEvt){
            clickEvt.remove();
            
            dom.byId("StartAddLabels").className ="black-button"; 
            dom.byId("StartAddLabels").disabled= false; 		  
            dom.byId("StopAddLabels").className = "disable-button";
            dom.byId("StopAddLabels").disabled=true; 
            dom.byId("AddLabelLayerList").disabled=false; 		
            dom.byId("AddLabelFieldList").disabled=false; 	

            this.map.removeLayer(featureLayer);


            this.map.setInfoWindowOnClick(true);
        }	
		
	},

	_RemoveLabels:function(){
        labelLayer.clear();
        undoID = 0;
	},
      
    _UndoLabels: function(){
        if(undoID >0){
            console.log(labelLayer.graphics);
            
            for (i = labelLayer.graphics.length - 1; i >= 0; i--) { 
                
               if(labelLayer.graphics[i].undoID == undoID){                   
                   labelLayer.remove(labelLayer.graphics[i]);                   
               }else{
                   break;
               }
            }
            
            undoID =undoID -1;
        }
        
    }
		
		

//methodso communication between widgets:

  });
});