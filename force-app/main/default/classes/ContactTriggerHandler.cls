public  class ContactTriggerHandler {
    
    public static Boolean isFirstTime = true;
    public static List<Contact> listToUpdateContacts = new List<Contact>();


    public static void updateContactsFieldAfter(List<Account> newAccounts, Map<Id, Account> oldAccount) {
    
        List<Contact> relatedContacts = [
            SELECT
                Id, Number__c, Level__c, AccountId 
            FROM
                Contact 
            WHERE 
                AccountId IN :newAccounts
            ];
        Set<Id> updateContactIds = new Set<Id>();    
        Map<Id, List<Contact>> accountIdToContacts = new Map<Id, List<Contact>>();

        for (Contact cont : relatedContacts) {
            if (!accountIdToContacts.containsKey(cont.AccountId)) {
                accountIdToContacts.put(cont.AccountId, new List<Contact>{cont});
            }
            accountIdToContacts.get(cont.AccountId).add(cont);
        }
        
        List<Type_Of_Choise__mdt> types = Type_Of_Choise__mdt.getAll().values();

        Map<String, String> typeToMetadateType = new Map<String, String>();
        for(Type_Of_Choise__mdt typeRecord : types) {
            typeToMetadateType.put(typeRecord.MType__c, typeRecord.MLevel__c);
        }

        for(Account acc : newAccounts) {  
            // check if this account is in contacts
            if(!accountIdToContacts.containsKey(acc.Id)) {
                continue;
            }

            for(Contact con : accountIdToContacts.get(acc.Id)) {
                // check duplicates
                if(!updateContactIds.contains(con.id)) {
                    if(acc.Type != oldAccount.get(acc.Id).Type) {
                        con.Level__c = typeToMetadateType.get(acc.Type); 
                    }
                    
                    if(acc.AccountNumber != oldAccount.get(acc.Id).AccountNumber) {
                        con.Number__c = acc.AccountNumber;
                    }

                    if(!listToUpdateContacts.contains(con)) {
                        listToUpdateContacts.add(con);
                    }
                    updateContactIds.add(con.id);
                }
            }    
        }
        if(!listToUpdateContacts.isEmpty()) {
            update listToUpdateContacts;
        }    
    } 
    
    public static void updateContactsAllFieldAfter(List<Contact> newContacts, Map<Id, Contact> oldContacts){

        Set<Id> accountIds = new Set<Id>();
        Set<Id> contactsIdsToUpdate = new Set<Id>();
        Map<Id, List<Contact>> accountIdToContacts = new Map<Id, List<Contact>>();
        
        for (Contact con : newContacts) {
            accountIds.add(con.AccountId);
        }

        List<Account> accountsWithContacts = [
            SELECT 
                Id,  
                (SELECT Id, Level__c, AccountId FROM Contacts) 
            FROM 
                Account 
            WHERE 
                ID IN: accountIds
        ];
    
        for (Account acc : accountsWithContacts) {
            List<Contact> contacts = acc.Contacts;
            accountIdToContacts.put(acc.Id, contacts);    
        }

        for (Contact cont : newContacts) {
            if(!accountIdToContacts.containsKey(cont.AccountId)) {
                continue;
            }

            for(Contact con : accountIdToContacts.get(cont.AccountId)) {
                Contact oldContact = oldContacts.get(cont.Id);
                                    
                if(!contactsIdsToUpdate.contains(con.Id)) {    

                    if( cont.Level__c != oldContact.Level__c) {
                        con.Level__c  = cont.Level__c;
                        listToUpdateContacts.add(con);
                    }
                    else if(oldContact != null) {
                        continue;
                    }                   
                    contactsIdsToUpdate.add(con.Id);
                }
            }
        }
        if(!listToUpdateContacts.isEmpty()) {
            update listToUpdateContacts;
        }  
    }

}
