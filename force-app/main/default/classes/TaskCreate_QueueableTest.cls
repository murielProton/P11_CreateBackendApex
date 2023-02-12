/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 12-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class TaskCreate_QueueableTest {

    @isTest
    public static void testTaskCreate_QueueableBatch() {
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
        System.debug('orderList ' + orderList);
        System.debug('orderList ' + orderList);
        Set<Id> orderIDSetAll = new Set<Id>();
        for (Order orderCurent : orderList){
            orderIDSetAll.add(orderCurent.Id);
        }
        TaskDataFactory.createTasksList(accountIdList);
        insert new Account(Name = 'AccountName-6');
        List<Account> accountsList = AccountGet.getAccountsAll();
        Set<Id> accountIDSetOfAllDeletedOrders = new Set<Id>();
        for(Account accountCurent : accountsList){
            accountIDSetOfAllDeletedOrders.add(accountCurent.Id);
        }

        Test.startTest();
        TaskCreate_Queueable taskCreateBatch = new TaskCreate_Queueable();
        Id taskCreateBatchId = Database.executeBatch(taskCreateBatch);
        Test.stopTest();

        List<Task> taskListToTest = TaskGet.getTaskAll();

        System.assertEquals(1, taskListToTest.size(), 'The batch should have inserted at least one Task.');
    }
}