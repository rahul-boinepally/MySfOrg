/**
* ==========================================================================
* 
* @className        NewInvoiceExtension
* @version          V0.1
* @function         Extension class to create new Invoice from CreateNewInvoice VF page.
*        
* @objects          None
* ==========================================================================
*/
public with sharing class NewInvoiceExtension {
    public Invoice__c newInvoice {get;set;}

    private final sObject mysObject;

    public NewInvoiceExtension(ApexPages.StandardController stdController) {

    }
    
    public PageReference cancel()
    {
        PageReference pg = new PageReference('/apex/InvoiceDetails');
        return pg;
        
    }
}