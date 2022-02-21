public class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext  ctx){
        List<Lead> leads = [select Id, LeadSource from lead where LeadSource = null limit 200];
        List<Lead> lUpdates = new List<Lead>();
        for(Lead l : leads){
            l.LeadSource = 'Dreamforce';
            lUpdates.add(l);
        }
        update lUpdates;
    }
}