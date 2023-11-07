import  LightningModal  from 'lightning/modal';
import DeleteStiker from 'c/deleteStiker';
import {  api } from 'lwc';
// import  deleteNoteOnServer from '@salesforce/apex/NoteController.deleteNoteOnServer';

export default class EditStiker extends LightningModal {
    
    @api useData;
    @api noteId;
    // @api notes;
    
    

    changeLabelValue = '';
    changeDescriptionValue = '';

    handleLabelChange(event){
        this.changeLabelValue = event.target.value;
    }

    handleDescriptionChange(event){
        this.changeDescriptionValue = event.target.value;
    }

     async deleteHandler(e){
        console.log('Yes====delete' + this.noteId);  
         const deletPopap = await DeleteStiker.open({
            size: 'small',
            description: 'This is a modal popap',
            noteId: this.noteId
       });

       if(deletPopap === true){
        console.log('Closed successfully' + deletPopap);
        this.close(true);
       } 
       
    }

    async handleEdit(){  
        // console.log('UseDate=====' + JSON.stringify(this.useDate));
        let updatedLAbel = this.changeLabelValue || this.useData.Label__c;
        let updatedDescription = this.changeDescriptionValue || this.useData.Description__c;

        this.close({
            label: updatedLAbel,
            description: updatedDescription
            
        });
        console.log('Date======='+ this.changeDescriptionValue);
        console.log('Date======='+ this.changeLabelValue);

    }



}