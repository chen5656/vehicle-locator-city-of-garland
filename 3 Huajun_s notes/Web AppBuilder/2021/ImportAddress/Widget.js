//need to add:      "showLabels":true   to the config.json, under:     "mapOptions": {
define(['dojo/_base/declare', 'dojo/_base/lang',
		'dojo/dom', "dojo/dom-construct", "dojo/dom-class", "dijit/Dialog", "dojo/query",
		"dojo/_base/array", "dojo/on",
		'jimu/BaseWidget',
		"esri/symbols/SimpleMarkerSymbol", "esri/symbols/SimpleLineSymbol", 'esri/symbols/TextSymbol', 'esri/renderers/SimpleRenderer', "esri/Color",
		"esri/layers/LabelClass", "esri/tasks/locator",
		"esri/graphic", "esri/geometry/Extent", "esri/InfoTemplate",
		"esri/layers/FeatureLayer", "esri/dijit/ColorPicker",
		"dojox/data/CsvStore",
		"dojox/encoding/base64",
		"dojo/domReady!",
		"dijit/form/Select",
		"dojo/parser"
	],
	function (declare, lang,
		dom, domConstruct, domClass, Dialog, domQuery,
		array, on,
		BaseWidget,
		SimpleMarkerSymbol, SimpleLineSymbol, TextSymbol, SimpleRenderer, Color,
		LabelClass, Locator,
		Graphic, Extent, InfoTemplate,
		FeatureLayer, ColorPicker,
		CsvStore
	) {

		//To create a widget, you need to derive from BaseWidget.
		return declare([BaseWidget], {
			// Custom widget code goes here 

			baseClass: 'Labeling-widget',

			postCreate: function () {
				this.inherited(arguments);
				console.log('postCreate');
			},

			startup: function () {
				this.inherited(arguments);
				console.log('startup');
				var self = this;
				var disableElements = domQuery(".tabcontent", this.importAddressPanel).concat(domQuery(".cmd-btn", this.importAddressPanel));
				this._widegtDefaultParamenter = {
					locateURL: {
						addressLocator: "https://cogmap.garlandtx.gov/arcgis/rest/services/LOCATORS/GARLAND_ADDRESS_LOCATOR/GeocodeServer",
						roadLocator: "https://cogmap.garlandtx.gov/arcgis/rest/services/LOCATORS/GARLAND_ROAD_LOCATOR/GeocodeServer"
					},
					addressStrings: ["address", "addr", "location"],
					separators: [",", ";", "|"],
					symbolColor: "#002673",
					fontColor: "#000000",
					disableElements: disableElements //disable these elements when processing
				};
				this._widgetResult = {
					file: {},
					layerList: [],
					layerAddedTimes: 0,
					symbolColor: this._widegtDefaultParamenter.symbolColor,
					fontColor: this._widegtDefaultParamenter.fontColor,
					csvdata: {
						dataArray: [],
						fieldArray: []
					}
				};

				var helpDialog = new Dialog({ //generate hint dialog.
					id: "import-address-dialog",
					style: "width:350px;height:auto;left:28px;top:188px;z-index:501;opacity:1;"
				});
				var addressesNoMatchDialog = new Dialog({ //no match address list dialog.
					id: "address-nomatch-dialog",
					style: "width:350px;height:auto;left:28px;top:188px;z-index:501;opacity:1;"
				});

				this.importAddrLocatorURL.value = this._widegtDefaultParamenter.locateURL.addressLocator;

				this._widgetDialog = {
					help: helpDialog,
					addressesNoMatch: addressesNoMatchDialog
				}
				createHelp(this._widgetDialog.help);

				var colorPickerSymbol = new ColorPicker({
					color: self._widgetResult.symbolColor,
					required: true,
					showTransparencySlider: false
				}, this.importAddrMarkerColor);
				this.iconForSymbol.style.color = this._widgetResult.symbolColor;

				var colorPickerFont = new ColorPicker({
					color: self._widgetResult.fontColor,
					required: true,
					showTransparencySlider: false
				}, this.importAddrLabelColor);
				this.iconForLabel.style.color = this._widgetResult.fontColor;

				colorPickerSymbol.on("color-change", function (ColorChange) {
					self._widgetResult.symbolColor = ColorChange.color;
					self.iconForSymbol.style.color = ColorChange.color;
				});
				colorPickerFont.on("color-change", function (ColorChange) {
					self._widgetResult.fontColor = ColorChange.color;
					self.iconForLabel.style.color = ColorChange.color;
				});

				//drop
				var dropNode = this.dropArea;
				this.own(on(dropNode, "dragenter", function (event) {
					event.preventDefault();
					self.clearResultInfo();
				}));
				this.own(on(dropNode, "drop", function (event) {
					event.preventDefault();
					self.browserFile(event);
				}));

				// by default, dropping a file on a page will cause
				// the browser to navigate to the file
				this.own(on(this, "dragenter", function (event) {
					event.preventDefault();
				}));
				this.own(on(this, "dragleave", function (event) {
					event.preventDefault();
				}));
				this.own(on(this, "dragover", function (event) {
					event.preventDefault();
				}));
				this.own(on(this, "drop", function (event) {
					event.preventDefault();
				}));

				function createHelp(dialog) {
					var domNode = dialog.domNode;
					domClass.add(domNode, "jimu-popup jimu-message");
					dojo.empty(domNode);
					var helpContent = domConstruct.create("div", {
						class: 'content content-static'
					}, domNode);
					var helpIntro = domConstruct.create("div", {
						class: 'intro'
					}, helpContent);
					domConstruct.create("div", {
						innerHTML: "This tool is to import a set of addresses and display it. Hints on this widget:"
					}, helpIntro);
					// var helpLabel = domConstruct.create("label", {
					// 	innerHTML: '',
					// 	for:"import-address-hint"
					// }, helpIntro);
					var ul = domConstruct.create("ul", {
						id: "import-address-hint"
					}, helpIntro);
					domConstruct.create("li", {
						innerHTML: 'Import a comma, semi-colon, or tab delimited text file (<b>CSV or TXT</b>)'
					}, ul);
					domConstruct.create("li", {
						innerHTML: '<u title="For example - 200 N Fifth St Garland TX">Single Line Address</u> information must be saved with one of the following column names: <b>address, addr, location</b>'
					}, ul);
					domConstruct.create("li", {
						innerHTML: 'Labeling is optional.'
					}, ul);
					domConstruct.create("li", {
						innerHTML: 'A maximun of <b>1000 features</b> will be displayed'
					}, ul);

					var buttonContainer = domConstruct.create("div", {
						class: 'button-container'
					}, domNode);
					var buttonNode = domConstruct.create("button", {
						innerHTML: '<i class="esri-icon-check-mark"></i> OK',
						title: "OK",
						class: 'jimu-btn jimu-popup-action-btn jimu-float-trailing jimu-trailing-margin1'
					}, buttonContainer);
					on(buttonNode, "click", function () {
						dialog.hide();
					});
				}

			},

			onOpen: function () {
				console.log('onOpen');
				this.disable_and_enable_elements(this._widegtDefaultParamenter.disableElements, true); //enable 
			},



			displayHelp: function () {
				this._widgetDialog.help.show();
			},

			displayTab: function () {
				var target = event.currentTarget;
				//clear all tabs
				domQuery(".tabcontent", this.importAddressPanel).forEach(function (elem) {
					elem.style.display = "none";
				});
				domQuery(".tablinks", this.importAddressPanel).forEach(function (elem) {
					elem.className = elem.className.replace(" active", "");
				});
				//show clicked one
				document.querySelectorAll('[tabname='.concat(target.attributes.tabtitle.value, ']'))[0].style.display = "block";
				target.className += " active";
			},

			turnOnLabel: function (e) {
				this.clearResultInfo();
				if (e.currentTarget.checked) {
					if (this._widgetResult.csvdata.fieldArray.length > 0) {
						domQuery(".label_setting", this.importAddressPanel)[0].style.display = "block";
					} else {
						this.showResultInfo("Can't read field info. Please try again.", "alert-danger");
						e.currentTarget.checked = false;
					}
				} else {
					domQuery(".label_setting", this.importAddressPanel)[0].style.display = "none";
				}
			},

			locatorUpdate: function (e) {
				if (e.currentTarget.value != "userLocator") {
					this.importAddrLocatorURL.value = this._widegtDefaultParamenter.locateURL[e.currentTarget.value];
					this.importAddrLocatorURL.disabled = true;
				} else {
					this.importAddrLocatorURL.value = this._widegtDefaultParamenter.locateURL.addressLocator;
				}

			},


			browserFile: function (e) {
				var self = this;
				this._widgetResult.file = {};
				this._widgetResult.csvdata = {
					dataArray: [],
					fieldArray: []
				};
				this.filePathValue.innerHTML = "..."; //a bug that I don't know how to fix, when drop , mouse click and mouse change.
				dojo.empty(this.labelFieldSelect);
				this.labelFieldCheckbox.checked = false;
				domQuery(".label_setting", this.importAddressPanel)[0].style.display = "none";

				if (e.target && e.target.files && e.target.files.length > 0) {
					this._widgetResult.file = e.target.files[0];
					this.filePathValue.innerHTML = this._widgetResult.file.name
				} else if (e.dataTransfer && e.dataTransfer.files && e.dataTransfer.files.length > 0) {
					this._widgetResult.file = e.dataTransfer.files[0];
					this.filePathValue.innerHTML = this._widgetResult.file.name
				} else {
					return;
				}

				//readfile
				if (this._widgetResult.file && this._widgetResult.file.name) {
					self.disable_and_enable_elements(this._widegtDefaultParamenter.disableElements, false); //disable 
					self.showResultInfo("Loading input file", "alert-primary");
					var reader = new FileReader();
					reader.onload = function () {
						readFromCSV(reader.result);
					};
					reader.readAsText(this._widgetResult.file);
				}

				function readFromCSV(data) {
					console.log("Finished reading data ");

					var newLineIndex = data.indexOf("\n");
					var firstLine = lang.trim(data.substr(0, newLineIndex)); //remove extra whitespace
					var separator = getSeparator(firstLine, self._widegtDefaultParamenter.separators);
					var csvStore = new CsvStore({
						data: data,
						separator: separator
					});

					//check if file valid
					self.clearResultInfo();
					csvStore.fetch({
						onComplete: function (items) {
							self._widgetResult.csvdata.dataArray = items[0]._csvStore._dataArray;
							self._widgetResult.csvdata.fieldArray = items[0]._csvStore._attributes;
							self._widgetResult.addressField = "";

							if (items.length == 0) {
								//no data. It can be an empty file, or a file with only one row.
								self.showResultInfo("<p>Can't read this file.</p>", "alert-danger");
								return;
							}
							self._widgetResult.csvdata.fieldArray.forEach(function (fieldName) {
								if (fieldName) {
									//address field
									var matchId = array.indexOf(self._widegtDefaultParamenter.addressStrings,
										fieldName.toLowerCase());
									if (matchId !== -1) {
										self._widgetResult.addressField = fieldName;
									}
								}
							});
							if (self._widgetResult.addressField == "") {
								self.showResultInfo("<p>Can't find Address Field.</p>", "alert-danger");
								return;
							}
							updateLabelSelect(self._widgetResult.csvdata.fieldArray, self.labelFieldSelect); //update label selector

							self.disable_and_enable_elements(this._widegtDefaultParamenter.disableElements, true); //enable 		
							dojo.empty(self.resultInfo);
						}
					});
				}

				function getSeparator(string, separators) {
					var maxSeparatorLength = 0;
					var maxSeparatorValue = "";
					separators.forEach(function (separator) {
						var length = string.split(separator).length;
						if (length > maxSeparatorLength) {
							maxSeparatorLength = length;
							maxSeparatorValue = separator;
						}
					});
					return maxSeparatorValue;
				}

				function updateLabelSelect(fields, domNode) {
					//	var node = self.labelFieldSelect;
					dojo.empty(domNode);
					fields.forEach(function (field) {
						domConstruct.create("option", {
							class: '',
							value: field,
							innerHTML: field
						}, domNode);
					})
				}
			},

			clearResultInfo: function () {
				this.disable_and_enable_elements(this._widegtDefaultParamenter.disableElements, true); //enable 				
				dojo.empty(this.resultInfo);
			},

			showResultInfo: function (string, strClass) {
				var node = domConstruct.create("div", {
					innerHTML: string,
					class: 'alert'
				}, this.resultInfo);

				if (strClass) {
					domClass.add(node, strClass);
				}
			},

			disable_and_enable_elements: function (elementList, enabled) {
				if (enabled == true) {
					elementList.forEach(function (elem) { //remove
						domClass.remove(elem, "pointer-disable");
						domClass.remove(elem.parentElement, "cursor-disable");
					});

				} else {
					elementList.forEach(function (elem) {
						domClass.add(elem, "pointer-disable");
						domClass.add(elem.parentElement, "cursor-disable");
					});
				}
			},

			ImportAddress: function () {
				var self = this;
				var map = this.map;
				self.clearResultInfo();
				if (self._widgetResult.csvdata.dataArray.length > 0) {
					self.showResultInfo("<p>Request is processing...</p>", "alert-primary");
					self.disable_and_enable_elements(self._widegtDefaultParamenter.disableElements, false); //disable 
					// geocode
					self._widgetResult.addressArray = this._widgetResult.csvdata.dataArray.map(function (item, i) {
						var itemAttrs = {
							"_OBJECTID": i
						};
						self._widgetResult.csvdata.fieldArray.forEach(function (fieldName, i) {
							itemAttrs[fieldName] = item[i];
						});
						itemAttrs["Single Line Input"] = itemAttrs[self._widgetResult.addressField];
						return itemAttrs;
					});
					geocodeAddrList(self._widgetResult.addressArray, self.importAddrLocatorURL.value, self._widgetResult.csvdata.fieldArray);
				} else {
					self.showResultInfo("<p>Can't read selected file. Please try again.</p>", "alert-danger");
				}

				function geocodeAddrList(addresses, locateURL, fieldNames) {
					var locator = new Locator(locateURL);
					locator.outSpatialReference = map.spatialReference;

					if (addresses.length > 1000) {
						addresses = addresses.slice(0, 1000); //only display first 1000 results.
					}
					console.time("geocoding");
					locator.addressesToLocations({
						addresses: addresses
					}).then(function (results) {
						self.clearResultInfo();
						var addrPoints = results.map(function (result, i) {
							var graphic = new Graphic({
								attributes: lang.mixin(addresses[i], result.attributes),
								geometry: result.location
							});
							return graphic;
						});

						var addressesNoMatch = addrPoints.filter(function (e) {
							return e.attributes.Score < 50;
						});
						var addressesMatch = addrPoints.filter(function (e) {
							return e.attributes.Score >= 50;
						});
						var noMatchStr = ""
						if (addressesNoMatch.length > 0) {
							addressesNoMatch_Dialog(addressesNoMatch, self._widgetDialog.addressesNoMatch);
							noMatchStr = "<p>" + addressesNoMatch.length + " addresses can't find a match: " + "<a href='#' id='displayNoMatch'>Show details.</a></p>";
						} else {
							noMatchStr = "<p>All addresses in the file have been added to the map.<a href='#' id='displayNoMatch'></a></p>"
						}

						var featureCollection = generateFeatureCollectionTemplate(fieldNames);
						featureCollection.featureSet.features = addressesMatch;
						console.timeEnd("geocoding");
						console.log("Drawing layer... ");

						self._widgetResult.layerAddedTimes++;
						var layerName = (self._widgetResult.file.name.length > 30 ? self._widgetResult.file.name.substring(0, 25) : self._widgetResult.file.name.substring(0, self._widgetResult.file.name.length - 4));
						var layerId = "_" + layerName + "_" + self._widgetResult.layerAddedTimes;

						var str = "<p><b>Result</b>:</p><p>" + addressesMatch.length + " addresses have been added to the map. </p>" + noMatchStr;
						self.showResultInfo(str, "alert-primary");

						on(dom.byId("displayNoMatch"), "click", function () {
							self._widgetDialog.addressesNoMatch.show();
						});
						addResultToMap(layerId, featureCollection);
					});


					function addResultToMap(layerId, featureCollection) {

						//Add layer and label to map
						var popupInfo = generateDefaultPopupInfo(featureCollection);
						var infoTemplate = new InfoTemplate(buildInfoTemplate(popupInfo));

						var featureLayer = new FeatureLayer(featureCollection, {
							infoTemplate: infoTemplate,
							id: layerId,
							outFields: ["*"]
						});

						var symbol = new SimpleMarkerSymbol(
							SimpleMarkerSymbol.STYLE_CIRCLE,
							6,
							new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,
								new Color("#858585"), 1),
							self._widgetResult.symbolColor
						);

						var renderer = new SimpleRenderer(symbol);
						featureLayer.setRenderer(renderer);

						//label
						if (self.labelFieldCheckbox.checked) {
							var json = {
								"labelExpressionInfo": {
									"value": "{" + self.labelFieldSelect.value + "}"
								}
							};
							var labelClass = new LabelClass(json);
							var labelsymbol = new TextSymbol().setColor(new Color(self._widgetResult.fontColor));
							labelsymbol.font.setSize("10pt");
							labelsymbol.font.setFamily("arial");
							labelClass.symbol = labelsymbol;
							featureLayer.setLabelingInfo([labelClass]);
							featureLayer.showLabels = true;
						}

						map.addLayer(featureLayer);

						zoomToData(featureCollection.featureSet.features, map)
						self._widgetResult.layerList.push(featureLayer);
						featureCollection = null;
					};

					function addressesNoMatch_Dialog(addressesNoMatch, dialog) {

						var dialogNode = dialog.domNode;
						domClass.add(dialogNode, "jimu-popup jimu-message");
						dojo.empty(dialogNode);

						var dialogContent = domConstruct.create("div", {
							class: 'content content-static'
						}, dialogNode);
						var dialogIntro = domConstruct.create("div", {
							class: 'intro'
						}, dialogContent);
						var dialogLabel = domConstruct.create("label", {
							innerHTML: "Addresses that can't be added to this map (only display first 15):"
						}, dialogIntro);
						var ol = domConstruct.create("ol", null, dialogLabel);
						for (i = 0; i < addressesNoMatch.length; i++) {
							if (i == 15) {
								break;
							}
							domConstruct.create("li", {
								innerHTML: addressesNoMatch[i].attributes["Single Line Input"]
							}, ol);
						}

						var buttonContainer = domConstruct.create("div", {
							class: 'button-container'
						}, dialogNode);
						var buttonOk = domConstruct.create("button", {
							innerHTML: '<i class="esri-icon-check-mark"></i> OK',
							title: "Click to close",
							class: 'jimu-btn jimu-popup-action-btn jimu-float-trailing jimu-trailing-margin1'
						}, buttonContainer);
						on(buttonOk, "click", function () {
							dialog.hide();
						});
						var buttonDownload = domConstruct.create("button", {
							innerHTML: '<i class="esri-icon-download"></i> Download the list',
							title: "Download the unmatched list",
							class: 'jimu-btn jimu-popup-action-btn jimu-float-trailing jimu-trailing-margin1'
						}, buttonContainer);
						on(buttonDownload, "click", function () {
							download("".concat(self._widgetResult.file.name.substring(0, 35), "-address-not-find.txt"));

							function download(filename) {
								var element = document.createElement('a');
								var text =
									addressesNoMatch.map(function (addr) {
										return addr.attributes["Single Line Input"];
									}).join("\r\n");
								element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
								element.setAttribute('download', filename);
								element.style.display = 'none';
								document.body.appendChild(element);
								element.click();
								document.body.removeChild(element);
							}
						});

					}
				}

				function generateFeatureCollectionTemplate(fields) {
					//var fields = store.getAttributes(items[0]);
					fields = fields.map(function (field) {
						// if (field.type == 'Number') {
						// 		"type": "esriFieldTypeDouble",
						return {
							"name": field,
							"alias": field,
							"type": "esriFieldTypeString",
							"editable": true,
							"domain": null
						};
					});

					fields = [{
						"name": "Match_addr",
						"alias": "Match_addr",
						"type": "esriFieldTypeString",
						"editable": false,
						"domain": null
					}, {
						"name": "Score",
						"alias": "Score",
						"type": "esriFieldTypeDouble",
						"editable": false,
						"domain": null
					}].concat(fields);

					var layerDefinition = {
						"geometryType": "esriGeometryPoint",
						"objectIdField": "_OBJECTID",
						"type": "Feature Layer",
						"typeIdField": "",
						"drawingInfo": {
							"renderer": {
								"type": "simple"
							}
						},
						"fields": fields,
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

					return featureCollection;
				}

				function generateDefaultPopupInfo(featureCollection) {
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
								} else if (item.type in decimal) {
									format = {
										places: 2,
										digitSeparator: true
									};
								} else if (item.type in dt) {
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
				}

				function zoomToData(features, map) {
					var extend = {
						xmin: features[0].geometry.x,
						ymin: features[0].geometry.y,
						xmax: features[0].geometry.x,
						ymax: features[0].geometry.y
					};

					if (features.length > 0) {
						for (i = 0; i < features.length; i++) {
							if (features[i].geometry.x < extend.xmin) {
								extend.xmin = features[i].geometry.x
							}
							if (features[i].geometry.y < extend.ymin) {
								extend.ymin = features[i].geometry.y
							}
							if (features[i].geometry.x > extend.xmax) {
								extend.xmax = features[i].geometry.x
							}
							if (features[i].geometry.y > extend.ymax) {
								extend.ymax = features[i].geometry.y
							}
						}
						var newExtend = new Extent(extend.xmin, extend.ymin, extend.xmax, extend.ymax, map.spatialReference);

						map.setExtent(newExtend.expand(1.25), true);
					}
				}

				function buildInfoTemplate(popupInfo) {
					var json = {
						content: ""
					};

					popupInfo.fieldInfos.forEach(function (field) {
						if (field.visible) {
							json.content += "<b>" + field.label + "</b>" + ": ${" + field.fieldName + "}<br>";
						}
					});
					return json;
				}
			},
			ImportAddressRemoveAll: function () {
				this.clearResultInfo();
				var map = this.map;

				this._widgetResult.layerList.forEach(function (item) {
					map.removeLayer(item);
				});

				this._widgetResult.layerAddedTimes = 0;
				this._widgetResult.layerList = [];
			}


		});
	});