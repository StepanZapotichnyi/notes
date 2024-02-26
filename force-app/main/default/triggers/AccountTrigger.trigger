trigger AccountTrigger on Account ( after update) {
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        if(ContactTriggerHandler.isFirstTime){
            ContactTriggerHandler.isFirstTime = false;
            ContactTriggerHandler.updateContactsFieldAfter(Trigger.new, Trigger.oldMap);
        }
    
    }   
}
    