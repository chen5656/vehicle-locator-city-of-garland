import React, { useRef, useEffect,useState } from "react";
import MapView from "@arcgis/core/views/MapView";
import WebMap from "@arcgis/core/WebMap";
import esriConfig from "@arcgis/core/config";


import Search from '@arcgis/core/widgets/Search';
import Legend from '@arcgis/core/widgets/Legend';
import LayerList from '@arcgis/core/widgets/LayerList';
import BasemapToggle from '@arcgis/core/widgets/BasemapToggle';


import Query from '@arcgis/core/tasks/support/Query';
import QueryTask from '@arcgis/core/tasks/QueryTask';
import QueryExpand from './components/QueryExpand'


import "./App.css";

function layerListFunc(event) {
  var item = event.item;
  if (item.title .search(/From:.+To:/)>-1) {
    item.open = true;
    item.actionsSections = [
        [{
        title: "Download data (up to 1000 records)",
        className: "esri-icon-download",
        id: "downloadData"
      },
      // {
      //   title: "Delete",
      //   className: "esri-icon-close",
      //   id: "deleteLayer"
      // }
    ]
    ];

  }


}
function App() {

  const mapDiv = useRef(null);
  const [map,setMap]=useState(null);

  const [view,setView]=useState(null);


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
        listItemCreatedFunction: layerListFunc
      });
      
      layerList.on("trigger-action", function (event) {       

        var id = event.action.id;
        var layer = event.item.layer
        var subLayer = map.allLayers.find(function (item) {
            return item.id === layer.id;
        });
        debugger
        if (id === "deleteLayer") {
          // map.remove(subLayer);
          //what happened if current history layer is removing?
          }else if (id === "downloadData") {
           var allPromise= layer.allSublayers.items.map(sublayer=>{
              let paras=sublayer._userInput //from,ids, to,
              var where=`LocationDate>= '${paras.from}' and LocationDate<= '${paras.to}' and LoginName in (${paras.ids.join(",")}) `;
        
                var query = new Query({
                    where: where,
                    outFields: ["*"],
                    returnGeometry: true,
                    orderByFields:"Id",
                });
                var queryAvlTask = new QueryTask({
                  url: `https://cogmap4.garlandtx.gov/server/rest/services/dept_Water/VehicleLocator_History/MapServer/0`
              });
                return queryAvlTask.execute(query);
             
            })   
            Promise.all(allPromise).then((values) => {
              console.log(values);
            });
            debugger
            // var idList=queryparas.ids.map(id=> `'${id}'`).join(",");
            // var query = new Query({
            //     where: `LocationDate>= '${queryparas.from}' and LocationDate<= '${queryparas.to}' and ${idField} in (${idList}) `,
            //     outFields: ["*"],
            //     returnGeometry: true,
            //     orderByFields:"Id",
            // });
            // queryAvlTask.execute(query).then(function (result) {
            //     const fields = result.fields.map(f => f.name);
            //     exportData(fields, result.features);

            // })

        }


      });

      view.ui.add(layerList, "bottom-left");
    }
  }, []);

 

  return (
    <>
      <div className="mapDiv" ref={mapDiv}></div>
      {view&&<QueryExpand map={map} />}
    </>);
}

export default App;
