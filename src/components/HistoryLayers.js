
import React, { useRef, useEffect, useState } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import MapImageLayer from "@arcgis/core/layers/MapImageLayer";

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

const getSymbol  = (colors,setColors,ids,idField)=>{

    var tempColors= [...colors];
    var fiveUniqueValue = ids.slice(0, 5).map((id) => {
        var color;//colors
        var index=tempColors.findIndex((item)=>{return item.id===id});
        if (index!==-1) {
            color = tempColors[index].value;
        } else {
            let newIndex=tempColors.findIndex(item=>!item.id);
            if (newIndex!==-1) {
                color = tempColors[newIndex].value;
                tempColors[newIndex].id=id;
            } else {
                color = getRandomColor();
                tempColors.push({
                    id:id,
                    value:color,
                })
            }
        }
        return {
            value: "" + id.value,
            symbol: {
                type: "simple-marker", // autocasts as new SimpleMarkerSymbol()
                size: 5,
                color: color,
                outline: null
            },
        }
    });        
    setColors(tempColors);
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
    return renderer;

}
const HistoryLayers = (props) => {
    const [colors, setColors] = useState(
        [
            { value: [41, 160, 201], id: null },
            { value: [255, 87, 51], id: null },
            { value: [41, 201, 48], id: null },
            { value: [201, 196, 41], id: null },
            { value: [201, 41, 201], id: null },
        ]
    );

    const [historyLayers,setHistoryLayers]=useState([]);

    useEffect(() => {
        if(props.ids.length>0){
            var dtFrom=props.fromValue.replace("T", " ");
            var dtTo=props.toValue.replace("T", " ");
            
            //add to map
            var renderer= getSymbol(colors,setColors,props.ids, props.idField);
            var layer = new MapImageLayer({
                url: props.serviceUrl,
                id: "VehicleHistory" + (historyLayers.length + 1),
                title: "Vehicle History",
                sublayers: [{
                    id: 0,
                    visible: true,
                    title: "VehicleHistory",
                    definitionExpression: `LocationDate>= '${dtFrom}' and LocationDate<= '${dtTo}' and ${props.idField} in (${props.ids.map(id=>{return `'${id.value}'`}).join(",")}) `,
                    renderer: renderer,
                   popupTemplate: {
                        title: `<b>Vehicle:</b> {${props.idField}}`,
                        content: `<b>Date:</b> {LocationDate}`,
                    }
                }]
            });
    
           
            props.addNewHistoryLayer({
                layer:layer,
                from:props.fromValue,
                to:props.toValue,
                ids:props.ids,
            })
            //clear selectIds
            props.setSelectedIds([]);
        }
        

    }, [props.ids]);

    return null;
}

export default HistoryLayers;
