/**
 * SCRUM-21: Unit tests for AssetTriggerHandler/AssetTrigger.
 */
@IsTest(SeeAllData=false)
private class AssetTriggerHandlerTest {
    @IsTest
    static void testAutoSetsWarrantyWhenMissing() {
        Date purchase = Date.today();
        Asset__c a = new Asset__c(Purchase_Date__c = purchase);
        Test.startTest();
        insert a;
        Test.stopTest();

        a = [SELECT Purchase_Date__c, Warranty_Expiry_Date__c FROM Asset__c WHERE Id = :a.Id];
        System.assertEquals(purchase.addYears(1), a.Warranty_Expiry_Date__c, 'Should auto-set to +1 year');
    }

    @IsTest
    static void testDoesNotOverrideExistingWarranty() {
        Date purchase = Date.today();
        Date provided = purchase.addYears(2);
        Asset__c a = new Asset__c(Purchase_Date__c = purchase, Warranty_Expiry_Date__c = provided);
        Test.startTest();
        insert a;
        Test.stopTest();

        a = [SELECT Purchase_Date__c, Warranty_Expiry_Date__c FROM Asset__c WHERE Id = :a.Id];
        System.assertEquals(provided, a.Warranty_Expiry_Date__c, 'Should not override provided warranty date');
    }

    @IsTest
    static void testNoPurchaseDate_NoChange() {
        Asset__c a = new Asset__c();
        Test.startTest();
        insert a;
        Test.stopTest();

        a = [SELECT Purchase_Date__c, Warranty_Expiry_Date__c FROM Asset__c WHERE Id = :a.Id];
        System.assertEquals(null, a.Warranty_Expiry_Date__c, 'Should remain null when no purchase date provided');
    }

    @IsTest
    static void testBulkInsert() {
        List<Asset__c> toInsert = new List<Asset__c>();
        Date base = Date.today();
        for (Integer i = 0; i < 200; i++) {
            toInsert.add(new Asset__c(Purchase_Date__c = base.addDays(i)));
        }
        Test.startTest();
        insert toInsert;
        Test.stopTest();

        List<Asset__c> inserted = [SELECT Purchase_Date__c, Warranty_Expiry_Date__c FROM Asset__c WHERE Id IN :toInsert];
        System.assertEquals(200, inserted.size(), 'All records should be inserted');
        for (Asset__c rec : inserted) {
            System.assertEquals(rec.Purchase_Date__c.addYears(1), rec.Warranty_Expiry_Date__c, 'Each record should be +1 year');
        }
    }
}