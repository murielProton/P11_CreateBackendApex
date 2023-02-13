/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class Product2DataFactory_Test {
    /**
    * @description Test method for Product2DataFactory.createProduct2()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testCreateProduct2(){

        Test.startTest();
        Product2DataFactory.createProduct2();
        Test.stopTest();

        List<Product2> product2toTest = Product2Get.getProduct2All();

        System.assertEquals(1, product2toTest.size(), 'Product2DataFactory.createProduct2 should crete at least one record of Product2.'); 
    }
}