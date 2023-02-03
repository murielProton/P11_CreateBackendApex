/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class OrderItemGet_Test {
    // Set variable for theese tests
    private static String accountName = 'AccountName-0';
    private static String productName = 'WIFI';
    private static String pricebook2Name = 'France Price Book';
    private static String orderName = 'Telepathy-';

    @TestSetup
    static void setupOrderItemGet(){
        //Create an Account
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsListForContract = AccountGet.getAccountsAll();
        //create a Contract for this Account
        ContractDataFactory.createContractsList(accountsListForContract);
        // Make sure the Pricebook2 entry is active and standard
        Pricebook2DataFactory.createPricebook2();
        // to create a Pricebook2 field Standard = true the price book needs to be linked to a Product2
        // Create Product2
        Product2DataFactory.createProduct2();
        // Now make sure the Salesforce process doese create a standard Pricebook2
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];
        Product2 product2ForThisTest = Product2Get.getProduct2All()[0];
        // Process needs an entry in th Pricebook2 Standard = true, first ;
        PricebookEntryDataFactory.createPriceBookEntryForPricebookStandard(product2ForThisTest);
        // then PricebookEntry for normal Pricebook2 can be inserted.
        PricebookEntryDataFactory.createPriceBookEntry(pricebookForThisTest, product2ForThisTest);
        // get contract
        Id accountIdForThisTest = accountsListForContract[0].Id;
        List<Contract> contractListToCreateOrders = ContractGet.getContractsOfAccount(accountIdForThisTest);
        //Create Order
        OrderDataFactory.createOrdersListForEachContract(contractListToCreateOrders, pricebookForThisTest);
        // Get variables to create OrderItem
        List<Order> ordersListForThisTest = OrderGet.getOrderByAccountAndContract(accountIdForThisTest, contractListToCreateOrders[0].Id);
        Order orderForThisTest = ordersListForThisTest[0];
        PricebookEntry pricebookEntryForThisTest = PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebookForThisTest.Id, product2ForThisTest.Id)[0];
        //Create OrderItem
        OrderItem orderItemsListToInstert = OrderItemDataFactory.constructOneOrderItem(orderForThisTest.Id, product2ForThisTest.Id, pricebookEntryForThisTest.Id);
        insert orderItemsListToInstert;
    }
    @isTest
    static void testGetOrderItemByOrderProductPricebookEntry(){
        //Get parametters for the parametters of this test
        Id accountIdForThisTest = AccountGet.getAccountsAll()[0].Id;
        Contract contractListToCreateOrders = ContractGet.getContractsOfAccount(accountIdForThisTest)[0];
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];
        Product2 product2ForThisTest = Product2Get.getProduct2All()[0];
        //get parametters for the test
        List<Order> ordersListForThisTest = OrderGet.getOrderByAccountAndContract(accountIdForThisTest, contractListToCreateOrders.Id);
        Order orderForThisTest = ordersListForThisTest[0];
        PricebookEntry pricebookEntryForThisTest = PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebookForThisTest.Id, product2ForThisTest.Id)[0];

        Test.startTest();
        List<OrderItem> orderItemsListToTest = OrderItemGet.getOrderItemByOrderProductPricebookEntry(orderForThisTest.Id, product2ForThisTest.Id, pricebookEntryForThisTest.Id);
        Test.stopTest();

        System.assertEquals(1, orderItemsListToTest.size(), 'OrderItemGet.getOrderItemByOrderProductPricebookEntry should return at least one reccord.');
    }
    @isTest
    static void testGetOrderItemWhereProduct2AndOrderExist(){
        //Get parametters for the parametters of this test
        Id accountIdForThisTest = AccountGet.getAccountsAll()[0].Id;
        Contract contractListToCreateOrders = ContractGet.getContractsOfAccount(accountIdForThisTest)[0];
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];
        Product2 product2ForThisTest = Product2Get.getProduct2All()[0];
        //get parametters for the test
        List<Order> ordersListForThisTest = OrderGet.getOrderByAccountAndContract(accountIdForThisTest, contractListToCreateOrders.Id);
        Order orderForThisTest = ordersListForThisTest[0];
        PricebookEntry pricebookEntryForThisTest = PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebookForThisTest.Id, product2ForThisTest.Id)[0];

        Test.startTest();
        // Transform a list of order to list of order ID
        List<Id> orderIdList = new List<ID>(new Map<Id, Order>(ordersListForThisTest).keySet());
        List<OrderItem> orderItemsListToTest = OrderItemGet.getOrderItemWhereProduct2AndOrderExist(orderIdList);
        Test.stopTest();

        System.assertEquals(1, orderItemsListToTest.size(), 'OrderItemGet.getOrderItemWhereProduct2AndOrderExist should return at least one reccord.');
    }

}