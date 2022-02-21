/**
* ==========================================================================
* 
* @className        InvoiceDetailsExtension
* @version          V0.1
* @function         Extension class to create new Invoice from InvoiceDetails VF page.      
* @objects          Invoice__c
* ==========================================================================*/

public with sharing class InvoiceDetailsExtension {

    private final Invoice__c mysObject;
    public List<Invoice__c> invoiceList {get; set;}
    public decimal invoiceTotal {get; set;}
    
    public InvoiceDetailsExtension(ApexPages.StandardController stdController) 
    {
        invoiceList = [select id, name,Amount__c,Customer__c,Invoice_Description__c,Invoice_Status__c,Invoice_Date__c from Invoice__c order By name];
        invoiceTotal = 0; 
        for(Invoice__c inv : invoiceList)
        {
            system.debug('@@inv'+inv.amount__c);
            system.debug('@@inv'+inv);
            if(inv.Amount__c != null)
                invoiceTotal = invoiceTotal + inv.Amount__c;
        }
    }
        
    public PageReference newInvoice()
    {
        PageReference page = new PageReference('/apex/CreateNewInvoice');
        string retURL = '/apex/InvoiceDetails';
        page.getParameters();
        page.getParameters().put('retURL',retURL);
        return page;
    }    
}