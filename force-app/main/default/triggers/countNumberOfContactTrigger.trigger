/* Count the Contacts in the related list of Account and display the Contact count on Account Custom Field */

Trigger countNumberOfContactTrigger on contact(after insert, after update, after delete , after undelete){
    Set<Id> accid = new Set<Id>();
    if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete)){
        for(Contact con : trigger.newMap.values()){
            if(con.AccountId != null){
                accid.add(con.AccountId);
            }
        }
    }
    //for update and Delete
    if(trigger.isAfter && (trigger.isUpdate || trigger.isDelete)){
        for(contact con : trigger.oldMap.values()){
            if(con.AccountId != null){
                accid.add(con.AccountId);
            }
        }
    }
    //count number of contact for that i am using Aggregate query 
    List<Account> acclist = new List<Account>();
    List<AggregateResult> AggregateResultList = [Select AccountId, count(Id) totalNumberOfContacts from contact where AccountId IN :accid group by AccountId];
    if(AggregateResultList != null){
        for(AggregateResult arrResult : AggregateResultList){
            Integer totalNumberOfContacts = (Integer)arrResult.get('totalNumberOfContacts');
            String accountId = (String)arrResult.get('AccountId');
            Account acc = new Account();
            acc.Id = accountId;
            acc.Number_Of_Contacts__c = totalNumberOfContacts;
            acclist.add(acc);
        }
    }
    if(!acclist.isEmpty()){
        update acclist;
    }
    
}