/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 07-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class AccountUpdate {
    public static void updateAccountFieldActive(List<Account> accountList) {
        List<Account> accountListToUpdate = new List<Account>();

        for(Account accountCurent : accountList){
            if(accountCurent.Active__c != true
            && !accountListToUpdate.contains(accountCurent)){
                accountCurent.Active__c = true;
                accountListToUpdate.add(accountCurent);
            }
        }
        if (Schema.sObjectType.Account.fields.Active__c.isUpdateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to update the field Active__c on Account records.');
         }else{
            update accountListToUpdate;
        }
        
    }
}