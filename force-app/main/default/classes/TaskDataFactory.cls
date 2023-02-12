/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 09-02-2023
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
        for(Id accountIdCurent : accountIdList){
            taskListToInsert.add(constructOneTask(accountIdCurent));
        }
        checkTasksPermissions(taskListToInsert);
    }

    public static void checkTasksPermissions(List<Task> taskListToInsert){
        if (Schema.sObjectType.Account.fields.Name.isCreateable() == false &&
        Schema.sObjectType.Account.fields.Type.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Account reccord.');
        }else{
            insert taskListToInsert;
        }
    }
}