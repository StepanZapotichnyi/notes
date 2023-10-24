import  LightningModal  from 'lightning/modal';
import { LightningElement, api, track } from 'lwc';

export default class EditStiker extends LightningModal {
    
    @api useDate;
    
    // connectedCallback(){
    //  if(this.useDate) {
        
    //     this.useDate = JSON.parse(this.useDate);
    //     console.log('Date====='+ this.useDate);
    //  }
    // }

    changeLabelValue = '';
    changeDescriptionValue = '';

    handleLabelChange(event){
        this.changeLabelValue = event.target.value;
    }

    handleDescriptionChange(event){
        this.changeDescriptionValue = event.target.value;
    }

    // connectedCallback(){
    //     console.log('Use======' + JSON.stringify(this.useDate));
    // }

     handleEdit(){
       
        console.log('UseDate=====' + JSON.stringify(this.useDate));
        
        
        this.close({
            label: this.changeLabelValue,
            description: this.changeDescriptionValue
            
        });
        console.log('Date======='+ this.changeLabelValue);
    }

}