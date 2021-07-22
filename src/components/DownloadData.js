import React, { useRef, useEffect, useState } from 'react';
import XLSX from 'xlsx';


const DownloadExcel = (props) => {

    useEffect(() => {
        if(props.downloadData){
            const fields = props.downloadData[0].fields.map(f => f.name);
            let dataArray= props.downloadData.map(layer=>{
                return ([
                    fields,
                    ...layer.features.map(f=>{
                       return fields.map(field=>f.attributes[field])                         
                    })
                ]);
            })
            downloadxls(dataArray);
            props.setDownloadData(null);
        }
    }, [props.downloadData]);

    const downloadxls = (dataArray)=>{
        let wb = XLSX.utils.book_new();
        dataArray.forEach((data,i)=>{
            let ws = XLSX.utils.json_to_sheet(data);
            XLSX.utils.book_append_sheet(wb, ws, `sheet${i}`);
        })
        let buf = XLSX.write(wb, {bookType:'xlsx', type:'buffer'}); // generate a nodejs buffer
        let str = XLSX.write(wb, {bookType:'xlsx', type:'binary'}); // generate a binary string in web browser
        XLSX.writeFile(wb, `undefined.xlsx`);
    }
    return null
}

export default DownloadExcel;
