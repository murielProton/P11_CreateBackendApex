/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class PricebookEntryDataFactory {
    
    public static void createPriceBookEntryForPricebookStandard(Product2 product2ForThisTest){
        PricebookEntry priceBookEntryToInsert = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product2ForThisTest.Id,
            UnitPrice = 100.00,
            IsActive = true
        );
        if (Schema.sObjectType.PricebookEntry.fields.IsActive.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert a PricebookEntry reccord.');
        }else{
            insert priceBookEntryToInsert;
        }
    }
}