
import LightningModal from 'lightning/modal';

export default class DeleteStiker extends LightningModal {

     handleYes(){
         
        this.close(true);
    }

    handleNo(){
        this.close(false);
    }
}