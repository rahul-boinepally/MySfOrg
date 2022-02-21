@isTest
public class AddPrimaryContactTest {
    @isTest
    public static void test1(){
        List<Account> acc = new List<Account>();
        for(integer i =0; i<100; i++){
        	Account accn = new Account(name = 'test' + i);
            if(i<50)
                accn.BillingState = 'CA';
            else if (i>= 50)
                accn.BillingState = 'NY';
        	acc.add(accn);
        }
        insert acc;
        Contact con = new Contact();
        AddPrimaryContact add = new AddPrimaryContact(con, 'CA');
        test.startTest();
        system.enqueueJob(add);
        test.stopTest();
        system.assertEquals(50, [select count() from Contact where AccountId in (Select Id from Account where BillingState = 'CA')]);
        
    }
}