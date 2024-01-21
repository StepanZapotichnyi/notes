@isTest
public class ContactTriggerHandler_Test {

    @isTest
    static void testUpdateContactsFieldAfter() {
        // Created test accounts and cintacts
        List<Account> testAcc = new List<Account>();
        List<Contact> testCont = new List<Contact>();
        
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'T&T', AccountNumber = 'WR' + i);
            testAcc.add(acc);
        }
        
        insert testAcc;   
        for(Account a : testAcc) {    
            for (Integer j = 0; j < 5; j++) {
                Contact con = new Contact(
                    AccountId = a.Id,
                    Salutation = 'Mr.',
                    LastName = 'ContactLastName' + j, 
                    FirstName = 'ContactFirstName' + j
                );
                testCont.add(con);
            }
        }    
        insert testCont;
        // Modify account fields

        for(Account a : testAcc ){
            if(a.id == testAcc[0].id){
                a.Type = 'Prospect';
                a.AccountNumber = '1112';   
            }else if(a.id == testAcc[1].id){
                a.Type = 'Installation Partner';
                a.AccountNumber = 'w1111';
            }
        }

        update testAcc; 

        List<Contact> updateConts = [SELECT Id, Number__c, Level__c, AccountId FROM Contact WHERE AccountId  IN :testAcc];
        
        // System.assertEquals(10, updateConts.size(), '10  contacts not updated');

        for(Contact con : updateConts) {
            if(con.AccountId == testAcc[0].id){
                System.assertEquals('1112', con.Number__c, 'Contacts with field Number is not updated');
                System.assertEquals('Secondary', con.Level__c, 'Contacts with field Level is not updated');
            }else if(con.AccountId == testAcc[1].id){
                System.assertEquals('Primary', con.Level__c, 'Contacts with field Level is not updated');
                System.assertEquals('w1111', con.Number__c, 'Contacts with field Number is not updated');
            }
            // System.assertNotEquals(null, con.Number__c, 'Contacts are not updated');
            // System.assertNotEquals(null, con.Level__c, 'Contacts are not updated');

        }
        
    }

    @isTest
    static void testUpdateContactsAllFieldAfter() {
        //create a new account and contact
        List<Account> testAcc = new List<Account>();
        List<Contact> testCont = new List<Contact>();
        
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'T&T', AccountNumber = 'WR' + i);
            testAcc.add(acc);
        }
        
        insert testAcc;   
        for(Account a : testAcc) {    
            for (Integer j = 0; j < 5; j++) {
                Contact con = new Contact(
                    AccountId = a.Id,
                    Salutation = 'Mr.',
                    LastName = 'ContactLastName' + j, 
                    FirstName = 'ContactFirstName' + j
                );
                testCont.add(con);
            }
        }    
        insert testCont;

        // Modify contact field

        for (Contact con : testCont){
            if(con.AccountId == testAcc[0].Id){
                con.Level__c = 'Secondary';    
            }else if(con.AccountId == testAcc[1].Id) {
                con.Level__c = 'Primary'; 
            }
        }
        update testCont;

        // Verify that the contact's Level__c field is updated
        
        List<Contact> updateContacts = [SELECT Id, Level__c, AccountId, Number__c FROM Contact WHERE  AccountId IN :testAcc];
        // System.assertEquals(10, updateContacts.size(), '10  contacts not updated');

        for(Contact contact : updateContacts){
            if(contact.AccountId == testAcc[0].Id){
                System.assertEquals('Secondary', contact.Level__c, 'Contact Level__c field not updated');

            }else if(contact.AccountId == testAcc[1].id){
                System.assertEquals('Primary', contact.Level__c, 'Contact Level__c field not updated');
            }
        
        }
    }

}
