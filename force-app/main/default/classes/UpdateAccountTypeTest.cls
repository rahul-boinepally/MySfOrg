@isTest
public with sharing class UpdateAccountTypeTest {
    @isTest
    public static void TestAllApplicationsHavePaying() {
        TriggerStaticParams.DisableTrigger = true; // set this to true so we dont want to fire the triggers in this specfic test context.
        List<Account> accountsToInsert = AlgoliaTestFactory.InsertAccounts(200);
        List<Id> insertedRecordIds = new List<Id>();
        List<Algolia_Application__c> applications = new List<Algolia_Application__c>();

        for(Account a : accountsToInsert){
            applications.Add(new Algolia_Application__c(Account__c = a.Id, CustomerType__c = 'Paying'));
            insertedRecordIds.Add(a.Id);
        }

        AlgoliaTestFactory.InsertAlgoliaApplications(applications);

        Test.startTest();
        UpdateAccountType UpdateAccountType = new UpdateAccountType();
        UpdateAccountType.query = 'Select Id, AccountType__c from Account';
        Database.executeBatch(UpdateAccountType);
        test.stopTest();

       System.AssertEquals(
           database.countquery('SELECT COUNT() FROM Account WHERE AccountType__c= \'Paying\''),
           200); 
    }

    @isTest
    public static void TestFewApplicationsHavePaying() {
        TriggerStaticParams.DisableTrigger = true; // set this to true so we dont want to fire the triggers in this specfic test context.
        List<Account> accountsToInsert = AlgoliaTestFactory.InsertAccounts(200);
        List<Algolia_Application__c> applications = new List<Algolia_Application__c>();

        for(integer i = 0; i < 100; i++){
            applications.Add(new Algolia_Application__c(Account__c = accountsToInsert[i].Id, CustomerType__c = 'Paying'));
        }

        for(integer i = 99; i < 199; i++){
            applications.Add(new Algolia_Application__c(Account__c = accountsToInsert[i].Id, CustomerType__c = 'Vip'));
        }

        AlgoliaTestFactory.InsertAlgoliaApplications(applications);

        Test.startTest();
        UpdateAccountType UpdateAccountType = new UpdateAccountType();
        UpdateAccountType.query = 'Select Id, AccountType__c from Account';
        Database.executeBatch(UpdateAccountType);
        test.stopTest();

        System.AssertEquals(
           database.countquery('SELECT COUNT() FROM Account WHERE AccountType__c= \'Paying\''),
           100);

        System.AssertEquals(
           database.countquery('SELECT COUNT() FROM Account WHERE AccountType__c= \'Free\''),
           100);     
    }

    @isTest
    public static void TestNoApplicationsHavePaying() {
    
    }
}