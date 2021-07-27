import React, { useState,useRef } from 'react';
import { makeStyles } from '@material-ui/core/styles';

import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import FormGroup from '@material-ui/core/FormGroup';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import Checkbox from '@material-ui/core/Checkbox';

import MapImageLayer from "@arcgis/core/layers/MapImageLayer";

import HistoryLayers from './HistoryLayers';

import './QueryExpand.css';

const useStyles = makeStyles((theme) => ({
    hidden:{
        display:'none'
    },
    button: {
        fontSize: '12px',
        width: '100%',
        height: '50px',
    },
    expand: {
        transform: 'scale(2.5,1) rotate(90deg) '
    },
    margin: {
        marginLeft: '15px'
    },
    label:{
        marginLeft: '10px',
        width: '50px'

    },
    textField: {
        margin: theme.spacing(1),
        width: '90%',
    },
    nextButton:{
        margin: theme.spacing(1),
        float: 'right',
    },
    cancelButton:{
        margin: theme.spacing(1),
        
    },
    backdrop: {
      zIndex: theme.zIndex.drawer + 1,
      color: '#fff',
    },
    ids:{
        border: ' 1px #aaa solid',
        overflow: 'auto',
        height: ' 450px',
        padding: '15px',
        margin: '5px',
    },
    id:{
        minWidth:'120px'
    }
}));

const formatLayerTitle=(from,to)=>{    
    const optionsFrom = { year: '2-digit', month: '2-digit', day: '2-digit',
    hour: '2-digit', minute: '2-digit' };
    const optionsTo = {  month: '2-digit', day: '2-digit',
    hour: '2-digit', minute: '2-digit' };
    let newFrom=new Intl.DateTimeFormat('en-US', optionsFrom).format(new Date(from));
    let newTo=new Intl.DateTimeFormat('en-US', optionsTo).format(new Date(to));
    return `From: ${newFrom}; To: ${newTo}`;        
}

const DateInput = (props) => {
    const classes = useStyles();
    const inputFrom= useRef(null);
    const inputTo= useRef(null);

    const handleOnClick=(e)=>{

        var dtFrom=inputFrom.current.value.replace("T", " ");
        var dtTo=inputTo.current.value.replace("T", " ");
        debugger    
        props.submitDateRange(dtFrom,dtTo);
    }
    
    return (
        <form autoComplete="off" >
                <TextField            
                   ref={inputFrom}
                    size="small"
                    label="From"
                    type="datetime-local"
                    variant="outlined"
                    disabled ={!props.enableInput}
                    inputProps={{
                      max:new Date().toISOString().split("T")[0] + "T23:59:59", 
                      value:props.fromValue,

                    }}
                    className={classes.textField} 
                    InputLabelProps={{
                        shrink: true,
                    }}
                    
                />
                <TextField               
                    ref={inputTo}
                    size="small"
                    label="To"
                    type="datetime-local"
                    variant="outlined"
                    disabled={!(props.enableInput&&props.fromValue)}
                    
                    inputProps={{
                        max: new Date().toISOString().split("T")[0] + "T23:59:59", 
                        min:props.fromValue,
                        value:props.toValue,
                      }}
                    className={classes.textField} 
                    InputLabelProps={{
                        shrink: true,
                    }}
                    
                />
                <Button variant="contained" color="primary" className={props.enableInput?classes.nextButton:classes.hidden} 
                 disabled={!(props.fromValue&&props.toValue&&props.fromValue <props.toValue)} onClick={handleOnClick}>
                    Next
                </Button>
        </form>
    );

}
const EachId=(props)=>{
    const classes = useStyles();
    return <FormControlLabel  control={
        <Checkbox name={props.id.value} checked={props.id.checked} color="primary" onChange={props.idCheckChange}/>
    } label={props.id.value} className={classes.id}/>

}
const IdsInput =(props)=>{
    const classes = useStyles();
    return (<>
        <div className={classes.ids}>
            <EachId key={'select all'} id={{value:'select all',checked:props.ids.filter(id=>id.checked===false).length===0}}  idCheckChange={props.idCheckChange}/>
            <FormGroup row >
                {props.ids.map(id=> <EachId key={id.value} id={id} idCheckChange={props.idCheckChange}/>)}
            </FormGroup>  
        </div>      
        <div><Checkbox name='add-label' onChange={props.handleAddLabel} checked={props.addLabelValue} />Add label</div>
        
        <Button variant="contained"   className={classes.cancelButton}  onClick={props.resetForm}>
                    Start over
        </Button>
        <Button variant="contained" color="primary" 
        className={ classes.nextButton}  onClick = {props.submitIds}>
            Add to Map
        </Button>
        </>);
}
const QueryExpand = (props) => {
    const classes = useStyles();

    const [expanded, setExpanded] = useState(false);
    const [enableDataRangeInput, setEnableDataRangeInput] = useState(true);
    const [fromValue, setFromValue] = useState( '');
    const [toValue, setToValue] = useState( '');
    const [ids, setIds] = useState([]);
    const [selectedIds, setSelectedIds]=useState([]);
    const [addLabelValue, setAddLabel]=useState(false);
    const [currentHistoryLayerPara,setcurrentHistoryLayerPara]=useState(null);

    const handleExpandClick = () => {
        setExpanded(!expanded);
    };
    const handleSubmitDateRange =(from,to) =>{
        setEnableDataRangeInput(false);
        var dtFrom=fromValue.replace("T", " ");
        var dtTo=toValue.replace("T", " ");
        props.queryAvlHistoryFromServer(`LocationDate>= '${dtFrom}' and LocationDate<= '${dtTo}'`, true)
            .then(function (response) {
                debugger
                if (response.features.length > 0) {//query and get vehicle id list
                    var ids = response.features.map(feature => {
                        return { 
                            value:feature.attributes[props.idField],
                            checked:false
                        }
                    });
                    setIds(ids);
                } else {
                    alert("No data returned. Please try a different date range.")
                    setEnableDataRangeInput(true);
                }
            });
    };
    const handleIdCheckChange =(event)=>{
        let newList=[...ids];
        if(event.target.name==="select all"){
            newList.forEach(id=>{
                id.checked=event.target.checked;
            })

        }else{
            let index=newList.findIndex(id=>{return id.value===event.target.name});
            newList[index].checked=event.target.checked;
        }
        setIds(newList);     

    };
    const handleSubmitIds = ()=>{ 
        setSelectedIds (ids.filter(id=>id.checked).map(id=>id.value));
    }

    const handleAddLabel=(e)=>{
        setAddLabel ( e.target.checked);
    }
    const addNewHistoryLayer = (sublayer) => {
        if(currentHistoryLayerPara){
            var layerPara={ ...currentHistoryLayerPara };
            layerPara.sublayers.push(sublayer);
            let mapLayers=props.map.allLayers.items;
            let lastLayer=mapLayers[mapLayers.length-1];
            if(lastLayer.id===layerPara.id){
                props.map.remove(lastLayer);
            }
            let layer = new MapImageLayer(layerPara);            
            props.map.add(layer);
        }else{
            var layerPara={
                url: props.Avl_History,
                id: "vh" + (props.map.allLayers.items.length + 1),
                title: formatLayerTitle(fromValue,toValue),
                sublayers: [sublayer]
            }
            
            var layer = new MapImageLayer(layerPara);
            props.map.add(layer);
        }
        setcurrentHistoryLayerPara(layerPara);
    }

    const resetSelectedIds=()=>{
        let newArray=[...ids]
        newArray.forEach(id=>id.checked=false);
        setIds(newArray);
        setSelectedIds([]);
    }

    const resetForm=()=>{
        setFromValue('');
        setToValue('');
        setIds([]);
        setSelectedIds([]);
        setEnableDataRangeInput(true);
        setcurrentHistoryLayerPara(null);
    }

    return (<div className='sidebar'>
        <Button variant='contained' color='primary' className={classes.button} onClick={handleExpandClick} >
            <div className={classes.expand}>{expanded ? "<" : ">"}</div>
            <div class={classes.margin}>Query Vehicle Locator History</div>
        </Button>
        <div style={{display:(expanded?'inline':'none')}}>
            <DateInput fromValue={fromValue} setFromValue={setFromValue} toValue={toValue} setToValue={setToValue} submitDateRange={handleSubmitDateRange} enableInput={enableDataRangeInput}/>
            {
                ids.length > 0 &&
                <IdsInput ids={ids} idCheckChange={handleIdCheckChange} submitIds={handleSubmitIds} resetForm={resetForm} 
                    handleAddLabel={handleAddLabel} addLabelValue={addLabelValue}
                />
            }
        </div>
        <HistoryLayers selectedIds={selectedIds} resetSelectedIds={resetSelectedIds} 
            addNewHistoryLayer={addNewHistoryLayer} 
            idField={props.idField} fromValue={fromValue} toValue={toValue}  addLabelValue={addLabelValue} 
        />
    </div>);
}

export default QueryExpand;