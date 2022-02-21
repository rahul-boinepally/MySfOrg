public with sharing class ContactAndLeadSearch {
	public static List<List<sObject>> searchContactsAndLeads(string name) {

		Contact con = new Contact(LastName = 'Smith');		
		Try{
		insert con;
		system.debug('con'+con);
		}catch(exception e){
			system.debug(e);
		}


		Lead ld = new Lead();
		ld.LastName = 'Smith';
		ld.Company = 'test';


		try{
		insert ld;
		}catch(exception e){
			system.debug(e);
		}

		List<List<sObject>> result = [Find :name Returning Contact(FirstName, LastName) , Lead(FirstName, LastName)];
		return result; 
		
	}
}