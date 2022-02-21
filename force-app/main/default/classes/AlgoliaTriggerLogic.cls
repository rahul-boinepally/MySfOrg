public with sharing class AlgoliaTriggerLogic {
    Map<Id, Account> accountToUpdateMap = new Map<Id, Account>();
    Map<Id, Lead> leadtoUpdateMap = new Map<Id, Lead>();

    public void ProcessAfterLogic(List<Algolia_Application__c> records){
        for(Algolia_Application__c record : records){

            if(record.Account__c != null){
                accountToUpdateMap.Put(record.Account__c, new Account(Id = record.Account__c, TotalRecords__c = 0, TotalOperations__c = 0, TotalApplications__c = 0));
            }

            if(record.Lead__c != null){
                leadtoUpdateMap.Put(record.Lead__c, new Lead(Id = record.Lead__c, TotalRecords__c = 0, TotalOperations__c = 0, TotalApplications__c = 0));
            }
        }

        if(!accountToUpdateMap.IsEmpty()){
            ProcessAccontUpdates(accountToUpdateMap.KeySet());
        }

        if(!leadtoUpdateMap.IsEmpty()){
            ProcessLeadUpdates(leadtoUpdateMap.KeySet());
        }
    }

    private void ProcessAccontUpdates(Set<Id> accountIds){
        Integer numberOfApplications = 1;
        Id oldAccountId;
        Decimal highestOperationsValue = 0;

        for(Algolia_Application__c algoliaRecord : [Select Account__c, NumberOfRecords__c, NumberOfOperations__c, CustomerType__c from Algolia_Application__c where Account__c In :accountIds]){                
            // TotalApplications__c on the Account object should be the total related records of Algolia_Application__c
            // so maintain an counter for the Account record and on change of account reset the counter back to 1.  
            if(oldAccountId != null && oldAccountId != algoliaRecord.Account__c){                
                numberOfApplications = 1;
                highestOperationsValue = 0; // reset this value so it will be recalculated for next Account
            }
            
            // TotalOperations__c should be highest value of related NumberOfOperations__c.
            if(highestOperationsValue < algoliaRecord.NumberOfOperations__c){
                highestOperationsValue = algoliaRecord.NumberOfOperations__c;
            }

            // the AccountType__c field is by default set to `Free`. If Any CustomerType__c is set to Paying then AccountType will be set to Paying
            if(algoliaRecord.CustomerType__c == 'Paying'){
                accountToUpdateMap.Get(algoliaRecord.Account__c).AccountType__c = 'Paying';         
            }

            accountToUpdateMap.Get(algoliaRecord.Account__c).TotalRecords__c += algoliaRecord.NumberOfRecords__c;
            accountToUpdateMap.Get(algoliaRecord.Account__c).TotalOperations__c = highestOperationsValue;
            accountToUpdateMap.Get(algoliaRecord.Account__c).TotalApplications__c += numberOfApplications;
            oldAccountId = algoliaRecord.Account__c;
        }

        update accountToUpdateMap.Values();
    }

    private void ProcessLeadUpdates(Set<Id> leadIds){
        Integer numberOfApplications = 1;
        Id oldLeadId;
        Decimal highestOperationsValue = 0;

        for(Algolia_Application__c algoliaRecord : [Select Lead__c, NumberOfRecords__c, NumberOfOperations__c, CustomerType__c from Algolia_Application__c where Lead__c In :leadIds]){
            // TotalApplications__c on the Lead object should be the total related records of Algolia_Application__c
            // so maintain an counter for the Lead record and on change of lead reset the counter back to 1.
            if(oldLeadId != null && oldLeadId != algoliaRecord.Lead__c){
                numberOfApplications = 1;
                highestOperationsValue = 0;
            }
            
            // TotalOperations__c should be highest value of related NumberOfOperations__c.
            if(highestOperationsValue < algoliaRecord.NumberOfOperations__c){
                highestOperationsValue = algoliaRecord.NumberOfOperations__c;
            }

            // the LeadType__c field is by default set to `Free`. If Any CustomerType__c is set to Paying then LeadType will be set to Paying
            if(algoliaRecord.CustomerType__c == 'Paying'){
                leadtoUpdateMap.Get(algoliaRecord.Lead__c).LeadType__c = 'Paying';        
            }

            leadtoUpdateMap.Get(algoliaRecord.Lead__c).TotalRecords__c += algoliaRecord.NumberOfRecords__c;
            leadtoUpdateMap.Get(algoliaRecord.Lead__c).TotalOperations__c = highestOperationsValue;
            leadtoUpdateMap.Get(algoliaRecord.Lead__c).TotalApplications__c += numberOfApplications;
            oldLeadId = algoliaRecord.Lead__c;
        }

        update leadtoUpdateMap.Values();
    }
}