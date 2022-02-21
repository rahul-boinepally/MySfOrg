@IsTest
private  class TrilioSmsTest {
  @IsTest
  private static void testSendSms() {
    // Set mock callout class 
    Test.setMock(HttpCalloutMock.class, new TrilioSmsMock());
    Account a = new Account(Id=TestUtility.getFakeId(Account.SObjectType));
    Test.startTest();
    SendSmsFromTwilio.SendSms(a.Id, '+4412345677', 'MyAccount1');
    Test.stopTest();
  }
}