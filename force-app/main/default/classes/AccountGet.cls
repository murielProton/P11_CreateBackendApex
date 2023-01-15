/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountGet {

    public static Account getAccount(String accountName){
        
        Account accountToReturn;

        if(Account.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Account.fields.Name.isAccessible() &&
            Schema.SObjectType.Account.fields.Phone.isAccessible()
        ){
            accountToReturn = [SELECT Id,
                                            Name
                                        FROM Account
                                        WHERE Name= :accountName 
                                        LIMIT 1];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Account reccord.');
        }
        return accountToReturn;
    }

    public static List<Account> getAccountsAll(){

        List<Account> accountsList = new List<Account>();

        if(Account.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Account.fields.Name.isAccessible() &&
            Schema.SObjectType.Account.fields.Phone.isAccessible()
        ){
            accountsList = [SELECT Id,
                                   Name
                            FROM Account
                            ];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Account reccord.');
        }
        return accountsList;
    }
}