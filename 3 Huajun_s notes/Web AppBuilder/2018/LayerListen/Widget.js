///////////////////////////////////////////////////////////////////////////
// Copyright © 2014 Esri. All Rights Reserved.
//
// Licensed under the Apache License Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
///////////////////////////////////////////////////////////////////////////

define([
    'jimu/BaseWidget',
    'dojo/_base/declare',
    'dojo/_base/lang',
    'dojo/_base/array',
    'dojo/dom-construct',
    'dojo/dom',
    'dojo/on',
    'dojo/topic',
    './LayerListView',
    './PopupMenu',
    './NlsStrings',
    'jimu/LayerInfos/LayerInfos'
],
    function (BaseWidget, declare, lang, array, domConstruct, dom, on, topic,
        LayerListView, PopupMenu, NlsStrings, LayerInfos) {
        var clazz = declare([BaseWidget], {
            //these two properties is defined in the BaseWiget
            baseClass: 'jimu-widget-layerList',
            name: 'layerList',

            //layerListView: Object{}
            //  A module is responsible for show layers list
            layerListView: null,

            //operLayerInfos: Object{}
            //  operational layer infos
            operLayerInfos: null,

            startup: function () {
                console.log("LayerListen :: startup");
                this.inherited(arguments);
                NlsStrings.value = this.nls;
                // summary:
                //    this function will be called when widget is started.
                // description:
                //    according to webmap or basemap to create LayerInfos instance
                //    and initialize operLayerInfos;
                //    show layers list;
                //    bind events for layerLis;

                if (this.map.itemId) {
                    LayerInfos.getInstance(this.map, this.map.itemInfo)
                        .then(lang.hitch(this, function (operLayerInfos) {
                            this.operLayerInfos = operLayerInfos;
                            this.updateLayerVisibilityFromMap();
                            this.showLayers();
                            this.bindEvents();
                            dom.setSelectable(this.layersSection, false);
                        }));
                } else {
                    var itemInfo = this._obtainMapLayers();
                    LayerInfos.getInstance(this.map, itemInfo)
                        .then(lang.hitch(this, function (operLayerInfos) {
                            this.operLayerInfos = operLayerInfos;
                            this.updateLayerVisibilityFromMap();
                            this.showLayers();
                            this.bindEvents();
                            dom.setSelectable(this.layersSection, false);
                        }));
                }

                var me = this;
                // listen for the layersChanged event
                topic.subscribe("layersChanged", function () {
                    console.log("LayerListen :: layersChanged");
                    me.onLayersChanged();
                });
            },

            destroy: function () {
                this._clearLayers();
                this.inherited(arguments);
            },

            /**
             * when map layers are changed, force refresh of LayerListView
             */
            onLayersChanged: function () {
                this.updateLayerVisibilityFromMap();
                this._refresh();
            },

            /**
             * set the visible layers in the operational layers based on the current map
             * when loaded from webmap, it only shows the visibility as set in the initial web map
             * and does not reflect any changes made in visibility outside the layer list widget
             */
            updateLayerVisibilityFromMap: function () {
                // for each operational layer, set the visible layers from map
                array.forEach(this.operLayerInfos._operLayers, function (layerInfo) {
                    var layerOnMap = this.map.getLayer(layerInfo.id);
                    if (layerOnMap.visibleLayers) {
                        layerInfo.visibleLayers = layerOnMap.visibleLayers;
                        console.log("LayerListen :: visible layers set to ", layerInfo.visibleLayers, " for layer id = ", layerInfo.id);
                    }
                }, this);

                // the _finalLayerInfos object is used by LayerListView
                array.forEach(this.operLayerInfos._finalLayerInfos, function (layerInfo) {
                    var layerOnMap = this.map.getLayer(layerInfo.id);
                    if (!layerOnMap.visibleLayers) {
                        // skip if layer has no sublayers
                        return;
                    };

                    // need to set visibility on the sublayer objects which ordered by index
                    var idx;
                    for (idx = 0; idx < layerInfo.newSubLayers.length; idx += 1) {
                        var isVisibleOnMap = (array.indexOf(layerOnMap.visibleLayers, idx) > -1);
                        layerInfo.newSubLayers[idx]._visible = isVisibleOnMap;
                        console.log("LayerListen :: sublayer ", layerInfo.newSubLayers[idx].id, " is visible = ", isVisibleOnMap);
                    }

                }, this);

            },

            _obtainMapLayers: function () {
                // summary:
                //    obtain basemap layers and operational layers if the map is not webmap.
                var basemapLayers = [],
                    operLayers = [];
                // emulate a webmapItemInfo.
                var retObj = {
                    itemData: {
                        baseMap: {
                            baseMapLayers: []
                        },
                        operationalLayers: []
                    }
                };
                // array.forEach(this.map.layerIds.concat(this.map.graphicsLayerIds), function(layerId) {
                //   var layer = this.map.getLayer(layerId);
                //   if (layer.isOperationalLayer) {
                //     operLayers.push({
                //       layerObject: layer,
                //       title: layer.label || layer.title || layer.name || layer.id || " ",
                //       id: layer.id || " "
                //     });
                //   } else {
                //     basemapLayers.push({
                //       layerObject: layer,
                //       id: layer.id || " "
                //     });
                //   }
                // }, this);

                array.forEach(this.map.graphicsLayerIds, function (layerId) {
                    var layer = this.map.getLayer(layerId);
                    if (layer.isOperationalLayer) {
                        operLayers.push({
                            layerObject: layer,
                            title: layer.label || layer.title || layer.name || layer.id || " ",
                            id: layer.id || " "
                        });
                    }
                }, this);
                array.forEach(this.map.layerIds, function (layerId) {
                    var layer = this.map.getLayer(layerId);
                    if (layer.isOperationalLayer) {
                        operLayers.push({
                            layerObject: layer,
                            title: layer.label || layer.title || layer.name || layer.id || " ",
                            id: layer.id || " "
                        });
                    } else {
                        basemapLayers.push({
                            layerObject: layer,
                            id: layer.id || " "
                        });
                    }
                }, this);

                retObj.itemData.baseMap.baseMapLayers = basemapLayers;
                retObj.itemData.operationalLayers = operLayers;
                return retObj;
            },



            _layerFilter: function (layerId, basemapLayers, operLayers) {
                var layer = this.map.getLayer(layerId);
                if (layer.isOperationalLayer) {
                    operLayers.push({
                        layerObject: layer,
                        title: layer.label || layer.title || layer.name || layer.id || " ",
                        id: layer.id || " "
                    });
                } else {
                    basemapLayers.push({
                        layerObject: layer,
                        id: layer.id || " "
                    });
                }
            },

            showLayers: function () {
                // summary:
                //    create a LayerListView module used to draw layers list in browser.
                this.layerListView = new LayerListView({
                    operLayerInfos: this.operLayerInfos,
                    layerListWidget: this,
                    config: this.config
                }).placeAt(this.layerListBody);
            },

            _createPopupMenu: function () {
                // summary:
                //    popup menu is a dijit used to do some operations of layer
                this.popupMenu = new PopupMenu({
                    layerListWidget: this
                });
                domConstruct.place(this.popupMenu.domNode, this.domNode);
            },

            _clearLayers: function () {
                // summary:
                //   clear layer list
                //domConstruct.empty(this.layerListTable);
                if (this.layerListView && this.layerListView.destroyRecursive) {
                    this.layerListView.destroyRecursive();
                }
            },

            flag: true,


            _refresh: function () {
                this._clearLayers();
                this.showLayers();
            },

            bindEvents: function () {
                // summary:
                //    bind events are listened by this module
                this.own(on(this.operLayerInfos,
                    'layerInfosChanged',
                    lang.hitch(this, this._onLayerInfosChanged)));

                this.own(on(this.operLayerInfos,
                    'tableInfosChanged',
                    lang.hitch(this, this._onLayerInfosChanged)));

                this.own(on(this.operLayerInfos,
                    'updated',
                    lang.hitch(this, this._onLayerInfosObjUpdated)));
            },

            _onLayerInfosChanged: function ( /*layerInfo, changedType*/ ) {
                this._refresh();
            },

            _onLayerInfosObjUpdated: function () {
                this._refresh();
            },

            onAppConfigChanged: function (appConfig, reason, changedData) {
                /*jshint unused: false*/
                this.appConfig = appConfig;
            }
        });
        //clazz.hasConfig = false;
        return clazz;
    });