/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class PricebookEntryDataFactory_Test {

    @TestSetup
    static void setupPricebookEntryDataFactory() {
        Pricebook2DataFactory.createPricebook2();
        Product2DataFactory.createProduct2();
    }

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
}