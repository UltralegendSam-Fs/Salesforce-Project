public with sharing class CourseTriggerHandler {
    public static void beforeInsert(List<Course__c> newList) {
        Date today = Date.today();
        for (Course__c c : newList) {
            if (c.Start_Date__c == null) {
                c.Start_Date__c = today;
            }
        }
    }
}