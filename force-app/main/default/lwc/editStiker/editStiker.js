import  LightningModal  from 'lightning/modal';
import DeleteStiker from 'c/deleteStiker';
import {  api } from 'lwc';

export default class EditStiker extends LightningModal {
    
    @api noteForEdit;
    @api noteId;


    changeLabelValue = '';
    changeDescriptionValue = '';

    handleLabelChange(event){
        this.changeLabelValue = event.target.value;
    }

    handleDescriptionChange(event){
        this.changeDescriptionValue = event.target.value;
    }

     async deleteHandler(e){ 
         const deletePopup = await DeleteStiker.open({
            size: 'small',
            description: 'This is a modal popap',
            noteId: this.noteId
       });

       if(deletePopup === true){
        this.close({isDelete : true});
       } 
       
    }

    async handleEdit(){  
        let updatedLAbel = this.changeLabelValue || this.noteForEdit.Label__c;
        let updatedDescription = this.changeDescriptionValue || this.noteForEdit.Description__c;

        this.close({
            label: updatedLAbel,
            description: updatedDescription,
            isDelete: false
        });
    }



}