@isTest
public with sharing class NoteControllerTest {
    
    @isTest
    static void testSaveDate() {
        
        // create a new test note
        Note__c testNote = new Note__C();
        testNote.Label__c = 'Test Label';
        testNote.Description__c = 'Test Description';

        //call method SaveDate here
        Note__c savedNote = NoteController.saveData(testNote.Label__c, testNote.Description__c);

        

        // Check! The recording data corresponds to the transmitted data
        System.assertEquals(testNote.Label__c, savedNote.Label__c, 'LAbel  incorrect ');
        System.assertEquals(testNote.Description__c, savedNote.Description__c, 'Description incorrect ');
    }

    @isTest
    static void testDeleteNoteOnServer(){
        
        //create a new note for deleting
        Note__c testNote = new Note__c();
        testNote.Label__c = 'Test Label';
        testNote.Description__c ='Test DEscription';
        testNote.Created_Date__c= System.now();
        insert testNote;

        //call method deleteNote here
         NoteController.deleteNoteOnServer(testNote.Id);
    
        List<Note__c> delNote = [SELECT ID FROM Note__c WHERE ID = :testNote.Id LIMIT 1 ];

        System.assertEquals(0, delNote.size(), 'Note is not delete from database');
    }


    @isTest
    static void testGetSvedNotes(){

    //create new note
        List<Note__c> testNotes = new List<Note__c>();
        for (Integer i = 0; i < 5; i++) {
            Note__c note = new Note__c();
            note.Label__c = 'Test Note ' + i;
            note.Description__c = 'Description ' + i;
            note.Created_Date__c = System.now().addDays(-i);
            testNotes.add(note);
        }
        insert testNotes;

        //call method getSvedNotes here
        List<Note__c> result = NoteController.getSavedNotes();

        //checking if there are 5 notes
        System.assertEquals(5, result.size(), 'Notes dose not found');
        

    }

    @isTest
    static void testSearchNotesByDate(){
    
        Note__c note1 = new Note__c(Label__c = 'Test1', Description__c = 'Description1', Created_Date__c = Date.today());
        Note__c note2 = new Note__c(Label__c = 'Test2', Description__c = 'Description2', Created_Date__c = Date.today().addDays(-1));   
        insert new List<Note__c> {note1, note2}; 
    
        List<Note__c> result = NoteController.searchNotesByDate(String.valueOf(Date.today()));
    
        System.assertEquals(1, result.size(), 'Result method is null.');
    
        System.assertEquals(note1.Id, result[0].Id, 'First note is not found.');    
    }

    

     @isTest
    static void testUpdateNote() {
        //create a new note
        Note__c testUpdate = new Note__c();
        testUpdate.Label__c = 'Test Label';
        testUpdate.Description__c = 'Test Description';
        testUpdate.Created_Date__c = System.now().addDays(-1);
        insert testUpdate;
        //call method and new date pass
        Note__c updatedNote = NoteController.updateNote(testUpdate.id, 'Updated Label', 'Updated Description');

        
        
        //check update LAbel and Description 
        System.assertNotEquals(null, updatedNote, 'The note was not updated');
        System.assertEquals('Updated Label', updatedNote.Label__c,  ' The Label was not updated.');
        System.assertEquals('Updated Description', updatedNote.Description__c, 'The Description was not updated');


    }

}   