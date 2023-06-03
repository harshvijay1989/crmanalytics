public class ContactTriggerHelper {
    Public static void beforeInsert(List<Contact> contactList){
        System.debug('Jill');
        List<Contact> conList = new List<Contact>();
        for (Contact conObj : contactList){
            if (conObj.Email != null){
                conList.add(conObj);
            }
        }
        If(!conList.IsEmpty()){
             List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
            EmailTemplate templateId = [select Id, Name FROM EmailTemplate where Name ='Contact Acknowledgement Mail'];
            for(Contact coObj : conList){ 
                if(CoObj.Email != null ){
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.toAddresses = new String[] {coObj.Email};
                        message.setTreatTargetObjectAsRecipient(false);
                    message.setTargetObjectId(coObj.id);
                    message.setTemplateID(templateId.Id);
                    mails.add(message);
                }
            }
            If(!mails.isEmpty()){
                Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
            }
        }
    }
    
    Public static void duplicateContact(List<Contact> contactList){
        System.debug('Jack');
        Map<Id,String> conMapEmail = new Map<Id,String>();
        Map<Id,String> conMapPhone = new Map<Id,String>();
        for (Contact conObj : contactList){
            if(conObj.Email != null){
                system.debug('Test_1'+conObj.Email);
                conMapEmail.put(conObj.Id,conObj.Email);
            }
            If(conObj.Phone != null){
                system.debug('Test_1'+conObj.Phone);
                conMapPhone.put(conObj.Id, conObj.Phone);
            }
        }
        System.debug('Emails '+conMapEmail.Values());
        if(!conMapEmail.isEmpty() && !conMapPhone.isEmpty()){
            Map<Id,Contact> conMap = new Map<Id,Contact>([Select id from contact where Email in :conMapEmail.values() or Phone in :conMapPhone.values()]);
            system.debug('Test_1'+conMap.Values());
            for (Contact conObj : contactList){
                if(conMap.containsKey(conObj.Id)){
                    conObj.addError('Contact already Exists');
                }
            }
        }else if (!conMapEmail.isEmpty()){
            Map<Id,Contact> conMap = new Map<Id,Contact>([Select id from contact where Email in :conMapEmail.values()]);
            for (Contact conObj : contactList){
                if(conMap.containsKey(conObj.Id)){
                    conObj.addError('Contact already Exists');
                }
            }
        }else if (!conMapPhone.isEmpty()){
            Map<Id,Contact> conMap = new Map<Id,Contact>([Select id from contact where Phone in :conMapPhone.values()]);
            for (Contact conObj : contactList){
                if(conMap.containsKey(conObj.Id)){
                    conObj.addError('Contact already Exists');
                }
            }
        }
    }
}