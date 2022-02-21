@isTest
public class DailyLeadProcessorTest {
    public static String sch = '00 57 21 10 3 ? ';

    @isTest
    public static void test1(){
        List<Lead> leads = new List<Lead>();
        for(integer i=0; i<200; i++){
            Lead l = new Lead(LastName = 'test'+i, Company = 'test'+i);
            leads.add(l);
        }
        insert leads;
        
        Test.startTest();
        string jobId = system.schedule('job1', sch, new DailyLeadProcessor());
        Test.stopTest();
        system.assertEquals(200, [Select COUNT() from Lead where LeadSource = 'Dreamforce']);
    }
    
}