/* whenever Account Phone Number Filed is updated then update the Associated Contact Phone Number */

trigger updatephoneNumberAssociateWithAccount on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Set<Id> accid = new Set<Id>();
        for(Account acc : trigger.new){
          Account  oldAccount = trigger.oldMap.get(acc.Id);
            if(acc.phone != oldAccount.phone){
                accid.add(acc.Id);
            }
        }
    // Now querying the Contact and Update the Contact phone Number with Account Phone Number;
       List<contact> updateConlist = new List<contact>();
       List<Contact> conlist = [Select Id, phone , Account.phone, AccountId from contact where AccountId IN :accid];
       if(!conlist.isEmpty()){
          for(Contact con : conlist){
             con.phone = con.Account.phone;
             updateConlist.add(con);
          }
       }
        if(!updateConlist.isEmpty()){
            update updateConlist;
        }
    }
}