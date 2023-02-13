/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class PricebookEntryDataFactory {
    
    /**
    * @description Insert method for one record on PricebookEntry, with only Product2
    * @author Muriel Proton | 13-02-2023 
    * @param Product2 
    **/
    public static void createPriceBookEntryForPricebookStandard(Product2 product2ForThisTest){
        PricebookEntry priceBookEntryToInsert = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product2ForThisTest.Id,
            UnitPrice = 100.00,
            IsActive = true,
            UseStandardPrice = false
        );
        checkPermissionPricebookEntry(priceBookEntryToInsert);
    }
    
    /**
    * @description Insert method for one record on PricebookEntry, with 2 parametters
    * @author Muriel Proton | 13-02-2023 
    * @param PriceBook2 
    * @param Product2 
    **/
    public static void createPriceBookEntry(PriceBook2 pricebookForThisTest, Product2 product2ForThisTest){
        PricebookEntry priceBookEntryToInsert = new PricebookEntry(
            Pricebook2Id = pricebookForThisTest.Id,
            Product2Id = product2ForThisTest.Id,//required field
            UnitPrice = 120.00,
            IsActive = true,
            UseStandardPrice = false
        );
        checkPermissionPricebookEntry(priceBookEntryToInsert);
    }
    /**
    * @description Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation) Apex PMD
    * @author Muriel Proton | 13-02-2023 
    * @param priceBookEntryToInsert 
    **/
    public static void checkPermissionPricebookEntry(PricebookEntry priceBookEntryToInsert){
        if (!Schema.sObjectType.PricebookEntry.fields.UnitPrice.isCreateable()) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert a PricebookEntry record.');
        }else{
            insert priceBookEntryToInsert;
        }
    }
}