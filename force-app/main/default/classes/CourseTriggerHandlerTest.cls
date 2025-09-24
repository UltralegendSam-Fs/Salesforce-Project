@IsTest
private class CourseTriggerHandlerTest {
    @IsTest static void defaultsStartDateWhenBlank() {
        // Record without Start_Date__c should default to today
        Course__c c1 = new Course__c(Name='Test Course 1', Instructor__c='Alice');
        // Record with Start_Date__c should retain explicit value
        Date explicitDate = Date.newInstance(2024, 1, 1);
        Course__c c2 = new Course__c(Name='Test Course 2', Instructor__c='Bob', Start_Date__c=explicitDate);

        insert new List<Course__c>{ c1, c2 };

        Course__c c1After = [SELECT Start_Date__c FROM Course__c WHERE Id = :c1.Id];
        Course__c c2After = [SELECT Start_Date__c FROM Course__c WHERE Id = :c2.Id];

        System.assertEquals(Date.today(), c1After.Start_Date__c, 'Start date should default to today when blank');
        System.assertEquals(explicitDate, c2After.Start_Date__c, 'Start date should remain as explicitly set');
    }

    @IsTest static void bulkInsertDefaults() {
        List<Course__c> courses = new List<Course__c>();
        for (Integer i = 0; i < 200; i++) {
            courses.add(new Course__c(Name='Bulk ' + i));
        }
        Test.startTest();
        insert courses;
        Test.stopTest();
        for (Course__c c : [SELECT Start_Date__c FROM Course__c WHERE Id IN :courses]) {
            System.assertNotEquals(null, c.Start_Date__c, 'Start date should be populated in bulk');
        }
    }
}