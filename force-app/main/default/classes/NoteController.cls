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
    public static String deleteNoteOnServer(String noteId) {
        
            try {
                List<Note__c> noteToDelete = [SELECT Id FROM Note__c WHERE Id = :noteId LIMIT 1];
                //List<Note__c> noteToDelete is collection and beacause  if does not use  List<Note__c>   It's  erorr Emppty()
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
            // List<Note__c> notes = [SELECT Id, Label__c, Description__c, Created_Date__c FROM Note__c ORDER BY Created_Date__c DESC];
            System.debug('Param2 ' + notes);
            return notes;
        } catch (Exception e) {
            throw new AuraHandledException('Error searching notes by date: ' + e.getMessage());
        } 
            
    }

    @AuraEnabled
    public static Note__c updateNote(Id noteId, String changeLabelValue, String changeDescriptionValue){
        
        System.debug('Method updateNote: ============');
        System.debug('noteId: ' + noteId);
        System.debug('changeLabelValue: ' + changeLabelValue);
        System.debug('changeDescriptionValue:' + changeDescriptionValue);
        
        
        Note__c note = [SELECT Id FROM Note__c WHERE Id = :noteId LIMIT 1];
            try{
                // if(note !=  null){
                    note.Label__c = changeLabelValue;
                    note.Description__c = changeDescriptionValue;
                    note.Created_Date__c = Datetime.now();
                    
                    update note; 
                    System.debug('Update========' + note); 
                
                    return note;
                // }else{
            // /        return null;
                // }
            } catch (Exception e) {
                 System.debug('Note is not defined====');
                 throw new AuraHandledException('Error upDating :' + e.getMessage());
            }
            
    }
    
}
