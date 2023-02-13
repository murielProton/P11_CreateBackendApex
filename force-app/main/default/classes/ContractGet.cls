/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class ContractGet {

    public static List<Contract> getContractsAll() {
        checkPermissionContract();
        List<Contract> contractsListToReturn = [SELECT Id,
                                                        Name,
                                                        AccountId,
                                                        Status
                                                FROM Contract];

        return contractsListToReturn;
    }

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

    private static void checkPermissionContract(){
        if( !Contract.SObjectType.getDescribe().isAccessible()){
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get a Contract reccord.');
        }
    }
}