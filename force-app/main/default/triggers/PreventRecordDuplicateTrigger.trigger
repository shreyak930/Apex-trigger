//When user tries to insert Account with name which already used in another existing account ,User should be presented with Error.

trigger PreventRecordDuplicateTrigger on Account (before insert, before update) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        Map <String , Account> mapAccountName = new Map<String , Account>();
        List<Account> existingAccList = [select Id,Name from Account Limit 5000 ];
        for(Account acc : existingAccList){
            if(acc.Name != null){
                mapAccountName.put(acc.Name , acc);
            }
        }
        
        for(Account acc : trigger.new){
            if(mapAccountName.containsKey(acc.Name)){
                acc.Name.addError('Account already exists with this name');
            }
        }
    }
}