/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class Pricebook2DataFactory_Test {
    /**
    * @description Test method for Pricebook2DataFactory.createPricebook2()
    * @author Muriel Proton | 13-02-2023 
    **/
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