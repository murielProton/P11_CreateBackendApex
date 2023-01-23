/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-16-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
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
}