public with sharing class AlgoloaHelper {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getRecords(Id recordId, List<string> fieldNames){
        Schema.DescribeSObjectResult dsr = recordId.getSObjectType().getDescribe(); 
        String objectName = dsr.getName();
        Map<String, Schema.SObjectField> objectFields = dsr.fields.getMap();

        List<string> fieldNamesToSearch = new List<string>();
        for(string field : fieldNames){
            if(objectFields.ContainsKey(field)){
                fieldNamesToSearch.Add(field);
            }
        }

        if(fieldNamesToSearch.IsEmpty()){
            return null;
        }

        // we should not see soql injection attacks here as we check if field names and maps are valid above.
        List<sObject> response = Database.query('SELECT ' + string.join(fieldNamesToSearch,',') +  ' FROM ' + objectName + ' WHERE Id = :recordId');
        return response;
    }
}