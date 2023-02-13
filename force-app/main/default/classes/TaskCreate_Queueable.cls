/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class TaskCreate_Queueable implements Database.Batchable<sObject> {
    
    /**
    * @description Batch method TaskCreate_Queueable implements native start methode
    * @author Muriel Proton | 13-02-2023 
    * @param Database.BatchableContext 
    * @return List<Account> 
    **/
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

    /**
    * @description Batch method TaskCreate_Queueable implements native execute method
    * @author Muriel Proton | 13-02-2023 
    * @param BatchableContext 
    * @param List<Account> 
    **/
    public void execute(Database.BatchableContext bc, List<Account> accountRecordsList){
        /* process each batch of records
        Loop on this Account list and return accounts that have no record Task nore Orders associated*/
        List<Id> accountsIdListToTest = TaskCreateHelper_Queueable.filterAccountListForNotLinkedToTasksNorOrders(accountRecordsList);
        /*For each of theese Accounts create a Task (Subject : Call, Satus : New, Priority : normal, Reminder automatic*/
        List<Task> tasksRecordsListToInsert = TaskCreateHelper_Queueable.constructTasksList(accountsIdListToTest);
        insert tasksRecordsListToInsert;
    }

    /**
    * @description Batch method TaskCreate_Queueable implements native finish method
    * @author Muriel Proton | 13-02-2023 
    * @param Database.BatchableContext 
    **/
    public void finish(Database.BatchableContext bc){
        //execute any post processing operations
        System.debug('@@Post Processsing Batch DONE');
        //Chaining Batch Jobs
        //Database.execut(new BatchCalss2());
    }
}

    