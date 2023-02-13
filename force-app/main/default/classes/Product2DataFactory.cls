/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class Product2DataFactory {

    private static String productName = 'WIFI';

    /**
    * @description Insert method for one record on Product2 
    * @author Muriel Proton | 13-02-2023 
    **/
    public static void createProduct2(){
        List<Product2> productsToInsertFortTest = new List<Product2>();
        productsToInsertFortTest.add(new Product2 (
            Name = productName,
            IsActive = true
        ));
        if (Schema.sObjectType.Product2.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Product2 record.');
        }else{
            insert productsToInsertFortTest;
        }
    }
}