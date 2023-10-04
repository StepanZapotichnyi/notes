
import { LightningElement, track } from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import MyModal from 'c/myModal';
import saveData from '@salesforce/apex/NoteController.saveData'
import deleteNoteOnServer from '@salesforce/apex/NoteController.deleteNoteOnServer';
import getSavedNotes from '@salesforce/apex/NoteController.getSavedNotes';
import searchNotesByDate from '@salesforce/apex/NoteController.searchNotesByDate';
export default class Note extends LightningElement {

    @track savedData= [];
    @track searchDate = '';

    handleDateChange(event) {
        this.searchDate = event.target.value;
    }


    loadSavedData() {
         getSavedNotes()
            .then((result)=>{
                this.savedData = result;
            })
            .catch((error)=> {
            console.error('Error loading data', error);
            });
    }
    connectedCallback(){
        this.loadSavedData();
    }

    //to do does not update when added
    async handleAdd(){
        const result = await MyModal.open({
            size: 'Small',
            label: 'Note',
            description: 'This is a modal popup'
        });

        if(result) {
            try{
                const savedNoteId = await saveData({
                    label: result.label,
                    description: result.description
                });
                    if(savedNoteId){
                        const savedNote = {
                            Id: savedNoteId,
                            Label__c: result.label,
                            Description__c: result.description,
                            Created_Date__c: new Date().toISOString()
                        };
                        this.savedData = [...this.savedData, savedNote];

                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success',
                                message: 'Data saved successfully',
                                variant: 'success',
                            })
                        );
                        this.loadSavedData();
                    }else {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error',
                                message: 'An error occurred while saving data',
                                variant: 'error'
                            })
                        );
                    }
            
                } catch (error)  {
                console.error('Error saving data: ',error)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'An error occurred saving data',
                        variant: 'error'
                    })
                );
            }
        }
    }

    
    async handleDelete(event) {
        const noteId = event.target.dataset.id;
        // console.log(event?.detail?.dataset?.id);
    
        try {
            const result = await deleteNoteOnServer({ noteId: noteId });

            if (result === 'Success'){
                this.savedData = this.savedData.filter((note)=> note.Id !== noteId);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Data deleted successfully',
                        variant: 'success'
                    })
                );
                // this.loadSavedData();
            }else {
                console.error('Error deleting note: ', result);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'An Error occurred while deleting data: ',
                        variant: 'error'
                    })
                );
            }
        }catch(error){
            console.error('Error deleting note: ', error);
        }
    }
// looking for today's date only ????
    async handleSearch(){
        try{
            this.savedData = await searchNotesByDate({ searchDate: this.searchDate });
            console.log('Res ' +  this.savedData);
        }catch(error){
            console.error('Error searching notes by dae: ', error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while searching for notes',
                    variant: 'error'
                })
            );
        }
    }
}