trigger ProjectTrigger on Project__c (before insert, before update) {
    
    // Handle before insert
    if (Trigger.isBefore && Trigger.isInsert) {
        ProjectTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    
    // Handle before update
    if (Trigger.isBefore && Trigger.isUpdate) {
        ProjectTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
}