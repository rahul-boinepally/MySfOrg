public class WareHouseEmailController {
    
    private  Warehouse__c warehouse;
    public Integer myInteger;
    
    
    //constructor..no return types... 
    //Things to study:  "this" keyword, super, final, static 
    //
    //Constructor limitations ::: 
    //You cannot perform DML operations inside constructor..
    //
    //rerender in visualforce page... 
    public WareHouseEmailController(ApexPages.StandardController stdCon){
        this.warehouse = (Warehouse__c)stdCon.getRecord();
    }

public PageReference doAction(){
    //1)Send Email.. 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    //2) warehouse.someField__c = do this logic... 
    //
    //update warehouse;
    return null;
}


    
 
}