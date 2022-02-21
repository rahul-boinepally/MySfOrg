public class SendSmsFromTwilio {
    public static void SendSms(id ccid, string phoneNumber, string accountName) {
        string smsBody = 'Hello, we have a new Gold customer :' + accountName;
        SendSms(smsBody, phoneNumber);
    }

    @AuraEnabled(cacheable=true)
    public static void SendSms(id recordId, string smsBody){
        Contact c = [Select MobilePhone from Contact where Id = :recordId Limit 1];
        SendSms(smsBody, c.MobilePhone);
    }

    @future (callout=true)
    public static void SendSms(string smsBody, string phoneNumberTo){
        Twilio_Accounts__mdt twilioAccount = [Select AccountSid__c, FromPhone__c,Token__c from Twilio_Accounts__mdt where MasterLabel = 'DemoAccount' limit 1];
        
        System.debug('@@ mdt' + twilioAccount);
        System.debug('@@ mdt' + twilioAccount.AccountSid__c);
        System.debug('@@ mdt' + twilioAccount.Token__c);
        System.debug('@@ mdt' + twilioAccount.FromPhone__c);

        string accountSid = twilioAccount.AccountSid__c; 
        string token = twilioAccount.Token__c; 
        string twilioPhone = twilioAccount.FromPhone__c;
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json'); 
        req.setMethod('POST');
        String VERSION  = '3.2.0';
        req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        req.setHeader('Accept', 'application/json');
        req.setHeader('Accept-Charset', 'utf-8');
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));
        req.setBody('To='+EncodingUtil.urlEncode(phoneNumberTo,'UTF-8')+'&From='+EncodingUtil.urlEncode(twilioPhone,'UTF-8')+'&Body='+smsBody);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('@@response' + res);
    }
}