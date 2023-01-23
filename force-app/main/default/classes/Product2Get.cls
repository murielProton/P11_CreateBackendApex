/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class Product2Get {

    public static List<Product2> getProduct2All(){
        List<Product2> product2ListToReturn = new List<Product2>();
        if(Product2.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.Product2.fields.Name.isAccessible() &&
        Schema.SObjectType.Product2.fields.isActive.isAccessible()){
            product2ListToReturn = [SELECT Id,
                                                Name,
                                                IsActive
                                        FROM Product2
                                        ];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Pricebook2 reccord.');
        }
        return product2ListToReturn;
    }
    public static List<Product2> getProduct2ByName(String product2Name){
        List<Product2> product2ListToReturn = new List<Product2>();
        if(Product2.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.Product2.fields.Name.isAccessible() &&
        Schema.SObjectType.Product2.fields.isActive.isAccessible()){
            product2ListToReturn = [SELECT Id,
                                                Name,
                                                IsActive
                                        FROM Product2
                                        WHERE Name = :product2Name];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get a Pricebook2 reccord.');
        }
        return product2ListToReturn;
    }

}