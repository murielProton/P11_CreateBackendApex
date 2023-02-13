/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class Product2Get_Test {
    /**
    * @description TestSetup Product2Get_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupProduct22Get(){
        Product2DataFactory.createProduct2();
    }
    /**
    * @description Test method for List<Product2> product2ListToTest = Product2Get.getProduct2All()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetProduct2(){
        Test.startTest();
        List<Product2> product2ListToTest = Product2Get.getProduct2All();
        Test.stopTest();
        System.assertEquals(1, product2ListToTest.size(), 'Product2Get.getProduct2All should get at least one record of Product2.'); 
    }

    /**
    * @description Test method for List<Product2> product2ListToTest = Product2Get.getProduct2ListByName(product2Name)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetProduct2ListByName(){

        Test.startTest();
        List<Product2> product2ListToTest = Product2Get.getProduct2ListByName('WIFI');
        Test.stopTest();

        System.assertEquals(1, product2ListToTest.size(), 'Product2Get.getProduct2ListByName should get at least one record of Product2.'); 

    }
}