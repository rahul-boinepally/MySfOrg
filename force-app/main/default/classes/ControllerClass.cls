public with sharing class ControllerClass {
	public List<Contact> getContacts() {

		List<Contact> con = [select FirstName, LastName, Email from Contact limit 10];
		return con;
		
	}
}