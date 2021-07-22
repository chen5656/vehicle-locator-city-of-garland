
import React, { useRef, useEffect, useState } from 'react';
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

const getLabelClass=(labelExpression)=>{
    const labelClass = {  // autocasts as new LabelClass()
        symbol: {
          type: "text",  // autocasts as new TextSymbol()
          color: "navy",
          font: {  // autocast as new Font()
             family: "Ubuntu Mono",
             size: 10,
           }
        },
        labelPlacement: "above-right",
        labelExpressionInfo: {
          expression: labelExpression
        },
        maxScale: 0,
        minScale: 25000000,
      };
      return labelClass
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

    useEffect(() => {
        if(props.selectedIds.length>0){

            var dtFrom=props.fromValue.replace("T", " ");
            var dtTo=props.toValue.replace("T", " ");
            
            //add to map
            var where=`LocationDate>= '${dtFrom}' and LocationDate<= '${dtTo}' and ${props.idField} in (${props.selectedIds.map(id=>{return `'${id.value}'`}).join(",")}) `;
        
            var renderer= getSymbol(colors,setColors,props.selectedIds, props.idField);
            var sublayer={
                id: 0,
                visible: true,
                title: props.selectedIds.length<=2?props.selectedIds.map(id=>{return id.value}).join(","):`${props.selectedIds.length} vehicles`,
                definitionExpression: where,
                renderer: renderer,
                popupTemplate: {
                    title: `<b>Vehicle:</b> {${props.idField}}`,
                    content: `<b>Date:</b> {LocationDate}`,
                },       
                _userInput:{
                    from:props.fromValue,
                    to:props.toValue,
                    ids:props.selectedIds,
                }       
            };        
            if(props.addLabelValue){
                sublayer.labelingInfo=getLabelClass("$feature.LocationDate");
            }
            props.addNewHistoryLayer(sublayer);
        
            //clear selectIds
            props.resetSelectedIds();
        }
        

    }, [props.selectedIds]);

    return null;
}

export default HistoryLayers;
