/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 07-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class AccountUpdate {
    public static void updateAccountFieldActiveTrue(List<Account> accountList) {
        List<Account> accountListToUpdate = new List<Account>();

        for(Account accountCurent : accountList){
            if(accountCurent.Active__c != true
            && !accountListToUpdate.contains(accountCurent)){
                accountCurent.Active__c = true;
                accountListToUpdate.add(accountCurent);
            }
        }
        checkPermissionAndUpdateAccount(accountListToUpdate);        
    }

    public static void updateAccountFieldActiveFalse(List<Account> accountList) {
        List<Account> accountListToUpdate = new List<Account>();

        for(Account accountCurent : accountList){
            if(accountCurent.Active__c == true
            && !accountListToUpdate.contains(accountCurent)){
                accountCurent.Active__c = false;
                accountListToUpdate.add(accountCurent);
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