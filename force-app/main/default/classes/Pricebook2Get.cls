/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class Pricebook2Get {

    /**
    * @description 
    * @author Muriel Proton | 13-02-2023 
    * @param pricebookName 
    * @return List<Pricebook2> 
    **/
    public static List<Pricebook2> getPriceBook2ListByName(String pricebookName){
        checkPermissionPricebook2();
        List<Pricebook2> pricebook2List = [SELECT Id,
                                                Name,
                                                isActive,
                                                IsStandard
                                            FROM PriceBook2
                                            WHERE Name = :pricebookName];
        return pricebook2List;
    }

    /**
    * @description 
    * @author Muriel Proton | 13-02-2023 
    * @return List<Pricebook2> 
    **/
    public static List<Pricebook2> getPriceBook2All(){
        checkPermissionPricebook2();
        List<Pricebook2> pricebook2List = [SELECT Id,
                                                Name,
                                                isActive,
                                                IsStandard
                                        FROM PriceBook2];
        return pricebook2List;
    }

    /**
    * @description Get method for one Standard PriceBook2
    * @author Muriel Proton | 13-02-2023 
    * @return Pricebook2 
    **/
    public static Pricebook2 getPriceBook2Standard(){
        checkPermissionPricebook2();
        Pricebook2 pricebook2 = [SELECT Id,
                                        Name,
                                        isActive,
                                        IsStandard
                                FROM PriceBook2
                                WHERE IsStandard = true
                                LIMIT 1];
        return pricebook2;
    }

    /**
    * @description Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation) Apex PMD
    * @author Muriel Proton | 13-02-2023 
    **/
    private static void checkPermissionPricebook2(){
        if( !Pricebook2.SObjectType.getDescribe().isAccessible() 
            || !Schema.SObjectType.Pricebook2.fields.Name.isAccessible()
            || !Schema.SObjectType.Pricebook2.fields.isActive.isAccessible()
        ){
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get a Pricebook2 record.');
        }
    }
}