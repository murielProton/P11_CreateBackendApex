/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ContractGet {

    public static List<Contract> getContractsAll() {
        List<Contract> contractsListToReturn = new List<Contract>();

        if(Contract.SObjectType.getDescribe().isAccessible()){
            contractsListToReturn = [SELECT Id,
                                            Name,
                                            AccountId
                                     FROM Contract
                                    ];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get Contract reccords.');
        }
        return contractsListToReturn;
    }

    public static List<Contract> getContractsOfAccount(Id accountId){
        List<Contract> contractsListToReturn = new List<Contract>();

        if(Contract.SObjectType.getDescribe().isAccessible()){
            contractsListToReturn = [SELECT Id,
                                            Name,
                                            AccountId
                                     FROM Contract
                                     WHERE AccountId = :AccountId
                                    ];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get Contract reccords.');
        }
        return contractsListToReturn;

    }
}