//Write a trigger on the Opportunity line item when a line item deletes delete an opportunity as well.

trigger DeleteOppUpdateOnOppLineItem on OpportunityLineItem (after delete) {
    if(trigger.isAfter && trigger.isDelete){
        Set<Id> oppLineItem = New Set<Id>();
        for(OpportunityLineItem olt : trigger.old){
            oppLineItem.add(olt.OpportunityId);
        }

        List<Opportunity> oppList = [Select Id  From Opportunity Where Id In :oppLineItem];
        if(!oppList.isEmpty()){
            Delete oppList;
        }
    }

}