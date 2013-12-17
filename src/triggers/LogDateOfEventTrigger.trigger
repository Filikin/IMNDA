trigger LogDateOfEventTrigger on Event (before insert) 
{
	List<Event> EventList = new List<Event>();
    Map<Id, Event> mapEvents = new Map<Id, Event>();
    Set<Id> whoIds = new Set<Id>();

    for(Event t : Trigger.new)
    {
        if (t.WhoId != null)
        {
	        //Add the Event to the Map and Set
            mapEvents.put(t.WhoId, t);
            whoIds.add(t.WhoId);
        }
    }
    
    List<Contact> people = [select Id, Date_of_Last_Home_Visit__c, Date_of_last_call__c, Date_of_last_email__c, Date_of_last_letter__c from Contact where ID in :whoIDs];
    for (Contact person: people)
    {
    	Event evt = mapEvents.get(person.Id);
	    if (evt.Subject.toLowerCase().contains ('call')) person.Date_of_last_call__c=system.today();
	    else if (evt.Subject.toLowerCase().Contains('email')) person.Date_of_last_email__c = system.today();
	    else if (evt.Subject.toLowerCase().Contains('letter')) person.Date_of_last_letter__c = system.today();
	    else if (evt.Subject.toLowerCase().Contains('home visit')) person.Date_of_Last_Home_Visit__c = evt.StartDateTime.Date();
    }
    update people;
}