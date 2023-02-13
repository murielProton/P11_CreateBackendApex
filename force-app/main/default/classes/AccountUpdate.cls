/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class AccountUpdate {
    public static void updateAccountFieldActiveToTrue(List<Account> accountList) {
        List<Account> accountListToUpdate = new List<Account>();

        for(Account accountCurrent : accountList){
            if(accountCurrent.Active__c != true
            && !accountListToUpdate.contains(accountCurrent)){
                accountCurrent.Active__c = true;
                accountListToUpdate.add(accountCurrent);
            }
        }
        checkPermissionAndUpdateAccount(accountListToUpdate);        
    }

    public static void updateAccountFieldActiveToFalse(List<Account> accountList) {
        List<Account> accountListToUpdate = new List<Account>();

        for(Account accountCurrent : accountList){
            if(accountCurrent.Active__c == true
            && !accountListToUpdate.contains(accountCurrent)){
                accountCurrent.Active__c = false;
                accountListToUpdate.add(accountCurrent);
            }
        }
        checkPermissionAndUpdateAccount(accountListToUpdate);
    }

    public static void checkPermissionAndUpdateAccount(List<Account> accountListToUpdate){
        if (Schema.sObjectType.Account.fields.Active__c.isUpdateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to update the field Active__c on Account records.');
        }else{
            update accountListToUpdate;
        }
    }
}