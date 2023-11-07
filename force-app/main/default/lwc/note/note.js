
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
    searchNull;

    
    connectedCallback(){
        this.loadSavedData();
        console.log('Work');
    }   

    handleDateChange(event) {
        this.searchDate = event.target.value;
    }
    


    async loadSavedData(){
        console.log('Loading data from server...');
        try{
            const result = await getSavedNotes();
            this.saveNotes = result;
            console.log('Saved Data: ', JSON.stringify(this.savedData));
            console.log('Saved Data: ', JSON.stringify(result));
        }catch (error){
            console.error('Error loading data', error);
        }
        // console.log('Updated savedData: ', this.savedData);
    }

    async handleAdd(){
        const result = await MyModal.open({
            size: 'Small',
            label: 'Note',
            description: 'This is a modal popup'
        });
        console.log('work' +  result);
            try{
                const savedNote = await saveData({
                    label: result.label,
                    description: result.description
                });

                // console.log('Saved note ID:', savedNoteId);
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
        console.log('Param: =====' + this.searchDate);
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
        
        
        try{
            this.saveNotes = await searchNotesByDate({ searchDate: this.searchDate });
            console.log('Res ' +  this.savedData);
            if(this.saveNotes.length === 0){
                this.searchNull = "Note does not exist for this date!";
                console.log('Note search: ' + this.saveNotes);
            }else{
                this.searchNull= "";
            }
            this.searchDate = '';

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
    async handleAll(e){
        this.searchNull= "This is a list of all notes!";
        this.loadSavedData();

    }
    
    async handleStickerEdit(event){

        const noteId = event.currentTarget.dataset.id;
        console.log('Event ==== ' + noteId);

        this.noteToUpdate = this.saveNotes.find((note) => note.Id === noteId);
        console.log('Sticker number Id:===== ' +  JSON.stringify(this.noteToUpdate));    

            const editStickerAnswer = await EditStiker.open({
                Label: 'Edit Sticker',
                size : 'small',
                description: 'Edit Sticker popap',
                useData: this.noteToUpdate,
                noteId: noteId,
            });
                 console.log('1========' + editStickerAnswer);
                 console.log('1================================' + this.noteToUpdate.Created_Date__c);

         // call function to update and to delete

                    if(editStickerAnswer ===  true){
                        await this.handleDeleteNote(noteId);
                    }else{
                    await this.handleUpdateNote(noteId, editStickerAnswer);
                    }
                    
        }

    async handleDeleteNote(noteId){
    
            try{
                const deleteNote =  deleteNoteOnServer({noteId: noteId});
                // console.log('Note was deleted: ' + JSON.stringify(deleteNote));
          
                if (deleteNote){
                    this.saveNotes = this.saveNotes.filter((note)=> note.Id !== noteId);
                    console.log('result after delete: '+ JSON.stringify(this.saveNotes));
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Note deleted  successfully',
                            variant: 'success'
                        })
                    );
                }else{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'error',
                            message: 'An error delete',
                            variant: 'error'
                        })
                    );
                }
                
            }catch(error){
                console.error('Error deleting note: ', error);  
            }
            
        }    
         
    async handleUpdateNote(noteId, editStickerAnswer){
        
        try{
                // console.log('Start update2');
                // console.log('noteUse.Id: ' + editSticker.noteUse.Id);
                // console.log('changeLabelValue: "');
                // console.log('changeDescriptionValue: ' + editSticker.changeDescriptionValue);

            const upDate = await updateNote({
                    noteId: noteId,
                    changeLabelValue: editStickerAnswer.label,
                    changeDescriptionValue: editStickerAnswer.description
                });
                    console.log('Start update2');

                    if(upDate){
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Edit Sticker',
                                message: 'Update successfully',
                                variant: 'success'
                            })
                        );
                        await this.loadSavedData();
                    }else{
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'error',
                                message: 'An error update',
                                variant: 'error'
                            })
                        );
                    }
        } catch (error){
            console.error('Error searching notes by dae: ', error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'error',
                    message: 'Edit is not successful',
                    variant: 'error'
                })
            );
        }
    }

}