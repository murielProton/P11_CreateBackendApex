/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class OrderItemDataFactory_Test {

    // Set variable for theese tests
    private static String accountName = 'AccountName-0';
    private static String productName = 'WIFI';
    private static String pricebook2Name = 'France Price Book';
    private static String orderName = 'Telepathy-';

    @TestSetup
    static void setupOrderItemDataFactory(){
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

    }
    @isTest
    static void testConstructOneOrderItem(){
        // get sObjects to run the test
        Id accountId = AccountGet.getAccountByName(accountName).Id;
        Id contractId = ContractGet.getContractsOfAccount(accountId)[0].Id;
        Id orderId = OrderGet.getOrderByAccountAndContract(accountId, contractId)[0].Id;
        
        Product2 product2ForThisTest = Product2Get.getProduct2All()[0];//warning
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];//warning

        List<PricebookEntry> pricebookEntryListForThisTest = PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebookForThisTest.Id, product2ForThisTest.Id);

        Test.startTest();
        OrderItem orderItemToTest = OrderItemDataFactory.constructOneOrderItem(orderId, product2ForThisTest.Id, pricebookEntryListForThisTest[0].Id);
        Test.stopTest();

        System.assertEquals(240, orderItemToTest.UnitPrice, 'OrderItemDataFactory.constructOneOrderItem should return one OrderItem.');
    }
    @isTest
    static void testCreateOrderItemsList(){
        // get sObjects to run the test
        Id accountId = AccountGet.getAccountByName(accountName).Id;
        Id contractId = ContractGet.getContractsOfAccount(accountId)[0].Id;
        List<Order> orderListForTest = OrderGet.getOrderByAccountAndContract(accountId, contractId);
        
        Product2 product2ForThisTest = Product2Get.getProduct2All()[0];//warning
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];//warning

        List<PricebookEntry> pricebookEntryListForThisTest = PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebookForThisTest.Id, product2ForThisTest.Id);

        Test.startTest();
        OrderItemDataFactory.createOrderItemsList(orderListForTest, product2ForThisTest.Id, pricebookEntryListForThisTest[0].Id);
        Test.stopTest();

        List<OrderItem> orderItemListToTest = OrderItemGet.getOrderItemListAll();

        System.assertEquals(1, orderItemListToTest.size(), 'OrderItemDataFactory.createOrderItemsList should create at least one OrderItem.');
    }
    
}