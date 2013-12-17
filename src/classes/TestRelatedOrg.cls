@isTest
private class TestRelatedOrg 
{
    static testMethod void CreateAccountOnRelatedOrgTest()
    {
    	Contact volunteer = new Contact (FirstName='Fred', LastName='Volunteer', Email='someone@somewhere.com', Related_Organisation_Name__c='Test org23');
    	insert volunteer;
    	
    	Account orgCreated = [select id, Name from Account where Name='Test org23' limit 1];
    	volunteer = [select id, Related_Organisation__c from Contact where id=:volunteer.id limit 1];
    	
    	System.AssertEquals (volunteer.Related_Organisation__c, orgCreated.Id);
    }
}