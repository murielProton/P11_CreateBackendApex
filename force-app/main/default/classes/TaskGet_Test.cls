/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 09-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class TaskGet_Test {

    @TestSetup
    public static void setupTaskGet(){
        //Create an Account
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsList = AccountGet.getAccountsAll();
        Set<Id> accountIdSet = (new Map<Id,Account>(accountsList)).keySet();
        TaskDataFactory.createTasksList(accountIdSet);
    }

    @isTest
    public static void testGetTaskAll() {

        Test.startTest();
        List<Task> taskListForTest = TaskGet.getTaskAll();
        Test.stopTest();

        System.assertEquals(5, taskListForTest.size(), 'TaskGet.getTaskAll() should return 5 Tasks.');
    }
}