/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class OrderItemFormat_Test {
    private static String pricebook2Name = 'France Price Book';
    private static String orderName = 'Telepathy-';

    @isTest
    public static void testtransformListToMapOrderIdOrderItem() {
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
        OrderItemDataFactory.createOrderItemsList(ordersListForThisTest, product2ForThisTest.Id, pricebookEntryForThisTest.Id);
        //Get list of order Item
        List<OrderItem> orderItemListForThisTest = OrderItemGet.getOrderItemListAll();

        
        Test.startTest();
        Map<Id, OrderItem> orderItemMapToTest = OrderItemFormat.transformListToMapOrderIdOrderItem(orderItemListForThisTest);
        Test.stopTest();

        System.assertEquals(orderItemListForThisTest.size(), orderItemMapToTest.size(), 'OrderItemFormat.transformListToMapOrderIdOrderItem should return a map of the same size as the List it received as parameter.');
    }
}