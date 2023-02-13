/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class TaskDataFactory {
    /**
    * @description Construct method one Task linked to the Account passed as parametter
    * @author Muriel Proton | 13-02-2023 
    * @param Id 
    * @return Task 
    **/
    public static Task constructOneTask(Id accountId){
        Task task = new Task(
            Subject = 'Call',
            Status = 'New',
            Priority = 'Normal',
            IsReminderSet = true,
            WhatId = accountId
        );
        return task;
    }

    /**
    * @description Insert method for as many record on Task as recordson Account Set passed as parametter
    * @author Muriel Proton | 13-02-2023 
    * @param Set<Id> 
    **/
    public static void createTasksList(Set<Id> accountIdList){
        List<Task> taskListToInsert = new List<Task>();
        for(Id accountIdCurrent : accountIdList){
            taskListToInsert.add(constructOneTask(accountIdCurrent));
        }
        checkTasksPermissionsTask(taskListToInsert);
    }

    /**
    * @description Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation) Apex PMD, insert method
    * @author Muriel Proton | 13-02-2023 
    * @param List<Task> 
    **/
    public static void checkTasksPermissionsTask(List<Task> taskListToInsert){
        if (!Task.SObjectType.getDescribe().isAccessible() 
            || !Schema.sObjectType.Task.fields.Subject.isCreateable() 
            || !Schema.sObjectType.Task.fields.Status.isCreateable()) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Task record.');
        }else{
            insert taskListToInsert;
        }
    }
}