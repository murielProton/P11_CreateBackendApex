/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/

public with sharing class ContractUpdate {
    /**
    * @description Update Method to change field Status to Activated on Contract List records passed as parametter
    * @author Muriel Proton | 13-02-2023 
    * @param List<Contract> 
    **/
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