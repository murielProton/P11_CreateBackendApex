/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountDataFactory {
    
    public static void createAccountsList(Integer numberOfAccounts){
        List<Account> accountsListToInsertForTest = new List<Account>();
        for(Integer i = 0 ; i < numberOfAccounts ; i++){
            accountsListToInsertForTest.add(new Account(Name = 'AccountName-'+i));
        }
        if (Schema.sObjectType.Account.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Account reccord.');
        }else{
            insert accountsListToInsertForTest;
        }
    }
}