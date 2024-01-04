public  class ContactTriggerHandler {
    
    public static Boolean isFirstTime = true;
    public static List<Contact> listToUpdateContacts = new List<Contact>();


    public static void updateContactsFieldAfter(List<Account> newAccounts, Map<Id, Account> oldAccount){
            System.debug('NewAccounts'+  newAccounts);
    
        List<Contact> relatedContacts = [SELECT Id, Number__c, Level__c, AccountId FROM Contact WHERE AccountId IN :newAccounts];
        Set<Id> updateContactIds = new Set<Id>();    
        Map<Id, List<Contact>> accountIdToContacts = new Map<Id, List<Contact>>();

            //System.debug('aaaaa' + relatedContacts);
        for (Contact cont : relatedContacts) {
            //System.debug('bbbb' + accountIdToContacts.containsKey(cont.AccountId));
            if (!accountIdToContacts.containsKey(cont.AccountId)) {
                accountIdToContacts.put(cont.AccountId, new List<Contact>{cont});
                System.debug('aaqqqq' + accountIdToContacts);
            }
            accountIdToContacts.get(cont.AccountId).add(cont);
            System.debug('wwww' + accountIdToContacts);
        }
        
        System.debug('Mapa' + accountIdToContacts);

        for(Account acc : newAccounts) {  

            // check if this account is in contacts
            if(!accountIdToContacts.containsKey(acc.Id)){
                continue;
            }
            System.debug('aa' +accountIdToContacts.containsKey(acc.Id));

            for(Contact con : accountIdToContacts.get(acc.Id)) {
                // check duplicates
                if(!updateContactIds.contains(con.id)){

                    if(acc.Type != oldAccount.get(acc.Id).Type){
                        System.debug('===>>>');
                    
                        /////////////////////////////// There should be Map here
                        // String typeResult = '';
                        System.debug('ACCCC' + acc.Type);

                        Map <String, String> typeChoise = new Map<String, String> {'Prospect' => 'Secondary',
                                                                                    'Customer - Direct' => 'Secondary',
                                                                                    'Customer - Channel' => 'Tertiary',
                                                                                    'Channel Partner / Reseller' => 'Tertiary',
                                                                                    'Installation Partner' => 'Primary',
                                                                                    'Technology Partner' => 'Primary',
                                                                                    'Other' => '',
                                                                                    null => ''}; 

                        System.debug('fff' +  typeChoise);
                        System.debug('fff' +  typeChoise.get(acc.Type));
                        // if(acc.Type == 'Prospect' || acc.Type == 'Customer - Direct'){
                        //     typeResult = 'Secondary';
    
                        // }else if(acc.Type == 'Customer - Channel' || acc.Type == 'Channel Partner / Reseller'){
                        //     typeResult = 'Tertiary';
                            
                        // }else if(acc.Type == 'Installation Partner' || acc.Type == 'Technology Partner'){
                        //     typeResult = 'Primary';
                        // }else if(acc.Type == 'Other' || acc.Type == null){
                        //     typeResult = '';
                        // }
                        // typeResult = 
                        con.Level__c = typeChoise.get(acc.Type); 
                        System.debug('Its ok');
                        
                    }
                    //////////////////////
                    if (acc.AccountNumber != oldAccount.get(acc.Id).AccountNumber){
                        System.debug('===!!!');
                        con.Number__c = acc.AccountNumber;
                        System.debug('Its ok1');
                    }
                    //Checking whether a contact has been added 
                    if (!listToUpdateContacts.contains(con)) {
                        listToUpdateContacts.add(con);
                    }
                    updateContactIds.add(con.id);
                }
            }    
        }
        if(!listToUpdateContacts.isEmpty()){
        update listToUpdateContacts;
        }    
    } 
    
    public static void updateContactsAllFieldsBefore(List<Contact> newContacts, Map<Id, Contact> oldContacts){

        // List<Contact> contactsToUpdate = new List<Contact>();

        Set<Id> accountIds = new Set<Id>();
        Set<Id> updateContacts = new Set<Id>();
        
        for (Contact con : newContacts){
            accountIds.add(con.AccountId);
        }
        System.debug('New AccountId------>' + accountIds);

        List<Contact> relatedContacts =  [SELECT Id, Level__c, AccountId FROM Contact WHERE AccountId  IN :accountIds ];
        
        System.debug('Related Contacts' + relatedContacts);

        Map<Id, List<Contact>> accountIdToContacts = new Map<Id, List<Contact>>();

        for(Contact cont : relatedContacts){
            System.debug('wwww' + accountIdToContacts);
            if(!accountIdToContacts.containsKey(cont.AccountId)){
                accountIdToContacts.put(cont.AccountId, new List<Contact>());
                System.debug('aaqqqq' + accountIdToContacts);
            }
            accountIdToContacts.get(cont.AccountId).add(cont);
            System.debug('GEt and ADdd' + accountIdToContacts);
        }
        System.debug('Map' + accountIdToContacts);
    

        for (Contact cont : newContacts){
            System.debug('Camon');

            for(Contact con : accountIdToContacts.get(cont.AccountId)){
                System.debug('qwq' + accountIdToContacts.get(cont.AccountId));
                Contact oldContact = oldContacts.get(cont.Id);

                    
                if(!updateContacts.contains(con.Id)){
    
                    if(oldContact !=null && cont.Level__c != oldContact.Level__c){
                        System.debug('olDLevel-------' + oldContact.Level__c); /// old Level__c value
                        System.debug('Cont-------' + cont.Level__c );
                        con.Level__c  = cont.Level__c;
                        listToUpdateContacts.add(con);
                    }                    
                    updateContacts.add(con.Id);
                }
            }
        }

        if(!listToUpdateContacts.isEmpty()){
            update listToUpdateContacts;
        }  
    }

}
