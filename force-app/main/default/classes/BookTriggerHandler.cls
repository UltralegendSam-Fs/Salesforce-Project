public with sharing class BookTriggerHandler {
    public static void beforeInsert(List<Book__c> newList){
        if(newList == null || newList.isEmpty()) return;
        Date today = Date.today();
        for (Book__c b : newList){
            if (b.Published_Date__c == null){
                b.Published_Date__c = today;
            }
        }
    }
}