public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds){       
        List<Account> accUpdates = new List<Account>();
        for(Account acc : [select Id, name ,Number_of_Contacts__c, (select Id from contacts where AccountId in :accountIds) from Account where Id in :accountIds]){
            system.debug(acc.contacts.size());            
            acc.Number_of_Contacts__c = acc.contacts.size();
            accUpdates.add(acc);
        }
        if(accUpdates.size() > 0){
            update accUpdates;
        }
    }
}