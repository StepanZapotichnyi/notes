public with sharing class NoteController {
    @AuraEnabled
    public static Note__c saveData(String label, String description ) {
        try {
            
            Note__c newNote = new Note__c();
            newNote.Label__c = label;
            newNote.Description__c = description;
            newNote.Created_Date__c = Date.today();
    
            insert newNote;

            return newNote;
        } catch (Exception e) {
            System.debug('Error saving data: ' + e.getMessage());
            return null;
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
                throw new AuraHandledException('Error deleting data: ' + e.getMessage());
            }
    }

    @AuraEnabled(cacheable=true)
    public static List<Note__c> getSavedNotes() {
        return [SELECT Id, Label__c, Created_Date__c, Description__c FROM Note__c ORDER BY Created_Date__c DESC];
    }

    @AuraEnabled
    public static List<Note__c> searchNotesByDate(String searchDate){
        try{
            Date searchDateValue = Date.valueOf(searchDate);

            List<Note__c> notes = [SELECT Id, Label__c, Description__c, Created_Date__c FROM Note__c WHERE Created_Date__c = :searchDateValue ORDER BY Created_Date__c DESC];

            return notes;
        } catch (Exception e) {
            throw new AuraHandledException('Error searching notes by datw: ' + e.getMessage());
        } 
        
    }
    
}
