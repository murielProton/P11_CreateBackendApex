/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class Pricebook2DataFactory {

    private static String pricebook2Name = 'France Price Book';

    
    /**
    * @description insert Pricebook2 one record 
    * @author Muriel Proton | 13-02-2023 
    * Warning : If you create a Pricebook it must be active and standard, but the field Standard is not wrightable.
    **/
    public static void createPricebook2(){
        List<PriceBook2> pricebook2ToInsertForTest = new List<PriceBook2>();
        pricebook2ToInsertForTest.add( new PriceBook2 (
            Name = pricebook2Name,
            IsActive = true
        ));
        if (Schema.sObjectType.PriceBook2.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an PriceBook2 record.');
        }else{
            insert pricebook2ToInsertForTest;
        }
        
    }
}