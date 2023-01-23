/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

public with sharing class ContractUpdate {
    public static void updateContractsStatusToActivated(List<Contract> contractsList) {
        List<Contract> contractsListToUpdate = new List<Contract>();
        for(Contract contractCurrent : contractsList){
            //can't create a contract with the Status set to Activated
            contractCurrent.Status = 'Activated';
            contractsListToUpdate.add(contractCurrent);
        }
        if (Schema.sObjectType.Contract.fields.Status.isUpdateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to update the field Status on Contract records.');
         }else{
            update contractsListToUpdate;
        }
    }
}