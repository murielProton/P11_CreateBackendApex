/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/

@isTest
public with sharing class Pricebook2Get_Test {

    private static String pricebook2Name = 'France Price Book';

    /**
    * @description TestSetup for Pricebook2Get_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupPricebook2Get(){
        Pricebook2DataFactory.createPricebook2();
    }

    /**
    * @description Test method for Pricebook2Get.getPriceBook2ListByName(pricebook2Name)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetPriceBook2ByName(){

        Test.startTest();
        List<Pricebook2> pricebook2ListToTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name);
        Test.stopTest();

        System.assertEquals(1, pricebook2ListToTest.size(), 'Pricebook2Get.getPriceBook2ByName should return one PriceBook2.');
    }
}