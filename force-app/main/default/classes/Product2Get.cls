/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class Product2Get {

    public static List<Product2> getProduct2All(){
        checkPermissionProduct2();
        List<Product2> product2ListToReturn = [SELECT Id,
                                                        Name,
                                                        IsActive
                                                FROM Product2];
        return product2ListToReturn;
    }
    
    public static List<Product2> getProduct2ListByName(String product2Name){
        checkPermissionProduct2();
        List<Product2> product2ListToReturn = [SELECT Id,
                                                        Name,
                                                        IsActive
                                                FROM Product2
                                                WHERE Name = :product2Name];
        return product2ListToReturn;
    }

    private static void checkPermissionProduct2(){
        if( !Product2.SObjectType.getDescribe().isAccessible() 
            || !Schema.SObjectType.Product2.fields.Name.isAccessible()
            || !Schema.SObjectType.Product2.fields.isActive.isAccessible()
        ){
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Product2 record.');
        }
    }
}