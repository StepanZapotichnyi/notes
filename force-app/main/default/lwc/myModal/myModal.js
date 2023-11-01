import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import  LightningModal  from 'lightning/modal';

export default class MyModal extends LightningModal{
    
    labelValue = '';
    descriptionValue = '';

    
    handleLabelChange(event) {
        this.labelValue = event.target.value;
    }
    
    handleDescriptionChange(event) {
        this.descriptionValue =event.target.value;
    }

    


  //Close the modal button
    handleSave(){
      // check if fill in the fields      
        if(!this.labelValue || !this.descriptionValue) {

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Fill in the fields',
                    variant: 'error'
                })
            );
            return;
        }


         this.close({
             label: this.labelValue,
             description: this.descriptionValue
        });
    }  
     
}