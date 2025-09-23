// SCRUM-21: Trigger to delegate logic to handler
trigger AssetTrigger on Asset__c (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        AssetTriggerHandler.beforeInsert(Trigger.new);
    }
}