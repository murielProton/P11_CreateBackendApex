/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class PricebookEntryDataFactory_Test {

    /**
    * @description TestSetup for PricebookEntryDataFactory_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupPricebookEntryDataFactory() {
        Pricebook2DataFactory.createPricebook2();
        Product2DataFactory.createProduct2();
    }

    /**
    * @description Test method for PricebookEntryDataFactory.createPriceBookEntryForPricebookStandard(product2ForThisTest)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testCreatePriceBookEntryForPricebookStandard(){
        //gest sObjects for the Test
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName('France Price Book')[0];
        Product2 product2ForThisTest = Product2Get.getProduct2All()[0];

        Test.startTest();
        PricebookEntryDataFactory.createPriceBookEntryForPricebookStandard(product2ForThisTest);
        Test.stopTest();
        PricebookEntry pricebookEntryForThisTest = [SELECT Id,
                                                            Name,
                                                            Pricebook2Id,
                                                            Product2Id,
                                                            UnitPrice,
                                                            UseStandardPrice,
                                                            IsActive
                                                    FROM PricebookEntry
                                                    WHERE Product2Id = :product2ForThisTest.Id
                                                    LIMIT 1];
                                                    
        // Test.getStandardPricebookId() is the only way to get trace of a Standard Pricebook entry in a test environnement.
        System.assertEquals(pricebookEntryForThisTest.Pricebook2Id, Test.getStandardPricebookId(), 'PricebookEntryDataFactory.createPriceBookEntryForPricebookStandard should insert a Standard PricebookEntry.');
    }

    /**
    * @description Test method for PricebookEntryDataFactory.createPriceBookEntry(pricebookForThisTest, product2ForThisTest)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testCreatePricebookEntry(){
        //gest sObjects for the Test
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName('France Price Book')[0];
        Product2 product2ForThisTest = Product2Get.getProduct2All()[0];

        //before inserting a custom Pricebook Entry, we need a Sandard Pricebook Entry
        PricebookEntryDataFactory.createPriceBookEntryForPricebookStandard(product2ForThisTest);

        Test.startTest();
        PricebookEntryDataFactory.createPriceBookEntry(pricebookForThisTest, product2ForThisTest);
        Test.stopTest();

        PricebookEntry pricebookEntryForThisTest = [SELECT Id,
                                                        Name,
                                                        Pricebook2Id,
                                                        Product2Id,
                                                        UnitPrice,
                                                        UseStandardPrice,
                                                        IsActive
                                                FROM PricebookEntry
                                                WHERE Pricebook2Id = :pricebookForThisTest.Id AND Product2Id = :product2ForThisTest.Id
                                                LIMIT 1];

        System.assertEquals(120, pricebookEntryForThisTest.UnitPrice, 'PricebookEntryDataFactory.createPriceBookEntry should insert a PricebookEntry.');

    }
}