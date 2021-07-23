require([

    "esri/config",
    "esri/WebMap",
    "esri/views/MapView",

    "esri/widgets/BasemapToggle",
    "esri/widgets/Legend",
    "esri/widgets/LayerList",
    "esri/widgets/Search",

    "esri/layers/MapImageLayer",

    "esri/tasks/support/Query",
    "esri/tasks/QueryTask",

    "dojox/widget/ColorPicker",


    "dojo/dom",
    "dojo/dom-class",
    "dojo/dom-attr",
    "dojo/dom-construct",
    "dojo/query",

    "dojo/domReady!"
], function (
    esriConfig,
    WebMap, MapView,
    BasemapToggle, Legend, LayerList, Search,
    MapImageLayer,
    Query, QueryTask,

    ColorPicker,

    dom, domClass, domAttr, domConstruct, domQuery,


) {

    "use strict";
    const Avl_History = "https://cogmap4.garlandtx.gov/server/rest/services/dept_Water/VehicleLocator_History/MapServer",
        idField = "LoginName",
        queryAvlTask = new QueryTask({
            url: `${Avl_History}/0`
        });
    const DateTimeFrom = dom.byId("dateTimeFrom"),
        DateTimeTo = dom.byId("dateTimeTo"),
        inputForm = dom.byId("historyQueryTool"),
        nextStepBtn = dom.byId("nextStepBtn"),
        multiselectNode = dom.byId("multiselectNode");
    var checkboxLength = 0,
        selectIds = [],
        historyLayers = [],
        fiveColors = [
            [41, 160, 201],
            [255, 87, 51],
            [41, 201, 48],
            [201, 196, 41],
            [201, 41, 201],
        ],
        usedColors = {};
    var map;

    initMap();
    initTool();


    function initMap() {
        esriConfig.portalUrl = "https://cogmap4.garlandtx.gov/portal/"
        var webmap = new WebMap({
            portalItem: {
                id: "55039d1fa5134f298bd49be38ca00e6a"
            }
        });

        /************************************************************
         * Set the WebMap instance to the map property in a MapView.
         ************************************************************/
        var view = new MapView({
            map: webmap,
            container: "viewDiv",
            zoom: 12,
            center: [-96.636269, 32.91676]
        });
        view.when(function () {
            var searchWidget = new Search({
                view: view
            });
            view.ui.add(searchWidget, {
                position: "top-left",
                index: 0
            });

            var toggle = new BasemapToggle({
                view: view, // The view that provides access to the map"s "streets-vector" basemap
                nextBasemap: "hybrid" // Allows for toggling to the "hybrid" basemap
            });
            view.ui.add(toggle, {
                position: "top-left",
                index: 1
            });

            var legend = new Legend({
                view: view
            });
            view.ui.add(legend, "bottom-right");



            var layerList = new LayerList({
                view: view,
                listItemCreatedFunction: layerListFunc
            });


            layerList.on("trigger-action", function (event) {

                const id = event.action.id;
                const layer = event.item.layer
                const queryparas = layer._queryparas;
                const _mapSubLayer = map.allLayers.find(function (item) {
                    return item.id === layer.id;
                });

                if (id === "showIds") {
                    view.popup.open({
                        // Set the popup"s title to the coordinates of the location
                        title: "",
                        location: view.center, // Set the location of the popup to the clicked location
                        content: `From ${queryparas.from} to ${queryparas.to} - <br><br>
                        <b>Login Name List: </b>${queryparas.ids.join(", ")}`,
                        actions: []
                    });

                } else if (id === "deleteLayer") {
                    map.remove(_mapSubLayer);
                    historyLayers = historyLayers.filter(x => x != layer)
                } else if (id === "downloadData") {
                    var idList=queryparas.ids.map(id=> `'${id}'`).join(",");
                    var query = new Query({
                        where: `LocationDate>= '${queryparas.from}' and LocationDate<= '${queryparas.to}' and ${idField} in (${idList}) `,
                        outFields: ["*"],
                        returnGeometry: true,
                        orderByFields:"Id",
                    });
                    queryAvlTask.execute(query).then(function (result) {
                        const fields = result.fields.map(f => f.name);
                        exportData(fields, result.features);

                    })

                }
            });
            view.ui.add(layerList, "bottom-left");
        });

        map = view.map;

        function layerListFunc(event) {
            // The event object contains an item property.
            // is is a ListItem referencing the associated layer
            // and other properties. You can control the visibility of the
            // item, its title, and actions using this object.

            var item = event.item;

            if (item.title === "Vehicle History") {
                // An array of objects defining actions to place in the LayerList.
                // By making this array two-dimensional, you can separate similar
                // actions into separate groups with a breaking line.
                item.open = true;
                var queryparas = item.layer._queryparas;
                // set an action for zooming to the full extent of the layer
                item.actionsSections = [
                    [{
                            title: "From:" + queryparas.from,
                            className: "esri-icon-expand",
                            id: "showIds"
                        }, {
                            title: "To:" + queryparas.to,
                            className: "esri-icon-expand",
                            id: "showIds"
                        },
                        {
                            title: "" + queryparas.ids.slice(0, 5).join(",").concat(queryparas.ids.length > 5 ? "...(click to see the full list)" : ""),
                            className: "esri-icon-description",
                            id: "showIds"
                        }
                    ],
                    [{
                        title: "Download data (up to 1000 records)",
                        className: "esri-icon-download",
                        id: "downloadData"
                    }],
                    [{
                        title: "Delete",
                        className: "esri-icon-close",
                        id: "deleteLayer"
                    }]
                ];

            }


        }


    }

    function initTool() {

        toolRest();

        dom.byId("cmdShowTool").onclick = function (e) {
            domClass.toggle("AVLHistoryQueryTool", "display-none");
        };
        dom.byId("btnStartOver").onclick = startOver;

        DateTimeFrom.max = "" + new Date().toISOString().split("T")[0] + "T23:59:59";
        DateTimeTo.max = "" + new Date().toISOString().split("T")[0] + "T23:59:59";

        domAttr.set(DateTimeTo, "disabled", true);
        DateTimeFrom.addEventListener("input", function (e) {
            domAttr.set(DateTimeTo, "disabled", false);
            DateTimeTo.min = DateTimeFrom.value;
        });


        inputForm.addEventListener("submit", function (e) {

            // prevent the form from submitting
            e.preventDefault();

            //select Id, Vehicle, LoginName, CrewId, CrewNumber, DeptId, Speed, Heading, LocationDate, Location       
            //-- indentify filed: Vehicle and LocationDate 


            dom.byId("historyQueryTool").style.cursor = "wait";
            var dtFrom=DateTimeFrom.value.replace("T", " "),
                dtTo=DateTimeTo.value.replace("T", " ");

            if (nextStepBtn.value == "Next") {
                domAttr.set("historyQueryTool", "disabled", true);
                var query = new Query({
                    where: `LocationDate>= '${dtFrom}' and LocationDate<= '${dtTo}'`,
                    outFields: [idField],
                    returnDistinctValues: true,
                    returnGeometry: false,
                    orderByFields: idField,
                });
                queryAvlTask.execute(query)
                    .then(function (response) {
                        if (response.features.length > 0) {
                            checkboxLength = response.features.length;
                            var ids = response.features.map(feature => feature.attributes[idField]);
                            displayVehicleIDs(ids);
                            domAttr.set("historyQueryTool", "disabled", true);
                            dom.byId("historyQueryTool").style.cursor = "inherit";
                            domAttr.set(DateTimeTo, "disabled", true);
                            domAttr.set(DateTimeFrom, "disabled", true);
                            nextStepBtn.value = "Add to Map"

                        } else {
                            alert("no data returned. please check")
                            dom.byId("historyQueryTool").style.cursor = "inherit";

                        }
                    });; //query and get vehicle id list

            } else if (nextStepBtn.value == "Add to Map") {

                displayHistoryWithSelectedIds(Avl_History, idField, dtFrom, dtTo, selectIds);

            }


        });

    }

    function startOver() {
        toolRest();
    }

    function exportData(fields, features) {
        var firstLine = fields.concat(["x", "y"]).join(",").replace("LocationDate", "Date, Time") + "\r\n";
        var data = features.map(item => {
            var row = [];
            fields.forEach(field => {
                if (field == "LocationDate") {
                    row.push(new Date(item.attributes[field]).toLocaleString());
                } else {
                    row.push(item.attributes[field]);
                }
            });
            row = row.concat([item.geometry.x, item.geometry.y]);

            return row.join(",")
        }).join("\r\n");

        var blob = new Blob([firstLine + data], {
            type: "text/csv"
        });

        // Determine which approach to take for the download
        if (navigator.msSaveOrOpenBlob) {
            // Works for Internet Explorer and Microsoft Edge
            navigator.msSaveOrOpenBlob(blob, "VehicleLocatorHistory" + ".csv");
        } else {
            _downloadAnchor(URL.createObjectURL(blob), "csv");
        }

        function _downloadAnchor(content, ext) {
            var anchor = document.createElement("a");
            anchor.style = "display:none !important";
            anchor.id = "downloadanchor";
            document.body.appendChild(anchor);

            // If the [download] attribute is supported, try to use it

            if ("download" in anchor) {
                anchor.download = "VehicleLocatorHistory" + "." + "csv";
            }
            anchor.href = content;
            anchor.click();
            anchor.remove();
        }


    }

    function displayVehicleIDs(ids) {
        domClass.remove(multiselectNode, "display-none");
        domConstruct.empty(multiselectNode);

        domConstruct.create("div", {
            innerHTML: `<input type="checkbox" id="ids_all"><label for="ids_all" style="width: 80px;">select all</label>`,
            class: "col-12"
        }, multiselectNode);

        // this.colorPicker = new ColorPicker({}, this.colorPickerNode);

        ids.forEach(id => {
            let idDiv=domConstruct.create("div", {
                innerHTML: `<input type="checkbox" id="ids_${id}" value="${id}">
                            <label for="ids_${id}" style="width: 80px;">${id}</label>`,
                class: "col"
            }, multiselectNode);
            
            dom.byId(`ids_${id}`).onclick = handle_id_checkbox;

        });

        dom.byId(`ids_all`).onclick = check_all;

        function check_all(e) {
            selectIds = [];
            if (e.target.checked) {
                domQuery("input", multiselectNode).forEach(checkbox => {
                    checkbox.checked = true;
                    if (checkbox.id != "ids_all") {
                        selectIds.push(checkbox.value);
                    }
                })
            } else {
                domQuery("input", multiselectNode).forEach(checkbox => {
                    checkbox.checked = false;
                })
            }
        }

        function handle_id_checkbox(e) {
            if (e.target.checked) {
                selectIds.push(e.target.value);
                if (selectIds.length == checkboxLength) {
                    dom.byId(`ids_all`).checked = true
                }
            } else {
                selectIds = selectIds.filter(id => (id != e.target.value));
                if (selectIds.length == checkboxLength - 1) {
                    dom.byId(`ids_all`).checked = false
                }
            }

        }
    }

    function displayHistoryWithSelectedIds(serviceUrl, idField, from, to, ids) {
        // getRandomColor(),array shift

        var fiveUniqueValue = ids.slice(0, 5).map((id) => {
            var color;
            if (usedColors[id]) {
                color = usedColors[id];
            } else {
                if (fiveColors.length) {
                    color = fiveColors.shift();
                } else {
                    color = getRandomColor();
                }
                usedColors[id] = color;
            }
            return {
                value: "" + id,
                symbol: {
                    type: "simple-marker", // autocasts as new SimpleMarkerSymbol()
                    size: 5,
                    color: color,
                    outline: null
                },
            }
        });

        const defaultSym = {
            type: "simple-marker", // autocasts as new SimpleMarkerSymbol()
            size: 5,
            color: [51, 50, 51, 0.667],
            outline: null
        };

        var renderer = {
            type: "unique-value", // autocasts as new ClassBreaksRenderer()
            field: idField,
            defaultSymbol: (ids.length < 6) ? null : defaultSym,
            uniqueValueInfos: fiveUniqueValue,
        };



        var layer = new MapImageLayer({
            url: serviceUrl,
            id: "VehicleHistory" + (historyLayers.length + 1),
            title: "Vehicle History",
            sublayers: [{
                id: 0,
                visible: true,
                title: "VehicleHistory",
                definitionExpression: `LocationDate>= '${from}' and LocationDate<= '${to}' and ${idField} in (${ids.map(id=>{return `'${id}'`}).join(",")}) `,
                renderer: renderer,
                labelingInfo: [{
                    labelExpression: "[LocationDate]",
                    labelPlacement: "always-horizontal",
                    symbol: {
                      type: "text",  // autocasts as new TextSymbol()
                      color: [255, 255, 255, 0.7],
                      haloColor: [0, 0, 0, 0.85],
                      haloSize: 1,
                      font: {
                        size: 11
                      }
                    },
                    minScale: 2400000,
                    maxScale: 73000
                  }],
                popupTemplate: {
                    title: `<b>Vehicle:</b> {${idField}}`,
                    content: `<b>Date:</b> {LocationDate}`,
                }
            }]
        });

        layer._queryparas = {
            from: from,
            to: to,
            ids: ids
        }
        historyLayers.push(layer);
        map.add(layer);

        layer.when(function (event) {
            // The LayerView for the layer that emitted this event
            console.log("when")
            dom.byId("historyQueryTool").style.cursor = "inherit";
        });
    }

    function getRandomColor() {
        // var letters = "0123456789ABCDEF";
        // var color = "#";
        // for (var i = 0; i < 6; i++) {
        //   color += letters[Math.floor(Math.random() * 16)];
        // }
        return [randomNumber(), randomNumber(), randomNumber()];

        function randomNumber() {
            const max = 255;
            const min = 0;
            var n = Math.random() * (max - min) + min;
            return Math.floor(n)
        }
    }

    function toolRest() {
        domAttr.set(DateTimeFrom, "disabled", false);
        inputForm.reset();
        DateTimeTo.min = "";
        domConstruct.empty(multiselectNode);
        domClass.add(multiselectNode, "display-none");

        nextStepBtn.value = "Next";

        selectIds = [];
        checkboxLength = 0;

    }
});