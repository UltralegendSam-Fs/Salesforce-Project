trigger CustomerAlertTrigger on CustomerAlert__c (before insert) {
    for (CustomerAlert__c alert : Trigger.new) {
        if (alert.Alert_Date__c == null) {
            alert.Alert_Date__c = Date.today();
        }
    }
}