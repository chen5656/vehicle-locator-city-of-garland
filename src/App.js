import React, { useRef, useEffect,useState } from "react";
import Bookmarks from '@arcgis/core/widgets/Bookmarks';
import Expand from '@arcgis/core/widgets/Expand';
import MapView from "@arcgis/core/views/MapView";
import WebMap from "@arcgis/core/WebMap";
import esriConfig from "@arcgis/core/config";


import Search from '@arcgis/core/widgets/Search';
import Home from '@arcgis/core/widgets/Home';
import Legend from '@arcgis/core/widgets/Legend';
import LayerList from '@arcgis/core/widgets/LayerList';
import BasemapToggle from '@arcgis/core/widgets/BasemapToggle';
import Viewpoint from '@arcgis/core/Viewpoint';
import Extent from '@arcgis/core/geometry/Extent';
import Locator from '@arcgis/core/tasks/Locator';
import Query from '@arcgis/core/tasks/support/Query';

import QueryExpand from './components/QueryExpand'


import "./App.css";

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
function App() {

  const mapDiv = useRef(null);
  const [map,setMap]=useState(null);

  const [view,setView]=useState(null);
  const [historyLayerArray, setHistoryLayerArray]=useState([]);

  useEffect(() => {
    if (mapDiv.current) {
      /**
       * Initialize application
       */

      esriConfig.portalUrl = "https://cogmap4.garlandtx.gov/portal/";
      const map = new WebMap({
        portalItem: {
          id: "55039d1fa5134f298bd49be38ca00e6a"
        }
      });

      const view = new MapView({
        container: mapDiv.current,
        map: map
      });

      setView(view);
      setMap(map);


      var searchWidget = new Search({
        view: view
      });
      view.ui.add(searchWidget, {
        position: "top-left",
        index: 0
      });

      const basemapToggle = new BasemapToggle({
        view: view,
        nextBasemap: "hybrid"
      });

      view.ui.add(basemapToggle, {
        position: "top-left",
        index: 1
      });

      var legend = new Legend({
        view: view
      });
      view.ui.add(legend, "bottom-right");


      var layerList = new LayerList({
        view: view,
        // listItemCreatedFunction: layerListFunc
      });


      // layerList.on("trigger-action", function (event) {

      //   const id = event.action.id;
      //   const layer = event.item.layer
      //   const queryparas = layer._queryparas;
      //   const _mapSubLayer = map.allLayers.find(function (item) {
      //     return item.id === layer.id;
      //   });

      //   if (id === "showIds") {
      //     view.popup.open({
      //       // Set the popup"s title to the coordinates of the location
      //       title: "",
      //       location: view.center, // Set the location of the popup to the clicked location
      //       content: `From ${queryparas.from} to ${queryparas.to} - <br><br>
      //           <b>Login Name List: </b>${queryparas.ids.join(", ")}`,
      //       actions: []
      //     });

      //   } else if (id === "deleteLayer") {
      //     map.remove(_mapSubLayer);
      //     historyLayers = historyLayers.filter(x => x != layer)
      //   } else if (id === "downloadData") {
      //     var idList = queryparas.ids.map(id => `'${id}'`).join(",");
      //     var query = new Query({
      //       where: `LocationDate>= '${queryparas.from}' and LocationDate<= '${queryparas.to}' and ${idField} in (${idList}) `,
      //       outFields: ["*"],
      //       returnGeometry: true,
      //       orderByFields: "Id",
      //     });
      //     queryAvlTask.execute(query).then(function (result) {
      //       const fields = result.fields.map(f => f.name);
      //       exportData(fields, result.features);

      //     })

      //   }
      // });
      view.ui.add(layerList, "bottom-left");




    }
  }, []);

  const addNewHistoryLayer = (layer) => {
    var newArray = [...historyLayerArray];
    newArray.push(layer);
    setHistoryLayerArray(newArray);
    map.add(layer.layer);
  }

  return (
    <>
      <div className="mapDiv" ref={mapDiv}></div>
      {view&&<QueryExpand addNewHistoryLayer={addNewHistoryLayer}/>}
    </>);
}

export default App;
