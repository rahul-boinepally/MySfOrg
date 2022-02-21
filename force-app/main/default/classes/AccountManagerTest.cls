@isTest
public class AccountManagerTest {
	@isTest static void testGetAccountById() {
        Account acc = new Account(Name = 'test');
        insert acc;
        Contact con = new Contact(firstName = '1', lastName = '2', AccountId = acc.Id);
        Insert con;
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://rahulbsai-dev-ed.lightning.force.com/services/apexrest/Accounts/'
            + acc.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAcc = AccountManager.getAccount();
        // Verify results
        System.assert(thisAcc != null);
    }

}