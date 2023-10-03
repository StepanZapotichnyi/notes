public with sharing class NoteController {
    @AuraEnabled
    public static Id saveData(String label, String description ) {
        try {
            
            Note__c newNote = new Note__c();
            newNote.Label__c = label;
            newNote.Description__c = description;
            newNote.Created_Date__c = Date.today();
    
            insert newNote;             
            return newNote.Id;
        } catch (Exception e) {
            System.debug('Error saving data: ' + e.getMessage());
            return null;
            // return 'Error saving data: ' + e.getMessage();
        }
    }
    
    @AuraEnabled
    public static String deleteNoteOnServer(String noteId) {
        try {
            List<Note__c> noteToDelete = [SELECT Id FROM Note__c WHERE Id = :noteId LIMIT 1];
            if (!noteToDelete.isEmpty()) {
                delete noteToDelete;
                return 'Success';
            } else {
                return 'Note not found';
            }
        } catch (Exception e) {
            return 'Error deleting data: ' + e.getMessage();
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Note__c> getSavedNotes() {
        return [SELECT Id, Label__c, Created_Date__c, Description__c FROM Note__c ORDER BY Created_Date__c DESC];
    }
}
