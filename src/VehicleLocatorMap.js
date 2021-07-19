import React, {
    useRef,
    useEffect,
    useState
  } from "react";
  import MapView from "@arcgis/core/views/MapView";
  import Map from "@arcgis/core/Map";
  
  
  import Search from '@arcgis/core/widgets/Search';
  import Home from '@arcgis/core/widgets/Home';
  import BasemapToggle from '@arcgis/core/widgets/BasemapToggle';
  import Viewpoint from '@arcgis/core/Viewpoint';
  import Extent from '@arcgis/core/geometry/Extent';
  import Locator from '@arcgis/core/tasks/Locator';
  
//   import "./App.css"; 
  
  // import GetData from "./service/airtable/GetData";
  
  // import ProjectsLayer from "./service/airtable/ProjectsLayer";
  // import NewTodoDiv from "./components/NewTodoDiv/NewTodoDiv";  
  // import EditorDiv from "./components/EditDiv/EditorDiv"
  
  function VehicleLocatorMap() {
  
    const mapDiv = useRef(null);
    const [map,setMap]=useState(null);
    const [view,setView]=useState(null);
  
    const [homeWidget,setHomeWidget]=useState(null);
  
    const [allProjectsData, setProjectData]=useState(null);
    const [noteData, setNoteData]=useState(null);
    const [houseData, setHouseData]=useState(null);
    const [fullExtent, setFullExtent]=useState(null);
    const [searchResult, setSearchResult]=useState(null);
  
    const [selectedFeature, setSelectedFeature]=useState(null);
    const [searchWidget,setSearchWidget]=useState(null);
  
    useEffect(() => {
      if (mapDiv.current) {
        
        const map = new Map({
          basemap: "gray"
        });
      
        const view = new MapView({
          container: mapDiv.current,
          map: map,
          center: [-96.78, 33.0],
          zoom: 12,
        });
        setMap(map);
        setView(view);
        window.esriView=view;
  
        var search= new Search({
            view: view
        });
              

  
        const basemapToggle = new BasemapToggle({
          view: view,
          nextBasemap: "streets-vector"
        });
  
        view.ui.add(search, {
          position: "top-left",
          index: 0
        });
  
        view.ui.add(basemapToggle, {
          position: "bottom-left"
        });
  
    

      }
    }, []);

  
    return (
      <>  
  
        <div className="mapDiv" ref={mapDiv}>
        
        </div>
      </>) ;
  }
  export default VehicleLocatorMap;
  