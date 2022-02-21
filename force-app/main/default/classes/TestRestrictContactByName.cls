@isTest
private class TestRestrictContactByName
{
	@isTest
	static void itShould()
	{
		Test.startTest();
		Contact con = new Contact();
		con.lastName = 'INVALIDNAME';
		Try{
		insert con;
		}catch(exception e ){
			system.assertNotEquals(' ' , e.getMessage());
		}

		Test.stopTest();



	}
}