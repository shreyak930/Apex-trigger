//When ever a case is created with origin as email then set status as new and Priority as Medium.

trigger SetCaseDefaults on Case (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        for(Case cs : trigger.new){
            if(cs.Origin == 'Email'){
                cs.Status = 'New';
                cs.Priority = 'Medium';
            }      
        }
    }
}