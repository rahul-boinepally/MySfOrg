// this batch class takes a list of all accounts where AccountType__c is null.
// if any of the Algolia_Application's related Account contains a CustomerType of `Paying`
// then we set the Account's AccountType__c to `Paying`. If not, then we set it to `Free`.  
global class UpdateAccountType implements Database.Batchable<sObject> {
    global string query;

    public Database.querylocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    // this method takes a list of all accounts where AccountType__c is null.
    // then create a map with accounts to be updated and set a defaulted AccountType to free.
    // if any Algolia application contains `Paying` customer type, then we set Account to Paying. 
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Account> accounts = new List<Account>();
        Map<Id, Account> accountsToUpdate = new Map<Id, Account>();

        // if any of the Algolia_Application's related Account contains a CustomerType of `Paying`
        // then we set the Account's AccountType__c to `Paying`. If not, then we set it to `Free`.  
        for(sObject s : scope)
        {
            Account account = (Account) s;
            account.AccountType__c = 'Free';
            accounts.Add(account);
            accountsToUpdate.Put(account.Id, account);
        }

        for(Algolia_Application__c application: [Select CustomerType__c, Account__c from Algolia_Application__c where Account__c In :accountsToUpdate.KeySet()]){
            if(application.CustomerType__c == 'Paying'){
                accountsToUpdate.Get(application.Account__c).AccountType__c = 'Paying';
            }
        }
                
        update accountsToUpdate.Values();        
    }

    public void finish(Database.BatchableContext BC){
        // not implemented for now as we dont need any post batch processing for this.
    }
}