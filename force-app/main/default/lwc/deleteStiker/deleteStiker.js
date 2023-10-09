
import LightningModal from 'lightning/modal';

export default class DeleteStiker extends LightningModal {

     handleYes(){
         
        this.close('Yes');
    }
    // handleYes(){

    //     const noteId =  this.noteId;

    //     this.deleteNoteOnServer(noteId);
    //     this.close('Yes');
    // }

    handleNo(){
        this.close('No');
    }
}