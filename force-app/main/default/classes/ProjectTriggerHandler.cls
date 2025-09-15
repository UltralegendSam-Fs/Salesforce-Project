public with sharing class ProjectTriggerHandler {
    
    /**
     * Handles before insert operations
     */
    public static void handleBeforeInsert(List<Project__c> newProjects) {
        for (Project__c project : newProjects) {
            // Set Start Date if status is 'In Progress' and Start Date is not set
            if (project.Status__c == 'In Progress' && project.Start_Date__c == null) {
                project.Start_Date__c = Date.today();
            }
            
            // Set End Date if status is 'Completed' and End Date is not set
            if (project.Status__c == 'Completed' && project.End_Date__c == null) {
                project.End_Date__c = Date.today();
            }
        }
    }
    
    /**
     * Handles before update operations
     */
    public static void handleBeforeUpdate(List<Project__c> newProjects, Map<Id, Project__c> oldProjectsMap) {
        for (Project__c project : newProjects) {
            Project__c oldProject = oldProjectsMap.get(project.Id);
            
            // Check if status has changed
            if (project.Status__c != oldProject.Status__c) {
                
                // Set Start Date when status changes to 'In Progress'
                if (project.Status__c == 'In Progress' && project.Start_Date__c == null) {
                    project.Start_Date__c = Date.today();
                }
                
                // Set End Date when status changes to 'Completed'
                if (project.Status__c == 'Completed' && project.End_Date__c == null) {
                    project.End_Date__c = Date.today();
                }
                
                // Clear End Date if status changes from 'Completed' to any other status
                if (oldProject.Status__c == 'Completed' && project.Status__c != 'Completed') {
                    project.End_Date__c = null;
                }
            }
        }
    }
}