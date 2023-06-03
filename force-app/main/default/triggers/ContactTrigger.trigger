trigger ContactTrigger on Contact (After insert,before insert) {
    if (trigger.isInsert && trigger.isAfter){
        System.debug('Join');
        ContactTriggerHelper.beforeInsert(trigger.new);
    }
    if (trigger.isInsert && trigger.isBefore){
        System.debug('Hi');
        ContactTriggerHelper.duplicateContact(trigger.new);
    }
}