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
import QueryExpand from './components/QueryExpand';
import DownloadExcel from './components/DownloadData';


import "./App.css";


function App() {

  const mapDiv = useRef(null);
  const [map,setMap]=useState(null);
  const [view,setView]=useState(null);
  const [downloadData,setDownloadData]=useState(null);

  const Avl_History = "https://cogmap4.garlandtx.gov/server/rest/services/dept_Water/VehicleLocator_History/MapServer";    
  const idField = "LoginName";  
  var queryAvlTask = new QueryTask({
    url: `https://cogmap4.garlandtx.gov/server/rest/services/dept_Water/VehicleLocator_History/MapServer/0`
  });

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
        var layer = event.item.layer;
        if (id === "deleteLayer") {
          // map.remove(subLayer);
          //what happened if current history layer is removing?
          }else if (id === "downloadData") {
           var allPromise= layer.allSublayers.items.map(sublayer=>{
              let paras=sublayer._userInput //from,ids, to,
              var where=`LocationDate>= '${paras.from.replace("T", " ")}' and LocationDate<= '${paras.to.replace("T", " ")}' and ${idField} in (${paras.ids.map(id=>`'${id}'`).join(",")}) `;
              console.log(where)
              return queryAvlHistoryFromServer(where, false);                
            })   ;
            Promise.all(allPromise).then((featureSetArray) => {
              setDownloadData(featureSetArray);
            });
        }


      });

      view.ui.add(layerList, "bottom-left");
    }
  }, []);

  const queryAvlHistoryFromServer=(whereClause, idOnly)=> {
    // var where=`LocationDate>= '${paras.from}' and LocationDate<= '${paras.to}' and ${idField} in (${paras.ids.join(",")}) `;
    if (idOnly) {
      var query = new Query({
        where: whereClause,
        outFields: [idField],
        returnDistinctValues: true,
        returnGeometry: false,
        orderByFields: idField,
      });
    } else {
      var query = new Query({
        where: whereClause,
        outFields: ["*"],
        returnGeometry: true,
        orderByFields: "Id",
      });
    }
    return queryAvlTask.execute(query);     
  }
  
  const layerListFunc=(event)=> {
    var item = event.item;
    if (item.title .search(/From:.+To:/)>-1) {
      item.open = true;
      item.actionsSections = [
          [{
          title: "Download data (up to 1000 records per layer)",
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

  
  const exportData=(fields, features)=> {
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

  return (
    <>
      <div className="mapDiv" ref={mapDiv}></div>
      {view&&<QueryExpand map={map} queryAvlHistoryFromServer={queryAvlHistoryFromServer} Avl_History={Avl_History} idField={idField}/>}
      <DownloadExcel downloadData={downloadData} setDownloadData={setDownloadData}/>
    </>);
}

export default App;
