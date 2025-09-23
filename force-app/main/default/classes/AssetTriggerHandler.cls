/**
 * SCRUM-21: Handler for Asset__c trigger logic.
 * Sets Warranty_Expiry_Date__c to Purchase_Date__c + 1 year when not provided.
 */
public with sharing class AssetTriggerHandler {
    public static void beforeInsert(List<Asset__c> newList) {
        if (newList == null || newList.isEmpty()) return;
        for (Asset__c a : newList) {
            if (a == null) continue;
            if (a.Warranty_Expiry_Date__c == null && a.Purchase_Date__c != null) {
                a.Warranty_Expiry_Date__c = a.Purchase_Date__c.addYears(1);
            }
        }
    }
}