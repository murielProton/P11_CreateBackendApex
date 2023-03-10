/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class TaskCreateHelper_QueueableTest {

    //private static String accountName = 'AccountName-0';
    private static String orderName = 'Telepathy';

    /**
    * @description TestSetup for TaskCreateHelper_QueueableTest
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupTaskCreateHelper_Queueable(){
        List<Account> accountList = AccountGet.getAccountsAll();
        Set<Id> accountIdList = new Map<Id,Account>(accountList).keySet();
        ContractDataFactory.createContractsList(accountList);
        List<Contract> contractListToCreateOrders = ContractGet.getContractsAll();
        // Now make sure the Salesforce process doese create a standard Pricebook2
        Pricebook2 pricebookStandardToUpdate = new PriceBook2 (
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        //Execute an update DML on the Pricebook2 record, to make IsStandard to true
        update pricebookStandardToUpdate; 
        List<PriceBook2> pricebook2ListALL = Pricebook2Get.getPriceBook2All();  
        PriceBook2 pricebook2Standard = Pricebook2Get.getPriceBook2Standard();
        OrderDataFactory.createOrdersListForEachContract(contractListToCreateOrders, pricebook2Standard);
        List<Order> orderList = OrderGet.getOrdersAll();

        Set<Id> orderIDSetAll = new Set<Id>();
        for (Order orderCurrent : orderList){
            orderIDSetAll.add(orderCurrent.Id);
        }
        TaskDataFactory.createTasksList(accountIdList);
        insert new Account(Name = 'AccountName-6');
        List<Account> accountsList = AccountGet.getAccountsAll();
        Set<Id> accountIDSetOfAllDeletedOrders = new Set<Id>();
        for(Account accountCurrent : accountsList){
            accountIDSetOfAllDeletedOrders.add(accountCurrent.Id);
        }
    }

    /**
    * @description Test method for TaskCreateHelper_Queueable.filterAccountListForNotLinkedToTasksNorOrders(accountRecordsList)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testFilterAccountListForNotLinkedToTasksNorOrders(){

        List<Account> accountRecordsList = AccountGet.getAccountsAll();

        Test.startTest();
        List<Id> accountsIdListToTest = TaskCreateHelper_Queueable.filterAccountListForNotLinkedToTasksNorOrders(accountRecordsList);
        Test.stopTest();

        System.assertEquals( 1, accountsIdListToTest.size(),'TaskCreateHelper_Queueable.filterAccountListForNotLinkedToTasksNorOrders(<Account>) should return 1 Account.');
    }
    
    /**
    * @description Test method for TaskCreateHelper_Queueable.constructOneTask(accountId)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testConstructOneTask(){

        Id accountId = AccountGet.getAccountsAll()[0].Id;

        Test.startTest();
        Task taskToTest = TaskCreateHelper_Queueable.constructOneTask(accountId);
        Test.stopTest();
        
        System.assertEquals(accountId, taskToTest.WhatId, 'TaskCreateHelper_Queueable.constructTask should construct one Task.');
    }
}