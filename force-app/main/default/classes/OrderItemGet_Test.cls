/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class OrderItemGet_Test {
    // Set variable for theese tests
    private static String accountName = 'AccountName-0';
    private static String productName = 'WIFI';
    private static String pricebook2Name = 'France Price Book';
    private static String orderName = 'Telepathy-';

    /**
    * @description TestSetup for OrderGet_Test
    * @author Muriel Proton | 13-02-2023 
    **/
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

    /**
    * @description Test method for OrderItemGet.getOrderItemListAll()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetOrdersAll(){

        Test.startTest();
        List<OrderItem> orderItemListForThisTest = OrderItemGet.getOrderItemListAll();
        Test.stopTest();

        System.assertEquals(1, orderItemListForThisTest.size(), 'OrderGet.getOrdersAll should return at least one order.');
    }

}