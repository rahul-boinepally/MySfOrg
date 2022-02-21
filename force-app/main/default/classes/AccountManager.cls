@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
       
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        
        String accountId = request.requestURI.substringBetween('Accounts/','/contacts');
        List<Account> result =  [SELECT Id, Name ,(Select Id, Name from Contacts)
                        FROM Account
                        WHERE Id = :accountId];
        return result[0];
    }
}