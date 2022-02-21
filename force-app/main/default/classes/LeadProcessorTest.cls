@isTest
public class LeadProcessorTest {
	@isTest
    public static void test1(){
        List<Lead> ld = new List<Lead>();
        for(integer i=0; i <200; i ++){
            ld.add(New Lead(LastName = 'Test' + i, Company = 'Test' + i));
        }
        insert ld;
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        List<Lead> l =  [Select LeadSource from Lead where Id in :ld limit 1];
        string ss = l[0].LeadSource;
        system.assertEquals('Dreamforce',ss);
        
    }
    
    
}