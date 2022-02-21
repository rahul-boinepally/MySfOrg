@isTest
public with sharing class AnimalLocatorTest {

    public static testmethod void AnimalLocatorTest () {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        string response = AnimalLocator.getAnimalNameById(1);
        // Verify that the response received contains fake values
    }
}