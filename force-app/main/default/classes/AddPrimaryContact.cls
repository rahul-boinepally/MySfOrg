public class AddPrimaryContact implements Queueable {

    public Contact contacts;
    Public string abbrv;
    
    public AddPrimaryContact(Contact recs, string abbr){
        this.contacts = recs;
        this.abbrv = abbr;
        
    }
    public void execute (QueueableContext context ){
        integer i = 0;
        List<Contact> cons = new List<Contact>();
        for(Account acc : [select id from Account where BillingState = :abbrv limit 200]){
            
            Contact con = new Contact(LastName = 'test' + i, AccountId = acc.Id);
            cons.add(con);
            i++;
        }
        if(cons.size() > 0){
            insert cons;
        }        
    } 
}