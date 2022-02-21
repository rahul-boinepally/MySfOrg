public class Test601bController {
    
    @AuraEnabled
    public static List<Account> getAll(){
        List<Account> acc = [select id, name from Account limit 10];
        return acc;
    }

}