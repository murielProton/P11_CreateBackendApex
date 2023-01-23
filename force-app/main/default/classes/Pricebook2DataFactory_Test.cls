/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-16-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class Pricebook2DataFactory_Test {
    @isTest
    static void testCreatePricebook2(){
        Test.startTest();
        Pricebook2DataFactory.createPricebook2(); 
        Test.stopTest();

        List<Pricebook2> pricebook2ListToTest = [SELECT Id,
                                              Name,
                                              isActive,
                                              IsStandard
                                        FROM PriceBook2
                                       ];

        System.assertEquals(1, pricebook2ListToTest.size(), 'Pricebook2DataFactory.CreatePricebook2 should create one PriceBook2.');

    }
}