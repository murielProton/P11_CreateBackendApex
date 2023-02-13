/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
 * Warning all the methods stached here are used by the Schedueled batch
**/
/*Collect the batches of records or objects to be passed to execute
        If Account record has no Task nore Orders associated
        For each of theese Accounts create a Task (Subject : Call, Satus : New, Priority : normal, Reminder automatic*/
public with sharing class TaskCreateHelper_Queueable {

    /**
    * @description filter method records on Account not linked to a Task nor an Order
    * @author Muriel Proton | 13-02-2023 
    * @param List<Account> 
    * @return List<Id> 
    * Warning used in Batch
    **/
    public static List<Id> filterAccountListForNotLinkedToTasksNorOrders(List<Account> accountRecordsList){

        List<Id> accountIdListWithNoTasksNoOrders = new List<Id>();

        for(Account accountCurrent : accountRecordsList){
            // if list of Orders Linked to Account is empty and list of Tasks linked to Account is empty 
            if(accountCurrent.Orders.size() == 0
                && accountCurrent.Tasks.size() == 0){
                accountIdListWithNoTasksNoOrders.add(accountCurrent.Id);
            }
        }

        return accountIdListWithNoTasksNoOrders;
    }

    /**
    * @description Construct method, one linked to the Account in parametter
    * @author Muriel Proton | 13-02-2023 
    * @param Id 
    * @return Task 
    * Warning used in Batch
    **/
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

    /**
    * @description Construct method, as many Tasks as Accounts in parametters
    * @author Muriel Proton | 13-02-2023 
    * @param accountIdList 
    * @return List<Task> 
    * Warning used in Batch
    **/
    public static List<Task> constructTasksList(List<Id> accountIdList){
        List<Task> taskListToInsert = new List<Task>();
        for(Id accountIdCurrent : accountIdList){
            taskListToInsert.add(constructOneTask(accountIdCurrent));
        }
        return taskListToInsert;
    }

    /**
    * @description Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation) Apex PMD, insert method
    * @author Muriel Proton | 13-02-2023 
    * @param List<Task> 
    **/
    public static void checkTasksPermissions(List<Task> taskListToInsert){
        if (Schema.sObjectType.Account.fields.Name.isCreateable() == false &&
        Schema.sObjectType.Account.fields.Type.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Account record.');
        }else{
            insert taskListToInsert;
        }
    }
}