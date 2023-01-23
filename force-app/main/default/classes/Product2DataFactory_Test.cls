/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class Product2DataFactory_Test {
    @isTest
    static void testCreateProduct2(){

        Test.startTest();
        Product2DataFactory.createProduct2();
        Test.stopTest();

        List<Product2> product2toTest = Product2Get.getProduct2All();

        System.assertEquals(1, product2toTest.size(), 'Product2DataFactory.createProduct2 should crete at least one record of Product2.'); 
    }
}