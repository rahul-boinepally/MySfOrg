public class LeadProcessor implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        List<Lead> leads = [select Id, name from Lead];
        return Database.getQueryLocator('Select Id, LeadSource from Lead');
    }
    public void execute(Database.BatchableContext bc, List<Lead> leads){
        List<Lead> lUpdate = new List<Lead>();
        for(Lead ls : leads){
            ls.LeadSource = 'Dreamforce';
            lUpdate.add(ls);
        }
        if(lUpdate.size() > 0){
            update lUpdate;
        }
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
    
}