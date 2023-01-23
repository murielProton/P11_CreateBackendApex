/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

@isTest
public with sharing class Pricebook2Get_Test {

    private static String pricebook2Name = 'France Price Book';

    @TestSetup
    static void setupPricebook2Get(){
        Pricebook2DataFactory.createPricebook2();
    }

    @isTest
    static void testGetPriceBook2ByName(){

        Test.startTest();
        List<Pricebook2> pricebook2ListToTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name);
        Test.stopTest();

        System.assertEquals(1, pricebook2ListToTest.size(), 'Pricebook2Get.getPriceBook2ByName should return one PriceBook2.');
    }
}