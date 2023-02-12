/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 12-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class TaskCreate_Queueable implements Database.Batchable<sObject> {
    
    public List<Account> start(Database.BatchableContext bc){
        /*Collect the batches of records or objects to be passed to execute
        All accounts with the associated lists of Tasks and Orders
        */
        List<Account> accountRecordsList = [SELECT Name, (SELECT Id,
                                                                 Subject,
                                                                 Status,
                                                                 Priority,
                                                                 IsReminderSet,
                                                                 WhatId 
                                                            FROM Tasks), 
                                                          (SELECT Name, 
                                                                  AccountId 
                                                           FROM Orders) 
                                            FROM Account];
        return accountRecordsList; 
    }

    public void execute(Database.BatchableContext bc, List<Account> accountRecordsList){
        /* process each batch of records
        Loop on this Account list and return accounts that have no reccord Task nore Orders associated*/
        List<Id> accountsIdListToTest = TaskCreateHelper_Queueable.filterAccountListForNotLinkedToTasksNorOrders(accountRecordsList);
        /*For each of theese Accounts create a Task (Subject : Call, Satus : New, Priority : normal, Reminder automatic*/
        List<Task> tasksRecordsListToInsert = TaskCreateHelper_Queueable.constructTasksList(accountsIdListToTest);
        insert tasksRecordsListToInsert;
    }

    public void finish(Database.BatchableContext bc){
        //execute any post processing operations
        System.debug('@@Post Processsing Batch DONE');
        //Chaining Batch Jobs
        //Database.execut(new BatchCalss2());
    }
}

    