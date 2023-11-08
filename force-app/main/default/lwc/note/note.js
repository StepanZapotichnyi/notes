
import { LightningElement, track } from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import MyModal from 'c/myModal';
import EditStiker from 'c/editStiker';
import saveData from '@salesforce/apex/NoteController.saveData';
import getSavedNotes from '@salesforce/apex/NoteController.getSavedNotes';
import searchNotesByDate from '@salesforce/apex/NoteController.searchNotesByDate';
import updateNote from '@salesforce/apex/NoteController.updateNote';
import  deleteNoteOnServer from '@salesforce/apex/NoteController.deleteNoteOnServer';

export default class Note extends LightningElement {


    @track saveNotes = [];
    searchDate = '';
    noteToUpdate;
    inputMessage;

    
    connectedCallback(){
        this.loadSavedData();
    }   

    handleDateChange(event) {
        this.searchDate = event.target.value;
    }
    


    async loadSavedData(){
        console.log('Loading data from server...');
        try{
            this.saveNotes = await getSavedNotes();
        }catch (error){
            console.error('Error loading data', error);
        }
    }

    async handleAdd(){
        const result = await MyModal.open({
            size: 'Small',
            label: 'Note',
            description: 'This is a modal popup'
        });
        
        try{
            const savedNote = await saveData({
                label: result.label,
                description: result.description
            });
                if(savedNote){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Note saved successfully',
                            variant: 'success',
                        })
                    );
                    await this.loadSavedData();
                }
        
            } catch (error)  {
            console.error('Error saving data: '+ error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred saving data',
                    variant: 'error'
                })
            );
        }
    }

    async handleSearch(){
        if(!this.searchDate){
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Please enter a search date',
                    variant: 'error',
                })
            );
            return;
        }
        
        searchNotesByDate({searchDate: this.searchDate})
            .then(response => {
                if(!response || response.length === 0){
                    this.saveNotes = [];
                    this.inputMessage = 'Note does not exist for this date!';
                }else{
                    this.saveNotes = response;
                    this.inputMessage = '';
                }
                this.searchDate = '';
            })
            .catch(error => {

                console.error('Error searching notes by dae: ', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'An error occurred while searching for notes',
                        variant: 'error'
                    })
                );
            });

    }
    async handleAll(e){
        this.inputMessage= "This is a list of all notes!";
        this.loadSavedData();

    }
    
    async handleStickerEdit(event){

        const noteId = event.currentTarget.dataset.id;

        this.noteToUpdate = this.saveNotes.find((note) => note.Id === noteId);

            const editStickerAnswer = await EditStiker.open({
                Label: 'Edit Sticker',
                size : 'small',
                description: 'Edit Sticker popup',
                noteForEdit: this.noteToUpdate,
                noteId: noteId,
            });
        
                // call function to update and to delete
                if(editStickerAnswer.isDelete === true){
                    await this.handleDeleteNote(noteId);

                }else{
                    await this.handleUpdateNote(noteId, editStickerAnswer);
                }
                    
        }

    async handleDeleteNote(noteId){

        deleteNoteOnServer({noteId: noteId})
        
        .then(() => {
            this.saveNotes = this.saveNotes.filter((note)=> note.Id !== noteId);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Note deleted  successfully',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            console.error('Error deleting note: ', error);  
        });
    
    }    
         
    async handleUpdateNote(noteId, editStickerAnswer){
        
        updateNote({noteId: noteId,
            changeLabelValue: editStickerAnswer.label,
            changeDescriptionValue: editStickerAnswer.description})
            .then(upDate => {
                if(upDate){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Edit Sticker',
                            message: 'Update successfully',
                            variant: 'success'
                        })
                    );
                     this.loadSavedData();
                }else{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'error',
                            message: 'An error update',
                            variant: 'error'
                        })
                    );
                }
            })
            .catch(error => {
                console.error('Error searching notes by dae: ', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'error',
                        message: 'Edit is not successful',
                        variant: 'error'
                    })
                );
            });
    }

}