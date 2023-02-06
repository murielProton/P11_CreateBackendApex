/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-02-2023
 * @last modified by  : Muriel Proton
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
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get a Pricebook2 reccord.');
        }
        return pricebook2List;
    }
    public static List<Pricebook2> getPriceBook2All(){

        List<Pricebook2> pricebook2List = [SELECT Id,
                                    Name,
                                    isActive,
                                    IsStandard
                            FROM PriceBook2
                            ];
        return pricebook2List;
    }
    public static Pricebook2 getPriceBook2Standard(){

        Pricebook2 pricebook2 = [SELECT Id,
                                    Name,
                                    isActive,
                                    IsStandard
                            FROM PriceBook2
                            WHERE IsStandard = true
                            LIMIT 1
                            ];
        return pricebook2;
    }
}