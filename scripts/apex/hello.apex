// List<Account> accounts =[SELECT Id, Name FROM  Account  WHERE Name = 'Edge Communications'];
// System.debug('Ac' + accounts);

// Id accId = accounts[0].Id;

// List<Contact> contacts = [SELECT Id, AccountId, FirstName, LastName FROM Contact WHERE AccountId = :accId];
// System.debug('Contact' + contacts);

// List<Contact> contactsToUpdate = new List<Contact>();
// for(Contact contact : [SELECT Id, AccountId, FirstName, LastName FROM Contact WHERE Account.Name = 'Edge Communications']){
//     if(contact.LastName == 'Gonzalez'){
//         contact.FirstName = '&CCC';
//         contactsToUpdate.add(contact);
//     }    
// }

// If(!contactsToUpdate.isEmpty()){
//     update contacts;
// }

// System.debug('update ====='+ [SELECT FirstName FROM Contact WHERE AccountId = :accID]);

Account acc = new Account(Name = 'Pubg');
insert acc;

System.debug('acc11===' + acc.Id);

