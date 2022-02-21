@isTest
private class TestVerifyDate
{
	@isTest
	static void dateCheck1()
	{
		Date date1 = date.newInstance(2016,01,01);
		Date date2 = date.newInstance(2016,02,08);
		Date check1 = VerifyDate.CheckDates(date1, date2);
		Date date30 = date1.addDays(30);
		system.assertEquals(date30, check1);


	}

	@isTest
	static void dateCheck2()
	{
		Date date1 = date.newInstance(2016,01,01);
		Date date2 = date.newInstance(2016,01,02);
		Date check1 = VerifyDate.CheckDates(date1, date2);
		system.assertEquals(date2, check1);


	}
}