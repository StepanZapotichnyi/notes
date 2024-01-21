    trigger ContactTrigger on Contact ( after update ) {

        if (Trigger.isAfter && Trigger.isUpdate) {
            if(ContactTriggerHandler.isFirstTime){
                System.debug('I am working ====Contact');
                ContactTriggerHandler.isFirstTime =false;
                // System.debug('New Trigger' + Trigger.new);
                // System.debug('OldMap Trigger' + Trigger.oldMap);
                ContactTriggerHandler.updateContactsAllFieldAfter(Trigger.new, Trigger.oldMap);
            
            }
        }
    }
