trigger OpportunityTrigger on Opportunity (after update) {
    if (trigger.isAfter && trigger.isUpdate){
        opportunityHelper.beforeUpdate(trigger.new, trigger.newMap, trigger.oldMap);
    }
}