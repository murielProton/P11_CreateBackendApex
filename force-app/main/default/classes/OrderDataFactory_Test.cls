/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class OrderDataFactory_Test {

    private static String accountName = 'accountName-0';
    private static String pricebook2Name = 'France Price Book';
    public static String orderName = 'Telepathy-';

    @TestSetup
    static void setupOrderDataFactory(){
        //Create a List of Accounts
        AccountDataFactory.createAccountsList(1);
        List<Account> accountListForTest = AccountGet.getAccountsAll();
        //create a Contract for this Account
        ContractDataFactory.createContractsList(accountListForTest);
        // Make sure the Pricebook2 entry is active and standard
        Pricebook2DataFactory.createPricebook2();  
    }

    @isTest
    static void testConstructOneOrder(){
        // get sObjects for Test
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];
        List<Account> accountListForTest = AccountGet.getAccountsAll();
        Account accountForThisTest = accountListForTest[0];
        List<Contract> contractListForThisTest = ContractGet.getContractsAll();
        Contract contractForThisTest = contractListForThisTest[0];

        Test.startTest();
        Order orderForThisTest = OrderDataFactory.constructOneOrder(orderName, accountForThisTest.ID, contractForThisTest.ID, pricebookForThisTest.Id);
        Test.stopTest();

        System.assertEquals( 'Draft', orderForThisTest.Status, 'OrderDataFactory.constructOneOrder should create one order.');
    }

    @isTest
    static void testCreateOrdersListForEachContract(){
        
        List<Account> accountListForTest = AccountGet.getAccountsAll();
        Account accountForThisTest = accountListForTest[0];
        // for each accounts create a contract 
        ContractDataFactory.createContractsList(accountListForTest);
        // Create Product2
        Product2DataFactory.createProduct2();
        // Now make sure the Salesforce process doese create a standard Pricebook2
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];
        Product2 product2ForThisTest = Product2Get.getProduct2All()[0];
        // Process needs an entry in th Pricebook2 Standard = true, first ;
        PricebookEntryDataFactory.createPriceBookEntryForPricebookStandard(product2ForThisTest);
        // then PricebookEntry for normal Pricebook2 can be inserted.
        PricebookEntryDataFactory.createPriceBookEntry(pricebookForThisTest, product2ForThisTest);
        // get contracts List we just inserted
        List<Contract> contractListToCreateOrders = ContractGet.getContractsAll();

        Test.startTest();
        OrderDataFactory.createOrdersListForEachContract(contractListToCreateOrders, pricebookForThisTest);
        Test.stopTest();

        List<Order> orderListForThisTest = OrderGet.getOrdersAll();

        System.assertEquals(2, orderListForThisTest.size(), 'OrderDataFactory.createOrdersListForEachContract should reate a list of records on Order.');
    }
}