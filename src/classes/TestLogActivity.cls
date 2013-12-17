/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestLogActivity 
{
    static testMethod void TestTask() 
    {
    	Contact volunteer = new Contact (FirstName='Fred', LastName='Volunteer', Email='someone@somewhere.com', Related_Organisation_Name__c='Test org23');
    	insert volunteer;

    	Task createdTask = new Task (Subject='Call', WhoID=volunteer.Id);
    	insert createdTask;
    	
     	Contact updatedContact = [select ID, Date_of_last_call__c from Contact where ID=:volunteer.id limit 1];
    	System.AssertEquals (updatedContact.Date_of_last_call__c, system.today());
    }

	static testMethod void TestEvent() 
    {
    	Contact volunteer = new Contact (FirstName='Fred', LastName='Volunteer', Email='someone@somewhere.com', Related_Organisation_Name__c='Test org23');
    	insert volunteer;

    	Event createdEvent = new Event (Subject='Call', WhoID=volunteer.Id, DurationInMinutes=60, StartDateTime=system.now());
    	insert createdEvent;
    	
     	Contact updatedContact = [select ID, Date_of_last_call__c from Contact where ID=:volunteer.id limit 1];
    	System.AssertEquals (updatedContact.Date_of_last_call__c, system.today());
    }
}