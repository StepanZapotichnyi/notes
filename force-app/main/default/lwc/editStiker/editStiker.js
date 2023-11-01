import  LightningModal  from 'lightning/modal';
import DeleteStiker from 'c/deleteStiker';
import { LightningElement, api } from 'lwc';
import  deleteOnNoteServer from '@salesforce/apex/NoteController.deleteNoteOnServer';

export default class EditStiker extends LightningModal {
    
    @api useDate;
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
        console.log('Yes====delete' + this.noteId);  
       const deletPopap = await DeleteStiker.open({
        size: 'small',
        description: 'This is a modal popap',
        noteId: this.noteId
       });

       const answerDelete = await deletPopap;

       if(answerDelete === 'Yes'){
        try{
            const deleteNote =  deleteOnNoteServer({noteId: this.noteId});
            this.close("ok");
            
        }catch(error){
            console.error('Error deleting note: ', error);  
        }
        
       } 
       
       

    }

     handleEdit(){  
        // console.log('UseDate=====' + JSON.stringify(this.useDate));
        let updatedLAbel = this.changeLabelValue || this.useDate.Label__c;
        let updatedDescription = this.changeDescriptionValue || this.useDate.Description__c;


        // if(!this.changeLabelValue == null ){
        //     this.close({
        //     label: this.useDate.Label__c,
        //     description: this.changeDescriptionValue
        //     });
        // }else if(this.changeDescriptionValue == null){
        //     this.close({
        //         label: this.changeLabelValue,
        //         description: this.useDate.Description__c
        //     });
        // }else{
        //     this.close({
        //         label: this.changeLabelValue,
        //         description: this.changeDescriptionValue
                
        //     });
        // }
        
        this.close({
            label: updatedLAbel,
            description: updatedDescription
            
        });
        console.log('Date======='+ this.changeDescriptionValue);
        console.log('Date======='+ this.changeLabelValue);

    }



}