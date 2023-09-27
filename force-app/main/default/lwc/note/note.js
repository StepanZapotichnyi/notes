import { LightningElement, track} from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import MyModal from 'c/myModal';
import saveData from '@salesforce/apex/NoteController.saveData'
import deleteNoteOnServer from '@salesforce/apex/NoteController.deleteNoteOnServer';
// import getSavedNotes from '@salesforce/apex/NoteController.getSavedNotes';

export default class Note extends LightningElement {

    @track savedData= [];

    //1
    connectedCallback(){

        const savedData = localStorage.getItem('savedData'); //retrive from database
        if (savedData) {
            this.savedData = JSON.parse(savedData);
        }
    }
    

    async handleAdd(){
        const result = await MyModal.open({
            size: 'Large',
            label: 'Note',
            description: 'This is a modal popup'
        });
        
        // this.result = result;
        // console.log('this.result = ' + this.result);   
    
        if (result) {

            // if (result.description && result.description.includes('\n')) {
            //     result.description = result.description.replace(/\n/g, '<br/>');
            // }

            saveData({
                label: result.label,
                description: result.description
            })
            .then((savedNoteId)=> {
                if(savedNoteId) {
                    

                    result.Id = savedNoteId;
                    this.savedData.push(result);
                    

                    localStorage.setItem('savedData', JSON.stringify(this.savedData));
            
                    this.result = result
                    this.dispatchEvent(
                        new ShowToastEvent({
                        title: 'Success',
                        message: 'Data saved successfully',
                        variant: 'success'
                        })
                    );
                }else{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'An error occurred while saving data',
                            variant: 'error'
                        })
                    );
                }
                
                // this.result = result;
            })
            .catch(error => {
                console.error('Error saving data: ',error)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'An error occurred saving data',
                        variant: 'error'
                    })
                );
            });
        }
    }
    
    handleDelete(event) {
        const noteId = event.target.dataset.id;
        // console.log(event?.detail?.dataset?.id);
        deleteNoteOnServer({noteId: noteId})
            .then((result) => {
                if (result === "Success") {
                    this.savedData = this.savedData.filter((note) => note.Id !== noteId);
                    localStorage.setItem('savedData', JSON.stringify(this.savedData));
                    
                    
                } else {
                    console.error('Error deleting note: ', result);
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'An Error occurred while deleting data: ' + result,
                            variant: 'error'
                        })
                    );
                }
            })
            .catch((error) => {
                console.error('Error deleting note:', error);

            });
    }


}