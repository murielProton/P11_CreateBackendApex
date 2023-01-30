/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class OrderFormat_Test {

    private static String pricebook2Name = 'France Price Book';
    private static String orderName = 'Telepathy-';

    @isTest
    public static void testTransformListToMap() {
        //Create a List of Accounts
        AccountDataFactory.createAccountsList(3);
        List<Account> accountListForTest = AccountGet.getAccountsAll();
        //create a Contract for this Account
        ContractDataFactory.createContractsList(accountListForTest);
        // Make sure the Pricebook2 entry is active and standard
        Pricebook2DataFactory.createPricebook2();  
                
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
        // create an orderList ID are needed to populate the map
        OrderDataFactory.createOrdersListForEachContract(contractListToCreateOrders, pricebookForThisTest);
        List<Order> orderListForThisTest = OrderGet.getOrdersAll();
        
        Test.startTest();
        Map<Id, Order> orderMapToTest = OrderFormat.transformListToMap(orderListForThisTest);
        Test.stopTest();

        System.assertEquals(orderListForThisTest.size(), orderMapToTest.size(), 'OrderFilter.transformListToMap should return a map of the same size as the List it received as parameter.');
    }
}