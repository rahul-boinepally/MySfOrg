public with sharing class CreateContactFromCan {
	
	public void createContact(List<Candidate__C> candsFromTrigger) {
		
		// Account candAcct = [select a.id from Account a where a.Name='Recruiting' ];
		
		list<Contact> conList = new list<Contact>();

		for (Candidate__C currentCandidate : candsFromTrigger)
		{
		Contact con = new Contact();
	//*	con.AccountId = candAcct.Id;
		con.FirstName = currentCandidate.First_Name__c;
		con.LastName = currentCandidate.Last_Name__c;
		con.Email = currentCandidate.Email__c;
	
		conList.add(con);

		}		

Database.insert(conList);
		
	}
	
}