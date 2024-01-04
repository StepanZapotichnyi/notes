trigger AccountTrigger on Account ( after update) {
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        if(ContactTriggerHandler.isFirstTime){
            System.debug('I am working ====Account');
            System.debug('I am working ====Account' + JSON.serialize(Trigger.new));
            System.debug('Accounts' + Trigger.new.size());
            ContactTriggerHandler.isFirstTime = false;
            ContactTriggerHandler.updateContactsFieldAfter(Trigger.new, Trigger.oldMap);
        }
    
    }   
}
    