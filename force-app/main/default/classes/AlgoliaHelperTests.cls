@isTest
public with sharing class AlgoliaHelperTests {
    @isTest
    public static void TestGetRecordsWithCorrectFields() {
        List<Account> accountInserted = AlgoliaTestFactory.InsertAccounts(1);
        Test.startTest();
        List<sObject> response = AlgoliaHelper.getRecords(accountInserted[0].Id, new List<string>{'Id', 'OwnerId'});
        Test.stopTest();

        System.assertEquals(response.Size(), 1);
        Account accResponse = (Account) response[0];
        System.assertEquals(accResponse.Id, accountInserted[0].Id);
        System.assertNotEquals(accResponse.OwnerId, null);
    }

    @isTest
    public static void TestGetRecordsWithFewInCorrectFields() {
        List<Account> accountInserted = AlgoliaTestFactory.InsertAccounts(1);
        Test.startTest();
        List<sObject> response = AlgoliaHelper.getRecords(accountInserted[0].Id, new List<string>{'Id', 'Test'});
        Test.stopTest();
        
        System.assertEquals(response.Size(), 1);
        Account accResponse = (Account) response[0];
        System.assertEquals(accResponse.Id, accountInserted[0].Id);
    }

    @isTest
    public static void TestGetRecordsWithAllInCorrectFields() {
        List<Account> accountInserted = AlgoliaTestFactory.InsertAccounts(1);
        Test.startTest();
        List<sObject> response = AlgoliaHelper.getRecords(accountInserted[0].Id, new List<string>{'Test', 'Test22'});
        Test.stopTest();
        
        System.assertEquals(response, null);
    }
}