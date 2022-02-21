@isTest
public with sharing class AlgoliaTests {
    @isTest
    public static void TestUpdateAccounts() {
        List<Account> acconts = AlgoliaTestFactory.InsertAccounts(1);
        Algolia_Application__c application1 = new Algolia_Application__c(Account__c = acconts[0].Id, NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Paying');
        Algolia_Application__c application2 = new Algolia_Application__c(Account__c = acconts[0].Id, NumberOfRecords__c = 3, NumberOfOperations__c = 4, CustomerType__c = 'Paying');
        List<Algolia_Application__c> applicationsToInsert = new List<Algolia_Application__c>{
            application1, application2
        };

        test.startTest();
        List<Algolia_Application__c> insertedApplications = AlgoliaTestFactory.InsertAlgoliaApplications(applicationsToInsert);
        test.stopTest();

        List<Id> accounts = new List<Id>();
        for(Account account : acconts){
            accounts.Add(account.Id);
        }

        List<Account> accountsAfterTrigger = AlgoliaTestFactory.GetAccountRecord(accounts);
        system.assertEquals(accountsAfterTrigger.size(), 1);
        system.assertEquals(accountsAfterTrigger[0].TotalRecords__c, 8); // this proves the number of records correctly adds up (5+3)
        system.assertEquals(accountsAfterTrigger[0].TotalOperations__c, 4); // this proves the highest operations record is populated
        system.assertEquals(accountsAfterTrigger[0].TotalApplications__c, 2); // this proves the total applications correctly adds up (2 application records)
    }

    @isTest
    public static void TestUpdateMultipleAccounts() {
        List<Account> accounts = AlgoliaTestFactory.InsertAccounts(2);
        List<Id> accountsIds = new List<Id>();
        Map<Id, Account> mapsToAssert = new Map<Id, Account>();
        List<Algolia_Application__c> applicationsToInsert = new List<Algolia_Application__c>();
        integer counter = 0;
        for(Account account : accounts){
            Algolia_Application__c application1 = new Algolia_Application__c(Account__c = account.Id, NumberOfRecords__c = counter, NumberOfOperations__c = counter+1, CustomerType__c = 'Paying');
            Algolia_Application__c application2 = new Algolia_Application__c(Account__c = account.Id, NumberOfRecords__c = counter+2, NumberOfOperations__c = counter+3, CustomerType__c = 'Paying');
            applicationsToInsert.Add(application1);
            applicationsToInsert.Add(application2);
            accountsIds.Add(account.Id);
            mapsToAssert.put(account.Id, new Account(TotalRecords__c = counter+counter+2, TotalOperations__c = counter+3 )); // this way we can dynamically store the expected values to be asserted.
            counter++;
        }

        test.startTest();
        List<Algolia_Application__c> insertedApplications = AlgoliaTestFactory.InsertAlgoliaApplications(applicationsToInsert);
        test.stopTest();

        List<Account> accountsAfterTrigger = AlgoliaTestFactory.GetAccountRecord(accountsIds);
        system.assertEquals(accountsAfterTrigger.size(), 2);
        for(Account acc : accountsAfterTrigger){
            system.assertEquals(acc.TotalRecords__c, mapsToAssert.Get(acc.Id).TotalRecords__c); // this proves the number of records correctly adds up
            system.assertEquals(acc.TotalOperations__c, mapsToAssert.Get(acc.Id).TotalOperations__c); // this proves the highest operations record is populated
            system.assertEquals(acc.TotalApplications__c, 2); // this proves the total applications correctly adds up (2 application records per Account)
        }
    }

    @isTest
    public static void TestUpdateLeads() {
        List<Lead> leads = AlgoliaTestFactory.InsertLeads(1);
        Algolia_Application__c application1 = new Algolia_Application__c(Lead__c = leads[0].Id, NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Paying');
        Algolia_Application__c application2 = new Algolia_Application__c(Lead__c = leads[0].Id, NumberOfRecords__c = 3, NumberOfOperations__c = 4, CustomerType__c = 'Paying');
        List<Algolia_Application__c> applicationsToInsert = new List<Algolia_Application__c>{
            application1, application2
        };

        test.startTest();
        List<Algolia_Application__c> insertedApplications = AlgoliaTestFactory.InsertAlgoliaApplications(applicationsToInsert);
        test.stopTest();

        List<Id> leadIds = new List<Id>();
        for(Lead lead : leads){
            leadIds.Add(lead.Id);
        }

        List<Lead> leadAfterTrigger = AlgoliaTestFactory.GetLeadRecord(leadIds);
        system.assertEquals(leadAfterTrigger.size(), 1);
        system.assertEquals(leadAfterTrigger[0].TotalRecords__c, 8); // this proves the number of records correctly adds up (5+3)
        system.assertEquals(leadAfterTrigger[0].TotalOperations__c, 4); // this proves the highest operations record is populated
        system.assertEquals(leadAfterTrigger[0].TotalApplications__c, 2); // this proves the total applications correctly adds up (2 application records)
    }

    @isTest
    public static void TestUpdateMultipleLeads() {
        List<Lead> leads = AlgoliaTestFactory.InsertLeads(2);
        List<Id> leadIds = new List<Id>();
        Map<Id, Lead> mapsToAssert = new Map<Id, Lead>();
        List<Algolia_Application__c> applicationsToInsert = new List<Algolia_Application__c>();
        integer counter = 0;
        for(Lead lead : leads){
            counter++;
            Algolia_Application__c application1 = new Algolia_Application__c(Lead__c = lead.Id, NumberOfRecords__c = counter, NumberOfOperations__c = counter+1, CustomerType__c = 'Paying');
            Algolia_Application__c application2 = new Algolia_Application__c(Lead__c = lead.Id, NumberOfRecords__c = counter+2, NumberOfOperations__c = counter+3, CustomerType__c = 'Paying');
            applicationsToInsert.Add(application1);
            applicationsToInsert.Add(application2);
            leadIds.Add(lead.Id);
            mapsToAssert.put(lead.Id, new Lead(TotalRecords__c = counter+counter+2, TotalOperations__c = counter+3 )); // this way we can dynamically store the expected values to be asserted.
        }

        test.startTest();
        List<Algolia_Application__c> insertedApplications = AlgoliaTestFactory.InsertAlgoliaApplications(applicationsToInsert);
        test.stopTest();

        List<Lead> leadsAfterTrigger = AlgoliaTestFactory.GetLeadRecord(leadIds);
        system.assertEquals(leadsAfterTrigger.size(), 2);
        for(Lead lead : leadsAfterTrigger){
            system.assertEquals(lead.TotalRecords__c, mapsToAssert.Get(lead.Id).TotalRecords__c); // this proves the number of records correctly adds up (5+3)
            system.assertEquals(lead.TotalOperations__c, mapsToAssert.Get(lead.Id).TotalOperations__c); // this proves the highest operations record is populated
            system.assertEquals(lead.TotalApplications__c, 2); // this proves the total applications correctly adds up (2 application records per Lead)
        }
    }

    @isTest
    public static void TestUpdateAccountsAndLeads() {
        List<Lead> leads = AlgoliaTestFactory.InsertLeads(1);
        List<Account> accounts = AlgoliaTestFactory.InsertAccounts(1);
        Algolia_Application__c application1 = new Algolia_Application__c(Lead__c = leads[0].Id, NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Paying');
        Algolia_Application__c application2 = new Algolia_Application__c(Lead__c = leads[0].Id, NumberOfRecords__c = 3, NumberOfOperations__c = 4, CustomerType__c = 'Paying');
        Algolia_Application__c application3 = new Algolia_Application__c(Account__c = accounts[0].Id, NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Paying');
        Algolia_Application__c application4 = new Algolia_Application__c(Account__c = accounts[0].Id, NumberOfRecords__c = 3, NumberOfOperations__c = 4, CustomerType__c = 'Paying');
        List<Algolia_Application__c> applicationsToInsert = new List<Algolia_Application__c>{
            application1, application2, application3, application4
        };

        test.startTest();
        List<Algolia_Application__c> insertedApplications = AlgoliaTestFactory.InsertAlgoliaApplications(applicationsToInsert);
        test.stopTest();

        List<Id> leadIds = new List<Id>();
        for(Lead lead : leads){
            leadIds.Add(lead.Id);
        }

        List<Id> accountIds = new List<Id>();
        for(Account account : accounts){
            accountIds.Add(account.Id);
        }

        List<Lead> leadAfterTrigger = AlgoliaTestFactory.GetLeadRecord(leadIds);
        system.assertEquals(leadAfterTrigger.size(), 1);
        system.assertEquals(leadAfterTrigger[0].TotalRecords__c, 8); // this proves the number of records correctly adds up (5+3)
        system.assertEquals(leadAfterTrigger[0].TotalOperations__c, 4); // this proves the highest operations record is populated
        system.assertEquals(leadAfterTrigger[0].TotalApplications__c, 2); // this proves the total applications correctly adds up (2 application records)

        List<Account> accountAfterTrigger = AlgoliaTestFactory.GetAccountRecord(accountIds);
        system.assertEquals(accountAfterTrigger.size(), 1);
        system.assertEquals(accountAfterTrigger[0].TotalRecords__c, 8); // this proves the number of records correctly adds up (5+3)
        system.assertEquals(accountAfterTrigger[0].TotalOperations__c, 4); // this proves the highest operations record is populated
        system.assertEquals(accountAfterTrigger[0].TotalApplications__c, 2); // this proves the total applications correctly adds up (2 application records)
    }

    @isTest
    public static void TestWithNoRelatedAccontsAndLeads() {
        Algolia_Application__c application1 = new Algolia_Application__c(NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Paying');
        List<Algolia_Application__c> applicationsToInsert = new List<Algolia_Application__c>{
            application1
        };

        test.startTest();
        List<Algolia_Application__c> insertedApplications = AlgoliaTestFactory.InsertAlgoliaApplications(applicationsToInsert);
        test.stopTest();

        system.assertEquals(insertedApplications.Size(), 1); // this test is to prove Application record can be created without lead or Account.
    }

    @isTest
    public static void TestWithCustomerTypePaying() {
        List<Lead> leads = AlgoliaTestFactory.InsertLeads(1);
        List<Account> accounts = AlgoliaTestFactory.InsertAccounts(1);
        Algolia_Application__c application1 = new Algolia_Application__c(Lead__c = leads[0].Id, NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Paying');
        Algolia_Application__c application2 = new Algolia_Application__c(Lead__c = leads[0].Id, NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Vip');
        Algolia_Application__c application3 = new Algolia_Application__c(Account__c = accounts[0].Id, NumberOfRecords__c = 3, NumberOfOperations__c = 4, CustomerType__c = 'Paying');
        Algolia_Application__c application4 = new Algolia_Application__c(Account__c = accounts[0].Id, NumberOfRecords__c = 3, NumberOfOperations__c = 4, CustomerType__c = 'Vip');
        List<Algolia_Application__c> applicationsToInsert = new List<Algolia_Application__c>{
            application1, application2, application3, application4
        };

        test.startTest();
        List<Algolia_Application__c> insertedApplications = AlgoliaTestFactory.InsertAlgoliaApplications(applicationsToInsert);
        test.stopTest();

        List<Id> leadIds = new List<Id>();
        for(Lead lead : leads){
            leadIds.Add(lead.Id);
        }

        List<Id> accountIds = new List<Id>();
        for(Account account : accounts){
            accountIds.Add(account.Id);
        }

        List<Lead> leadAfterTrigger = AlgoliaTestFactory.GetLeadRecord(leadIds);
        system.assertEquals(leadAfterTrigger.size(), 1);
        system.assertEquals(leadAfterTrigger[0].LeadType__c, 'Paying'); // this proves LeadType is correctly populated 

        List<Account> accountAfterTrigger = AlgoliaTestFactory.GetAccountRecord(accountIds);
        system.assertEquals(accountAfterTrigger.size(), 1);
        system.assertEquals(accountAfterTrigger[0].AccountType__c, 'Paying'); // this proves LeadType is correctly populated
    }

    @isTest
    public static void TestWithCustomerTypeVipAndGuest() {
        List<Lead> leads = AlgoliaTestFactory.InsertLeads(1);
        List<Account> accounts = AlgoliaTestFactory.InsertAccounts(1);
        Algolia_Application__c application1 = new Algolia_Application__c(Lead__c = leads[0].Id, NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Guest');
        Algolia_Application__c application2 = new Algolia_Application__c(Lead__c = leads[0].Id, NumberOfRecords__c = 5, NumberOfOperations__c = 2, CustomerType__c = 'Vip');
        Algolia_Application__c application3 = new Algolia_Application__c(Account__c = accounts[0].Id, NumberOfRecords__c = 3, NumberOfOperations__c = 4, CustomerType__c = 'Guest');
        Algolia_Application__c application4 = new Algolia_Application__c(Account__c = accounts[0].Id, NumberOfRecords__c = 3, NumberOfOperations__c = 4, CustomerType__c = 'Vip');
        List<Algolia_Application__c> applicationsToInsert = new List<Algolia_Application__c>{
            application1, application2, application3, application4
        };

        test.startTest();
        List<Algolia_Application__c> insertedApplications = AlgoliaTestFactory.InsertAlgoliaApplications(applicationsToInsert);
        test.stopTest();

        List<Id> leadIds = new List<Id>();
        for(Lead lead : leads){
            leadIds.Add(lead.Id);
        }

        List<Id> accountIds = new List<Id>();
        for(Account account : accounts){
            accountIds.Add(account.Id);
        }

        List<Lead> leadAfterTrigger = AlgoliaTestFactory.GetLeadRecord(leadIds);
        system.assertEquals(leadAfterTrigger.size(), 1);
        system.assertEquals(leadAfterTrigger[0].LeadType__c, 'Free'); // this proves LeadType is correctly populated 

        List<Account> accountAfterTrigger = AlgoliaTestFactory.GetAccountRecord(accountIds);
        system.assertEquals(accountAfterTrigger.size(), 1);
        system.assertEquals(accountAfterTrigger[0].AccountType__c, 'Free'); // this proves LeadType is correctly populated
    }
}