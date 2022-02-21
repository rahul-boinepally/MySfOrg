public class MerchandiseOperation {
    public static Id Invoice(String pName, Integer pSold,String pDesc) {
        
        Merchandise__c m = [select price__C,total_inventory__C from merchandise__C where name = :pName Limit 1];
        system.assertNotEquals(null , m);
        Invoice_statement__C i = new Invoice_statement__C(Description__c = pDesc);
        Insert i;   
        return i.Id; 
    }
    
}