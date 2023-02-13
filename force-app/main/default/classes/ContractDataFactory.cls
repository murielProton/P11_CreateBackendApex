/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class ContractDataFactory {

    public static Contract constructContract(Id accountID){
        Contract contract = new Contract(
                AccountId = accountID,
                //can't create a contract with the Status set to Activated
                Status = 'Draft',
                StartDate = Date.today(),
                ContractTerm = 6
            );
            return contract;
    }

    public static void createContractsList(List<Account> accountsList){
        List<Contract> contractsList = new List<Contract>();

        for(Account accountCurrent : accountsList){
            contractsList.add(constructContract(accountCurrent.Id));
        }

        if (Schema.sObjectType.Contract.fields.Status.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert a Contract record.');
        }else{
            insert contractsList;
        }
    }

}