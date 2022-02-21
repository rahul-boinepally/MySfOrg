public with sharing class ContactSearch {
	public static List<Contact> searchForContacts(string lastName, string postCode) 
	{
		List<Contact> con = [Select Id, Name from Contact c where (c.lastName = :lastName AND c.MailingPostalCode = :postCode)];
		return con;	

	}
}