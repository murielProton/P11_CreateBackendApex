/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class Product2DataFactory {

    private static String productName = 'WIFI';

    public static void createProduct2(){
        List<Product2> productsToInsertFortTest = new List<Product2>();
        productsToInsertFortTest.add(new Product2 (
            Name = productName,
            IsActive = true
        ));
        if (Schema.sObjectType.Product2.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Product2 reccord.');
        }else{
            insert productsToInsertFortTest;
        }
    }
}