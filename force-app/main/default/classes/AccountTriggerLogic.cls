public class AccountTriggerLogic {
    public static void ProcessAfterAccountLogic(Id accountId){
        
    }
    
    public static void ProcessBeforeAccountLogic(List<Account> accounts){
        ProcessSMS(accounts);
    }
    
    private static void ProcessSMS(List<Account> accounts){
        Phone_number_to_sms__mdt phoneNumber = [Select Phone__c from Phone_number_to_sms__mdt where MasterLabel = 'CEO'];
        for(Account account : accounts){
            // we check if Account's category is either updated to Gold or if it is newly created with status Gold. 
            // If yes, we need to send an sms to CEO. 
            if(account.Customer_Category__c == 'Gold'){
                Account oldAccount = (Account) trigger.oldMap.Get(account.Id);
                if(trigger.IsUpdate && oldAccount.Customer_Category__c != 'Gold'){                
                    SendSmsFromTwilio.SendSms(account.Id, phoneNumber.Phone__c, account.Name);	        
                }
                else{
                    SendSmsFromTwilio.SendSms(account.Id, phoneNumber.Phone__c, account.Name);
                }
        	}
        }
    }
}