public with sharing class AlgoliaTestFactory {
    public static List<Account> InsertAccounts(integer numberOfAccountsToInsert){
        List<Account> accountsList = new List<Account>();    
        for(integer i =0; i<numberOfAccountsToInsert; i++){
        	Account account = new Account(name = 'AlgoliaTestAccount' + i);
        	accountsList.add(account);
        }

        return InsertAccounts(accountsList);
    }

    public static List<Account> InsertAccounts(List<Account> accounts){
        insert accounts;
        return accounts;
    }

    public static List<Lead> InsertLeads(integer numberOfLeadsToInsert){
        List<Lead> leadsList = new List<Lead>();    
        for(integer i =0; i<numberOfLeadsToInsert; i++){
        	Lead lead = new Lead(FirstName = 'AlgoliaTestLead' + i, LastName = 'LastName'+i, Company = 'Algolia'+i);
        	leadsList.add(lead);
        }

        return InsertLeads(leadsList);
    }

    public static List<Lead> InsertLeads(List<Lead> leads){
        insert leads;
        return leads;
    }

    public static List<Algolia_Application__c> InsertAlgoliaApplications(List<Algolia_Application__c> applications){
        insert applications;
        return applications;
    }

    public static List<Algolia_Application__c> GetApplicationRecord(List<Id> recordIds){
        List<Algolia_Application__c> applications = [Select Account__c, Lead__c, NumberOfRecords__c, NumberOfOperations__c, CustomerType__c from Algolia_Application__c where Id in :recordIds];
        return applications;
    }

    public static List<Account> GetAccountRecord(List<Id> recordIds){
        List<Account> accounts = [Select Id, TotalRecords__c, TotalOperations__c,TotalApplications__c, AccountType__c from Account where Id in :recordIds];
        return accounts;
    }

    public static List<Lead> GetLeadRecord(List<Id> recordIds){
        List<Lead> leads = [Select Id, TotalRecords__c, TotalOperations__c,TotalApplications__c, LeadType__c from Lead where Id in :recordIds];
        return leads;
    }
}