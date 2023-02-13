/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class TaskDataFactory_Test {
    private static String accountName = 'accountName-0';

    /**
    * @description TestSetup for TaskDataFactory_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupTaskDataFactory(){
        //Create an Account
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsList = AccountGet.getAccountsAll();
    }

    /**
    * @description Test method for TaskDataFactory.constructOneTask(accountId)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void taskConstructOneTask(){

        Id accountId = AccountGet.getAccountsAll()[0].Id;

        Test.startTest();
        Task taskToTest = TaskDataFactory.constructOneTask(accountId);
        Test.stopTest();

        System.assertEquals(accountId, taskToTest.WhatId, 'TaskDataFactory.constructTask should construct one Task.');
    }
    /**
    * @description Test method for TaskDataFactory.createTasksList(accountIdSet)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testCreateTasksList(){
        List<Account> accountSet = AccountGet.getAccountsAll();
        Set<Id> accountIdSet = (new Map<Id,Account>(accountSet)).keySet();

        Test.startTest();
        TaskDataFactory.createTasksList(accountIdSet);
        Test.stopTest();

        List<Task> taskListForTest = TaskGet.getTaskAll();

        System.assertEquals(accountIdSet.size(), taskListForTest.size(), 'TaskDataFactory.createTasksList should insert 5 Tasks.');
    }
}