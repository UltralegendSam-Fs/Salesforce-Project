trigger CourseTrigger on Course__c (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        CourseTriggerHandler.beforeInsert(Trigger.new);
    }
}