/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 12-02-2023
 * @last modified by  : Muriel Proton
**/
/*Collect the batches of records or objects to be passed to execute
        If Account reccord has no Task nore Orders associated
        For each of theese Accounts create a Task (Subject : Call, Satus : New, Priority : normal, Reminder automatic*/
public with sharing class TaskCreateHelper_Queueable {

    public static List<Id> filterAccountListForNotLinkedToTasksNorOrders(List<Account> accountRecordsList){

        List<Id> accountIdListWithNoTasksNoOrders = new List<Id>();

        for(Account accountCurent : accountRecordsList){
            // if list of Orders Linked to Account is empty and list of Tasks linked to Account is empty 
            if(accountCurent.Orders.size() == 0
                && accountCurent.Tasks.size() == 0){
                accountIdListWithNoTasksNoOrders.add(accountCurent.Id);
            }
        }

        return accountIdListWithNoTasksNoOrders;
    }

    public static Task constructOneTask(Id accountId){
        
        DateTime today = DateTime.now();

        Task task = new Task(
            Subject = 'Call',
            Status = 'New',
            Priority = 'Normal',
            IsReminderSet = true,
            ReminderDateTime = today.addDays(5),
            WhatId = accountId
        );
        return task;
    }

    public static List<Task> constructTasksList(List<Id> accountIdList){
        List<Task> taskListToInsert = new List<Task>();
        for(Id accountIdCurent : accountIdList){
            taskListToInsert.add(constructOneTask(accountIdCurent));
        }
        return taskListToInsert;
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