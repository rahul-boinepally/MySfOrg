public with sharing class AccountHandler 
{
	public static Account insertNewAccount(string accName) 
	{
		
		Account acc = new Account();
		acc.Name = accName;
		system.debug('test');
		try{
		insert acc;
		} 
		catch(exception e)
		{
			system.debug('invalid name');
			return null;
		}


		return acc;
	}
}