import { LightningElement, track, wire} from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import MyModal from 'c/myModal';
import saveData from '@salesforce/apex/NoteController.saveData'
import deleteNoteOnServer from '@salesforce/apex/NoteController.deleteNoteOnServer';
import getSavedNotes from '@salesforce/apex/NoteController.getSavedNotes';

export default class Note extends LightningElement {

    @track savedData= [];


    //1
    @wire(getSavedNotes)
    wiredSavedNotes({ error, data}){
        console.log('Wire is called');
        if (data) {
            this.savedData = data;
            console.log("Result: " + data);
        } else if (error) {
            console.error('Error loading data', error);
        }
    }
    // connectedCallback(){

    //     const savedData = localStorage.getItem('savedData'); //retrive from database
    //     if (savedData) {
    //         this.savedData = JSON.parse(savedData);
    //     }
    // }
    

    async handleAdd(){
        const result = await MyModal.open({
            size: 'Small',
            label: 'Note',
            description: 'This is a modal popup'
        });
        
        // this.result = result;
        // console.log('this.result = ' + this.result);  
         
    
        if (result) {

            console.log('Result 2: ' + result);
            saveData({
                label: result.label,
                description: result.description
            })
            .then((savedNoteId)=> {
                if(savedNoteId) {
                    
                    // getSavedNotes()
                    //     .then((result)=>{
                    //         this.savedData = result;
                    //     })
                    //     .catch((error) => {
                    //         console.error('Error fetching saved data', error);
                    //     });
                    this.savedData = [...this.savedData,{
                        Id: savedNoteId,
                        Label__c: result.label,
                        Description__c: result.description,
                        Created_Date__c: new Date().toISOString()
                    }];

                    // result.Id = savedNote;
                    // this.savedData = [...this.savedData, savedNote]
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
                    //
                    // getSavedNotes()
                    //     .then((data)=>{
                    //         this.savedData = data;
                    //     })
                    //     .catch((error) => {
                    //         console.error('Error fetching saved data', error);
                    //     });
                    this.savedData = this.savedData.filter((note) => note.Id !== noteId);
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Data deleted successfully',
                            variant: 'success'
                        })
                    );
                    
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