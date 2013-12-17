/*
Author: Eamon Kelly, Enclude
Purpose: Create an org related to this contact - allows the non profit pack org to remain with the one to one model
Called from: Trigger
*/
trigger CreateRelatedOrgOnContactTrigger on Contact (before insert) 
{
	for(Contact c : Trigger.new)
    {
    	if (isValid (c.Related_Organisation_Name__c))
    	{
    		Account relatedAccount=null;
	    	try
    		{
    			relatedAccount = [select id from Account where Name=:c.Related_Organisation_Name__c limit 1];
    		}
    		catch (Exception e)
    		{
    			// assuming this is a account not found exception, so create a new one
    			relatedAccount = new Account(Name=c.Related_Organisation_Name__c);
    			insert relatedAccount;
    		}
    		c.Related_Organisation__c = relatedAccount.id;
    		update relatedAccount;
    	}
    }

	public static boolean isValid (String text)
	{
		if (text <> null && text <> '' && text <> '[not provided]') return true;
		else return false;
	}
}