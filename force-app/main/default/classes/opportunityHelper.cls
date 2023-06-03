public class opportunityHelper {
    public static void beforeUpdate(List<Opportunity> oppList, Map<Id,Opportunity> newMap, Map<Id,Opportunity> oldMap){
        Set<Id> oppId = new Set<Id>();
        for(Opportunity oppObj : oppList){
            if (oldMap.get(oppObj.Id).StageName != 'Signature' && newMap.get(oppObj.Id).StageName == 'Signature'){
                oppId.add(oppObj.Id);
            }
        }
        List<Krow_Project__c> krwList = new List<Krow_Project__c>();
        for (Id key : oppId){
            Krow_Project__c kpObj = new Krow_Project__c();
            kpObj.Opportunity__c = key;
            kpObj.Onboarding_Type__c = 'Customer Onboarding';
            krwList.add(kpObj);
        }
        if(!krwList.isEmpty()){
            insert krwList;
        }
    }
}