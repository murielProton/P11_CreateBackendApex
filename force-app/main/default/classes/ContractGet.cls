/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-16-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ContractGet {

    public static List<Contract> getContractsAll() {
        List<Contract> contractsListToReturn = new List<Contract>();

        if(Contract.SObjectType.getDescribe().isAccessible()){
            contractsListToReturn = [SELECT Id,
                                            Name
                                     FROM Contract
                                    ];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get Contract reccords.');
        }
        return contractsListToReturn;
    }
}