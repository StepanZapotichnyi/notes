    trigger ContactTrigger on Contact ( after update ) {

        if (Trigger.isAfter && Trigger.isUpdate) {
            if(ContactTriggerHandler.isFirstTime){
                ContactTriggerHandler.isFirstTime =false;
                ContactTriggerHandler.updateContactsAllFieldAfter(Trigger.new, Trigger.oldMap);
            
            }
        }
    }
