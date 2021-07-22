import React, { useRef, useEffect, useState } from 'react';
import XLSX from 'xlsx';


const DownloadExcel = (props) => {

    useEffect(() => {
        if(props.downloadData){
            var header =  props.downloadData[0].fields.map(f => f.name)
                .filter(item=>item!=='LocationDate')
                .concat(['dateTime', 'latitude', 'longitude']);           
            let dataArray = props.downloadData.map(layer => {
                return (
                    layer.features.map(f=>{
                        let newF={...f.attributes};
                        newF.latitude=f.geometry.x
                        newF.longitude=f.geometry.y
                        newF.dateTime =new Date(f.attributes['LocationDate']).toLocaleString().replace(',', ' ');
                        delete newF.LocationDate;
                        delete newF.ESRI_OID;
                        return newF;
                    })
                )
            })
            downloadxls(dataArray,header);
            props.setDownloadData(null);
        }
    }, [props.downloadData]);

    const downloadxls = (dataArray,header)=>{
        let wb = XLSX.utils.book_new();
        dataArray.forEach((data,i)=>{
            let ws = XLSX.utils.json_to_sheet(data, {header: header});
            XLSX.utils.book_append_sheet(wb, ws, `sheet${i}`);
        })
        // let buf = XLSX.write(wb, {bookType:'xlsx', type:'buffer'}); // generate a nodejs buffer
        // let str = XLSX.write(wb, {bookType:'xlsx', type:'binary'}); // generate a binary string in web browser
        XLSX.writeFile(wb, `undefined.xlsx`);
    }
    return null
}

export default DownloadExcel;
