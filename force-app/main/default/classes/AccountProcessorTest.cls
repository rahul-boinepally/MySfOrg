@isTest
public class AccountProcessorTest {
	@isTest 
    public static void testCount(){
        List<Account> accounts = new List<Account>();
        for(integer i=0; i <2 ; i ++){
        	Account acns = new Account(name = 'test'+ i);
            accounts.add(acns);
        }
        insert accounts;      
        List<Id> acc = new List<Id>();
        List<Contact> cons = new List<Contact>();
        for(integer i =0; i<2; i++){
            Contact con = new Contact(Firstname = 'test'+i, LastName = 'test'+i, AccountId = accounts[i].Id);
            
            cons.add(con);
            acc.add(accounts[i].Id);
        }
        insert cons;

        test.startTest();
        AccountProcessor.countContacts(acc);
        test.stopTest();
        for(Account accs : [select Number_of_Contacts__c from Account where Id in :acc]){
            system.assertEquals(accs.Number_of_Contacts__c, 1);
        }
    }
}