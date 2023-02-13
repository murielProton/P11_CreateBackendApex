/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class PricebookEntryGet_Test {

    private static String accountName = 'AccountName-0';
    private static String pricebook2Name = 'France Price Book';
    private static String product2Name = 'WIFI';

    /**
    * @description TestSetup PricebookEntryGet_Test 
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupPricebookEntryGet(){
        //Create an Account
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsListForThisTest = AccountGet.getAccountsAll();
        //create a Contract for thees Accounts
        ContractDataFactory.createContractsList(accountsListForThisTest);
        // Make sure the Pricebook2 entry is active and standard
        Pricebook2DataFactory.createPricebook2();
        // to create a Pricebook2 field Standard = true the price book needs to be linked to a Product2
        // Create Product2
        Product2DataFactory.createProduct2();
        // Now make sure the Salesforce process doese create a standard Pricebook2
        List<Pricebook2> pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name);
        List<Product2> product2ForThisTest = Product2Get.getProduct2ListByName(product2Name);        
    }

    /**
    * @description Test method for PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebookForThisTest.Id, product2ForThisTest.Id)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetPricebookEntryByPricebook2AndProduct2(){
        //gest sObjects for the Test
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];
        Product2 product2ForThisTest = Product2Get.getProduct2ListByName(product2Name)[0];

        PricebookEntryDataFactory.createPriceBookEntryForPricebookStandard(product2ForThisTest);

        PricebookEntryDataFactory.createPriceBookEntry(pricebookForThisTest, product2ForThisTest);

        Test.startTest();
        List<PricebookEntry> pricebookEntryListForThisTest = PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebookForThisTest.Id, product2ForThisTest.Id);
        Test.stopTest();

        System.assertEquals(1, pricebookEntryListForThisTest.size(), 'PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2 should return 2 records of PricebookEntry.');

    }
}