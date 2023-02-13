/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class TaskGet_Test {

    /**
    * @description TestSetup for TaskGet_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    public static void setupTaskGet(){
        //Create an Account
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsList = AccountGet.getAccountsAll();
        Set<Id> accountIdSet = (new Map<Id,Account>(accountsList)).keySet();
        TaskDataFactory.createTasksList(accountIdSet);
    }

    /**
    * @description Test for TaskGet.getTaskAll()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testGetTaskAll() {

        Test.startTest();
        List<Task> taskListForTest = TaskGet.getTaskAll();
        Test.stopTest();

        System.assertEquals(5, taskListForTest.size(), 'TaskGet.getTaskAll() should return 5 Tasks.');
    }
}