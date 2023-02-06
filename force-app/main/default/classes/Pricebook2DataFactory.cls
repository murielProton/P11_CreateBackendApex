/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class Pricebook2DataFactory {

    private static String pricebook2Name = 'France Price Book';

    //If you create a Pricebook it must be active and standard, but the field Standard is not wrightable.
    public static void createPricebook2(){
        List<PriceBook2> pricebook2ToInsertForTest = new List<PriceBook2>();
        pricebook2ToInsertForTest.add( new PriceBook2 (
            Name = pricebook2Name,
            IsActive = true
        ));
        if (Schema.sObjectType.PriceBook2.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an PriceBook2 reccord.');
        }else{
            insert pricebook2ToInsertForTest;
        }
        
    }
    //Instantiate the Pricebook2 record with StandardPricebookId
    // this is only usable in TEST ENVRIONMENT
    public static void createPricebook2Standard(){
        List<PriceBook2> pricebook2ToInsertForTest = new List<PriceBook2>();
        pricebook2ToInsertForTest.add( new PriceBook2 (
            Name = 'Standard Pricebook',
            Id = Test.getStandardPricebookId(),
            IsActive = true
        ));
        if (Schema.sObjectType.PriceBook2.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an PriceBook2 reccord.');
        }else{
            insert pricebook2ToInsertForTest;
        }
        
    }
}