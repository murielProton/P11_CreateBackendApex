/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class Product2Get_Test {
    @TestSetup
    static void setupProduct22Get(){
        Product2DataFactory.createProduct2();
    }
    @isTest
    static void testGetProduct2(){
        Test.startTest();
        List<Product2> product2ListToTest = Product2Get.getProduct2All();
        Test.stopTest();
        System.assertEquals(1, product2ListToTest.size(), 'Product2Get.getProduct2All should get at least one record of Product2.'); 
    }

    @isTest
    static void testGetProduct2ListByName(){

        Test.startTest();
        List<Product2> product2ListToTest = Product2Get.getProduct2ListByName('WIFI');
        Test.stopTest();

        System.assertEquals(1, product2ListToTest.size(), 'Product2Get.getProduct2ListByName should get at least one record of Product2.'); 

    }
}