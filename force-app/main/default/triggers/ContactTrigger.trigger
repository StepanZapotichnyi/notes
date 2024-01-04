    trigger ContactTrigger on Contact ( after update ) {

        if (Trigger.isAfter && Trigger.isUpdate) {
            if(ContactTriggerHandler.isFirstTime){
                System.debug('I am working ====Contact');
                ContactTriggerHandler.isFirstTime =false;
                System.debug('New Trigger' + Trigger.new);
                // System.debug('New Trigger' + Trigger.old);
                System.debug('OldMap Trigger' + Trigger.oldMap);
                ContactTriggerHandler.updateContactsAllFieldsBefore(Trigger.new, Trigger.oldMap);
                
                
                ///////////////////
                // List<Contact> contactsToUpdate = new List<Contact>();

                // Set<String> accountIds = new Set<String>();
                // for (Contact con : Trigger.new){
                //     accountIds.add(con.AccountId);
                // }
                // System.debug('New AccountId------>' + accountIds);



                // List<Contact> relatedContacts = new List<Contact>();
                // // relatedContact = [SELECT Id, Level__c FROM Contact WHERE AccountId  IN :accountId ];
                // for(Contact cont : [SELECT Id, Level__c FROM Contact WHERE AccountId  IN :accountIds ] ){
                //     System.debug('+++++++----->'+ cont.Level__c);
                //     System.debug('All----->'+ cont);
                //     // System.debug('SOQL----->'+ [SELECT Id, Level__c FROM Contact WHERE AccountId  IN :accountIds ]);
                //     relatedContacts.add( cont); 
                // }
                // System.debug('AllContact----->'+relatedContacts);  // here is not full contacts
            
                //  for(Contact updateCont : Trigger.new){
                //     Contact old = Trigger.oldMap.get(updateCont.Id);
                //     System.debug('If----->' + old); // why this is null here?
                // //     System.debug('If----->' + (relatedContacts.get(updateCont.Id).Level__c)); // why this is null here?
                //     if (old != null && updateCont.Level__c != old.Level__c ){
                //         for( Contact relatedCont : relatedContacts )
                //             if (relatedCont.Level__c != updateCont.Level__c){
                //                 relatedCont.Level__c = updateCont.Level__c;
                //                 System.debug('First=========>' + relatedCont.Level__c);
                //                 System.debug('Second=========>' + updateCont.Level__c);
                //                 contactsToUpdate.add(relatedCont);
                //             }
                //         }
                //     }
                //     // System.debug('Second=========>' + contactsToUpdate);
                // update contactsToUpdate;
            
            }
        }
    }
