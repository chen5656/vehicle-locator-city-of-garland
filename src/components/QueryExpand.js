import React, { useRef, useEffect, useState } from 'react';
import { makeStyles } from '@material-ui/core/styles';

import Grid from '@material-ui/core/Grid';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import FormGroup from '@material-ui/core/FormGroup';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import Checkbox from '@material-ui/core/Checkbox';

import Backdrop from '@material-ui/core/Backdrop';
import CircularProgress from '@material-ui/core/CircularProgress';
 
import Query from '@arcgis/core/tasks/support/Query';
import QueryTask from '@arcgis/core/tasks/QueryTask';

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
        height: ' 500px',
        padding: '15px',
        margin: '5px',
    },
    id:{
        minWidth:'120px'
    }
}));
const DateInput = (props) => {
    const classes = useStyles();

    const handleFromTimeChange=(e)=>{
        props.setFromValue(e.target.value);
    }
    const handleToTimeChange=(e)=>{
        props.setToValue(e.target.value);
    }
    return (
        <form autoComplete="off" >
                <TextField            
                    id="dateTimeFrom"
                    label="From"
                    type="datetime-local"
                    variant="outlined"
                    disabled ={!props.enableInput}
                    inputProps={{
                      max:new Date().toISOString().split("T")[0] + "T23:59:59", 
                    }}
                    defaultValue={props.fromValue}
                    className={classes.textField} 
                    InputLabelProps={{
                        shrink: true,
                    }}
                    onChange={handleFromTimeChange}
                />
                <TextField
                    id="dateTimeTo"
                    label="To"
                    type="datetime-local"
                    variant="outlined"
                    disabled={!(props.enableInput&&props.fromValue)}
                    
                    inputProps={{
                        max: new Date().toISOString().split("T")[0] + "T23:59:59", 
                        min:props.fromValue,
                      }}
                      defaultValue={props.toValue}
                    className={classes.textField} 
                    InputLabelProps={{
                        shrink: true,
                    }}
                    onChange={handleToTimeChange}
                />
                <Button variant="contained" color="primary" className={props.enableInput?classes.nextButton:classes.hidden} 
                 disabled={!(props.fromValue&&props.toValue&&props.fromValue <props.toValue)} onClick={props.submitDateRange}>
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
            <FormGroup row >
                {props.ids.map(id=> <EachId key={id.value} id={id} idCheckChange={props.idCheckChange}/>)}
            </FormGroup>  
        </div>      
        <Button variant="contained"   className={classes.cancelButton}  >
                    Start over
        </Button>
        <Button variant="contained" color="primary" 
        className={ classes.nextButton}  >
                    Add to Map
        </Button>
        </>);
}
const QueryExpand = (props) => {
    const classes = useStyles();

    const [expanded, setExpanded] = useState(false);
    const [wait, setWait] = useState(false);
    const [enableDataRangeInput, setEnableDataRangeInput] = useState(true);    
    const [fromValue, setFromValue] = useState(null);
    const [toValue, setToValue] = useState(null);
    const [ids,setIds]=useState([]);
    const Avl_History = "https://cogmap4.garlandtx.gov/server/rest/services/dept_Water/VehicleLocator_History/MapServer";
    const idField = "LoginName";
    const queryAvlTask = new QueryTask({
        url: `${Avl_History}/0`
    });

    const handleExpandClick = () => {
        setExpanded(!expanded);
    };
    const handleSubmitDateRange =() =>{
        setWait(true);
        setEnableDataRangeInput(false);
        var dtFrom=fromValue.replace("T", " ");
        var dtTo=toValue.replace("T", " ");
        var query = new Query({
            where: `LocationDate>= '${dtFrom}' and LocationDate<= '${dtTo}'`,
            outFields: [idField],
            returnDistinctValues: true,
            returnGeometry: false,
            orderByFields: idField,
        });
        queryAvlTask.execute(query)
            .then(function (response) {
                if (response.features.length > 0) {//query and get vehicle id list
                    var ids = response.features.map(feature => {
                        return { 
                            value:feature.attributes[idField],
                            checked:false
                        }
                    });
                    ids.unshift({
                        value:'select all',
                        checked:false,
                    })
                    setIds(ids);
                } else {
                    alert("No data returned. Please try a different date range.")
                    setEnableDataRangeInput(true);
                }
                setWait(false);

            });
    }

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
        



        debugger;
        //[event.target.name]: event.target.checked

        // let newList=[...ids];
        // if(add){
        //     newList.push(id);
        //     setCheckedIds(newList);
        // }else{
        //     let index=newList.findIndex(id);
        //     if(index)newList.splice(pos, 1);
        // }
        

    }
    return (<div className='sidebar'>
        <Button variant='contained' color='primary' className={classes.button} onClick={handleExpandClick} >
            <div className={classes.expand}>{expanded ? "<" : ">"}</div>
            <div class={classes.margin}>Query Vehicle Locator History</div>
        </Button>
        <div style={{display:(expanded?'inline':'none')}}>
            <DateInput fromValue={fromValue} setFromValue={setFromValue} toValue={toValue} setToValue={setToValue} submitDateRange={handleSubmitDateRange} enableInput={enableDataRangeInput}/>
            {ids.length>0&&<IdsInput ids={ids} idCheckChange={handleIdCheckChange}/>}
            <Backdrop className={classes.backdrop} open={wait} >
                <CircularProgress color="inherit" />
            </Backdrop>
        </div>
    </div>);
}

export default QueryExpand;