@isTest
public class ContactTriggerHandler_Test {

    @TestSetup
    static void createData() {
        //create a new account and contact
        List<Account> testAccouts = new List<Account>();
        List<Contact> testContacts = new List<Contact>();
        
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'T&T' + i, AccountNumber = 'WR' + i);
            testAccouts.add(acc);
        }
        insert testAccouts;

        for(Account a : testAccouts) {    
            for (Integer j = 0; j < 5; j++) {
                Contact con = new Contact(
                    AccountId = a.Id,
                    Salutation = 'Mr.',
                    LastName = 'ContactLastName' + j, 
                    FirstName = 'ContactFirstName' + j,
                    Level__c = 'Secondary'
                    
                );
                testContacts.add(con);
            }
        }    
        insert testContacts;
        
    }

    @isTest
    static void testUpdateContactsFieldAfter() {

        // Modify account fields
        List<Account>  accountForUpdate = [SELECT Id, Type, AccountNumber FROM Account LIMIT 2];

        accountForUpdate[0].Type = 'Prospect';
        accountForUpdate[0].AccountNumber = '1112';
        accountForUpdate[1].Type = 'Installation Partner';
        accountForUpdate[1].AccountNumber = 'w1111';
        update accountForUpdate; 

        List<Contact> updateConts = [SELECT Id, Number__c, Level__c, AccountId FROM Contact WHERE AccountId  IN :accountForUpdate];
        System.assertEquals(10, updateConts.size(), '10  contacts not updated');

        for(Contact con : updateConts) {
            if(con.AccountId == accountForUpdate[0].id) {
                System.assertEquals('1112', con.Number__c, 'Contacts with field Number is not updated');
                System.assertEquals('Secondary', con.Level__c, 'Contacts with field Level is not updated');
            }else if(con.AccountId == accountForUpdate[1].id) {
                System.assertEquals('Primary', con.Level__c, 'Contacts with field Level is not updated');
                System.assertEquals('w1111', con.Number__c, 'Contacts with field Number is not updated');
            }

        }
        
    }

    @isTest
    static void testUpdateContactsAllFieldAfter() {
        
        List<Account> accounts = [SELECT Id, Type, AccountNumber FROM Account LIMIT 2];
        List<Contact> contacts = [SELECT Id, AccountId, Level__c FROM Contact WHERE AccountID IN :accounts];

        // Modify contact field
        contacts[0].Level__c = 'Tertiary';
        contacts[9].Level__c = 'Primary';
        update contacts;

        // Verify that the contact's Level__c field is updated
        List<Contact> updateContacts = [SELECT Id, Level__c, AccountId, Number__c FROM Contact WHERE  AccountId IN :accounts];
        System.assertEquals(10, updateContacts.size(), '10  contacts not contacts ');

        for(Contact contact : updateContacts) {
            if(contact.AccountId == accounts[0].Id) {
                System.assertEquals('Tertiary', contact.Level__c, 'Contact Level__c field not updated fot accouts[0]');

            } else if(contact.AccountId == accounts[1].id) {
                System.assertEquals('Primary', contact.Level__c, 'Contact Level__c field not updated fot accounts[1]');
            }
        
        }
    }

}
