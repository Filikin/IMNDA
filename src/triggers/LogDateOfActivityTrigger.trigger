/*
Author: Eamon Kelly, Enclude
Purpose: If a task if created with email, letter or home visit in the subject, update the corresponding field on the contact
Called from: Trigger
*/
trigger LogDateOfActivityTrigger on Task (before insert) 
{
	List<Task> TaskList = new List<Task>();
    Map<Id, Task> mapTasks = new Map<Id, Task>();
    Set<Id> whoIds = new Set<Id>();

    for(Task t : Trigger.new)
    {
        if (t.WhoId != null)
        {
	        //Add the task to the Map and Set
            mapTasks.put(t.WhoId, t);
            whoIds.add(t.WhoId);
        }
    }
    
    List<Contact> people = [select Id, Date_of_last_call__c, Date_of_last_email__c, Date_of_last_letter__c from Contact where ID in :whoIDs];
    for (Contact person: people)
    {
    	Task tsk = mapTasks.get(person.Id);
	    if (tsk.Subject.toLowerCase().contains ('call')) person.Date_of_last_call__c=system.today();
	    else if (tsk.Subject.toLowerCase().Contains('email')) person.Date_of_last_email__c = system.today();
	    else if (tsk.Subject.toLowerCase().Contains('letter') || tsk.Subject.toLowerCase().Contains('mail merge')) person.Date_of_last_letter__c = system.today();
    }
    update people;

}