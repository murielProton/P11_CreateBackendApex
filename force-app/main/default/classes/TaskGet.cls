/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 12-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class TaskGet {
    public static List<Task> getTaskAll() {
        checkTaskPermissions();
        List<Task> taskListToReturn = [SELECT Id,
                                              Subject,
                                               Status,
                                               Priority,
                                               IsReminderSet,
                                               WhatId
                                        FROM Task];
        return taskListToReturn;
    }

    public static void checkTaskPermissions(){
        if(!Task.SObjectType.getDescribe().isAccessible() &&
            !Schema.SObjectType.Task.fields.Subject.isAccessible() &&
            !Schema.SObjectType.Task.fields.Status.isAccessible() &&
            !Schema.SObjectType.Task.fields.Priority.isAccessible() &&
            !Schema.SObjectType.Task.fields.IsReminderSet.isAccessible()&&
            !Schema.SObjectType.Task.fields.WhatId.isAccessible()){
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order reccord.');
        }
    }
}