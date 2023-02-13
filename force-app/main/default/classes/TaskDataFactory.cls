/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class TaskDataFactory {
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

    public static void createTasksList(Set<Id> accountIdList){
        List<Task> taskListToInsert = new List<Task>();
        for(Id accountIdCurrent : accountIdList){
            taskListToInsert.add(constructOneTask(accountIdCurrent));
        }
        checkTasksPermissionsTask(taskListToInsert);
    }

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