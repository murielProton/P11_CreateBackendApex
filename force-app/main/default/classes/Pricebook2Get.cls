/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class Pricebook2Get {

    public static List<Pricebook2> getPriceBook2ListByName(String pricebookName){

        List<Pricebook2> pricebook2List = new List<Pricebook2>();

        if(Pricebook2.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Pricebook2.fields.Name.isAccessible() &&
            Schema.SObjectType.Pricebook2.fields.isActive.isAccessible()){
            pricebook2List = [SELECT Id,
                                    Name,
                                    isActive,
                                    IsStandard
                            FROM PriceBook2
                            WHERE Name = :pricebookName
                            ];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Pricebook2 reccord.');
        }
        return pricebook2List;
    }
}