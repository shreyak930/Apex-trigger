//Write a trigger, if the owner of an account is changed then the owner for the 
//related contacts should also be updated.

trigger AccountTrigger on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        Set<Id> accid = New Set<Id>();
        for(Account acc : trigger.new){
            if(acc.OwnerId != null && acc.OwnerId != trigger.oldMap.get(acc.id).OwnerId){
                accid.add(acc.id); 
            }
        }
        List<contact> updateContactList = New List<contact>();
        List<contact> conlist = [Select Id, AccountId, OwnerId From Contact where AccountId In :accid];
        if(!conlist.isEmpty()){
            for(Contact con : conlist){
                con.OwnerId = trigger.newMap.get(con.AccountId).OwnerId;
                updateContactList.add(con);
            }
        } 
        update updateContactList;
    }

}