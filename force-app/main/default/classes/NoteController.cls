    public with sharing class NoteController {
        
        @AuraEnabled
        public static Note__c saveData(String label, String description ) {
            try {
                System.debug(' Label=' + label + ', Description=' + description);
                Note__c newNote = new Note__c();
                newNote.Label__c = label;
                newNote.Description__c = description;
                newNote.Created_Date__c = Datetime.now();
                
                insert newNote;
                System.debug('Record successfully created:' + newNote.Id);
                return newNote;
            }catch(Exception e) {
                System.debug('Error saving data: ' + e.getMessage());
                throw new AuraHandledException('Error saving data: An error occurred while saving the data.');
            }
    
    }
    
    @AuraEnabled
    public static void deleteNoteOnServer(String noteId) {
        
            try {
                List<Note__c> noteToDelete = [SELECT Id FROM Note__c WHERE Id = :noteId LIMIT 1];
                if (!noteToDelete.isEmpty()) { 
                    delete noteToDelete;
                }
            } catch (Exception e) {
                throw new AuraHandledException('Error deleting data: ' + e.getMessage());
            }
    }

    @AuraEnabled
    public static List<Note__c> getSavedNotes() {
        return [SELECT Id, Label__c, Created_Date__c, Description__c FROM Note__c ORDER BY Created_Date__c DESC];
    }

    @AuraEnabled
    public static List<Note__c> searchNotesByDate(String searchDate){
        System.debug('Param: ' + searchDate);
        try{
            Datetime startDate = Date.valueOf(searchDate);
            Datetime endDate = startDate.addDays(1);

            System.debug('Param1 ' + startDate);
            List<Note__c> notes = [SELECT Id, Label__c, Description__c, Created_Date__c 
                                   FROM Note__c 
                                   WHERE Created_Date__c >= :startDate 
                                    AND Created_Date__c <= :endDate 
                                    ORDER BY Created_Date__c DESC];
            System.debug('Param2 ' + notes);
            
            return notes;
        } catch (Exception e) {
            throw new AuraHandledException('Error searching notes by date: ' + e.getMessage());
        } 
            
    }

    @AuraEnabled
    public static Note__c updateNote(Id noteId, String changeLabelValue, String changeDescriptionValue){
    
            try{
                    Note__c note = new Note__c(id = noteId,Label__c = changeLabelValue,Description__c = changeDescriptionValue,Created_Date__c = Datetime.now());
                    update note; 
                
                    return note;
            } catch (Exception e) {
                 throw new AuraHandledException('Error upDating :' + e.getMessage());
            }
            
    }
    
}
