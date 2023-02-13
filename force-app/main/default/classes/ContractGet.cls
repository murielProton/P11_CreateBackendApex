/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class ContractGet {

    /**
    * @description Get method for all Contract records
    * @author Muriel Proton | 13-02-2023 
    * @return List<Contract> 
    **/
    public static List<Contract> getContractsAll() {
        checkPermissionContract();
        List<Contract> contractsListToReturn = [SELECT Id,
                                                        Name,
                                                        AccountId,
                                                        Status
                                                FROM Contract];

        return contractsListToReturn;
    }

    /**
    * @description Get method for Contract records linked to the Account Id passed as parametter
    * @author Muriel Proton | 13-02-2023 
    * @param ID 
    * @return List<Contract> 
    **/
    public static List<Contract> getContractsOfAccount(Id accountId){
        checkPermissionContract();
        List<Contract> contractsListToReturn = [SELECT Id,
                                                        Name,
                                                        AccountId,
                                                        Status
                                                FROM Contract
                                                WHERE AccountId = :AccountId];
        return contractsListToReturn;

    }

    /**
    * @description Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation) Apex PMD
    * @author Muriel Proton | 13-02-2023 
    **/
    private static void checkPermissionContract(){
        if( !Contract.SObjectType.getDescribe().isAccessible()){
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get a Contract record.');
        }
    }
}