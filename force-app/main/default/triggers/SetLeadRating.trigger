//When ever Lead is created with LeadSource as Web then give rating as cold otherwise hot.
trigger SetLeadRating on Lead (before insert) {
if(trigger.isAfter && trigger.isInsert){
    for(Lead ld : trigger.new){
        if(ld.LeadSource == 'Web'){
            ld.Rating = 'Cold';
        }else{
            ld.Rating = 'Hot';
        }
    }
}
}
