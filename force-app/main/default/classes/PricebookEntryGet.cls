/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class PricebookEntryGet {
    // Product must be active and added to Pricebook first

    public static List<PricebookEntry> getPricebookEntryByPricebook2AndProduct2(Id pricebookIdForThisTest, Id product2IdForThisTest){
        List<PricebookEntry> pricebookEntryListToReturn = new List<PricebookEntry>();
        if(PricebookEntry.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.PricebookEntry.fields.Name.isAccessible() &&
        Schema.SObjectType.PricebookEntry.fields.isActive.isAccessible()){
            pricebookEntryListToReturn = [SELECT Id,
                                                Name,
                                                Pricebook2Id,
                                                Product2Id,
                                                UnitPrice,
                                                UseStandardPrice,
                                                IsActive
                                        FROM PricebookEntry
                                        WHERE Pricebook2Id = :pricebookIdForThisTest AND Product2Id = :product2IdForThisTest
                                        ];
        }else{
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get a PricebookEntry record.');
        }
        return pricebookEntryListToReturn;
    }

}