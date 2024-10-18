//To update the Account Owner when the Contact Owner changes 

trigger UpdateAccountOwnerOnContactOwnerChange on Contact (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Map<Id , Id> contactToNewOwnerMap = new Map <Id ,Id>();
        for(Contact con :trigger.new){
                if(con.OwnerId != null && con.OwnerId != trigger.oldmap.get(con.id).OwnerId){
                    contactToNewOwnerMap.put(con.AccountId ,con.OwnerId);
                }
        }
        List<Account> updateAcclist = new List<Account>();
        //Querying the Account related to contact 
        List<Account> acclist = [select Id, OwnerId from Account where Id IN :contactToNewOwnerMap.keySet()];
        if(!acclist.isEmpty()){
            for(Account acc : acclist){
                if(contactToNewOwnerMap.get(acc.id) != null){
                    acc.OwnerId = contactToNewOwnerMap.get(acc.id);
                    updateAcclist.add(acc);
                }
            }
        }
        if(!updateAcclist.isEmpty()){
            update updateAcclist;
        }
    }
    
}