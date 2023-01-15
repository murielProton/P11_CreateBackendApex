/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ContractGet {

    public List<Contract> getContractsList() {
        List<Contract> contractsListToReturn = new List<Contract>();

        if(Contract.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Contract.fields.Name.isAccessible()
        ){
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