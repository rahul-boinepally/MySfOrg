public with sharing class AlgoliaHelper {

    // this method takes recordId and 
    @AuraEnabled(cacheable=true)
    public static List<sObject> getRecords(Id recordId, List<string> fieldNames){
        Schema.DescribeSObjectResult dsr = recordId.getSObjectType().getDescribe(); 
        String objectName = dsr.getName();
        Map<String, Schema.SObjectField> objectFields = dsr.fields.getMap();

        Set<string> fieldNamesToSearch = new Set<string>();
        for(string field : fieldNames){
            if(objectFields.ContainsKey(field.trim().toLowerCase())){
                fieldNamesToSearch.add(field);
            }
        }

        if(fieldNamesToSearch.isEmpty()){
            return null;
        }

        fieldNamesToSearch.add('Id');
        
        List<string> fieldNamesToSearchList = new List<string>(fieldNamesToSearch);

        // we should not see soql injection attacks here as we check if field names and maps are valid above.
        List<sObject> response = Database.query('SELECT ' + string.join(fieldNamesToSearchList,',') +  ' FROM ' + objectName + ' WHERE Id = :recordId ');
        return response;
    }
}