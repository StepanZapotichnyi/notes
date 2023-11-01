
import { LightningElement, track } from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import MyModal from 'c/myModal';
// import DeleteStiker from 'c/deleteStiker';
import EditStiker from 'c/editStiker';
import saveData from '@salesforce/apex/NoteController.saveData'
// import deleteNoteOnServer from '@salesforce/apex/NoteController.deleteNoteOnServer';
import getSavedNotes from '@salesforce/apex/NoteController.getSavedNotes';
import searchNotesByDate from '@salesforce/apex/NoteController.searchNotesByDate';
import updateNote from '@salesforce/apex/NoteController.updateNote';

export default class Note extends LightningElement {


    @track savedData= [];
    @track searchDate = '';
    noteUse;

    handleDateChange(event) {
        this.searchDate = event.target.value;
    }
    


    async loadSavedData(){
        console.log('Loading data from server...');
        try{
            const result = await getSavedNotes();
            this.savedData = result;
            console.log('Saved Data: ', JSON.stringify(this.savedData));
            console.log('Saved Data: ', JSON.stringify(result));
        }catch (error){
            console.error('Error loading data', error);
        }
        // console.log('Updated savedData: ', this.savedData);
    }

    connectedCallback(){
        this.loadSavedData();
        console.log('Work');
    }

    async handleAdd(){
        const result = await MyModal.open({
            size: 'Small',
            label: 'Note',
            description: 'This is a modal popup'
        });
        console.log('work' +  result);
        if(result) {
            try{
                const savedNoteId = await saveData({
                    label: result.label,
                    description: result.description
                });

                // console.log('Saved note ID:', savedNoteId);
                    if(savedNoteId){
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success',
                                message: 'Data saved successfully',
                                variant: 'success',
                            })
                        );

                            // console.log('Note added successfully');
                         await this.loadSavedData();
                        
                    }else {
                        console.error('Error saving data: ' + error);
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error',
                                message: 'An error occurred while saving data',
                                variant: 'error'
                            })
                        );
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
    }

    
    // async handleDelete(event) {

        
    //     const noteId = event.target.dataset.id;
    //     // console.log(event?.detail?.dataset?.id);
    //     const deletPopap = await DeleteStiker.open({
    //         size: 'small',
    //         description: 'This is a modal popap',
    //         noteId: noteId

    //     });
    //     console.log('Popap : '+ deletPopap);

    //     const result = await deletPopap;

    //     if (result === "Yes") {        
    
    //     try {
    //         const result = await deleteNoteOnServer({ noteId: noteId });

    //         if (result === 'Success'){
    //             // this.savedData = this.savedData.filter((note)=> note.Id !== noteId);
    //             this.dispatchEvent(
    //                 new ShowToastEvent({
    //                     title: 'Success',
    //                     message: 'Data deleted successfully',
    //                     variant: 'success'
    //                 })
    //             );
    //             // this.loadSavedData();
    //         }else {
    //             console.error('Error deleting note: ', result);
    //             this.dispatchEvent(
    //                 new ShowToastEvent({
    //                     title: 'Error',
    //                     message: 'An Error occurred while deleting data: ',
    //                     variant: 'error'
    //                 })
    //             );
    //         }
    //     }catch(error){
    //         console.error('Error deleting note: ', error);
    //     }
    //     }
    // }


    async handleSearch(){
        
        if(!this.searchDate){
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Place enter a search date',
                    variant: 'error',
                })
            );
            return;
        }
        
        
        try{
            this.savedData = await searchNotesByDate({ searchDate: this.searchDate });
            console.log('Res ' +  this.savedData);
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

    ///////////////////////////////////////////////////////////////////////////////////
    
    async handleStickerEdit(event){

        const noteId = event.currentTarget.dataset.id;
        console.log('Event ==== ' + noteId);

        this.noteUse = this.savedData.find((note) => note.Id === noteId);
        console.log('Sticker number Id:===== ' +  JSON.stringify(this.noteUse));    

            const editSticker = await EditStiker.open({
                Label: 'Edit Sticker',
                size : 'small',
                description: 'Edit Sticker popap',
                useDate: this.noteUse,
                noteId: noteId

    /////////////////////////////////////////////////////////////////////////////////////
            });
         console.log('1========' + editSticker);
         console.log('1================================' + this.noteUse.Created_Date__c);
        
         if(editSticker ===  'ok'){

            this.savedData = this.savedData.filter((note)=> note.Id !== noteId);
            console.log('result ater delete: '+ JSON.stringify(this.savedData));
            // await this.loadSavedData();
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Data deleted successfully',
                    variant: 'success'
                })
            );
            // await this.loadSavedData();
         }else{
         await this.handleUpdateNote(noteId, editSticker);

         }
    }
         
    async handleUpdateNote(noteId, editSticker){
        
            try{
                // console.log('Start update2');
                // console.log('noteUse.Id: ' + editSticker.noteUse.Id);
                // console.log('changeLabelValue: "');
                // console.log('changeDescriptionValue: ' + editSticker.changeDescriptionValue);


                    const upDate = await updateNote({
                            noteId: noteId,
                            changeLabelValue: editSticker.label,
                            changeDescriptionValue: editSticker.description
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
                    // this.dispatchEvent(
                    //     new ShowToastEvent({
                    //         title: 'error',
                    //         message: 'An error',
                    //         variant: 'error'
                    //     })
                    // );
                }
    }
}