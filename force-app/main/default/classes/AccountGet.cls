/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class AccountGet {

    public static Account getAccount(String accountName){
        
        Account accountToReturn;
        checkPermissionAccount();
        accountToReturn = [SELECT Id,
                                        Name
                                    FROM Account
                                    WHERE Name= :accountName 
                                    LIMIT 1];
        return accountToReturn;
    }

    public static List<Account> getAccountsAll(){
        List<Account> accountsList = new List<Account>();
        checkPermissionAccount();
        accountsList = [SELECT Id,
                               Name,
                               Active__c
                        FROM Account
                        ];
        return accountsList;
    }

    public static Set<Account> getAccontsLinkedToOrders(List<Order> orderList){
        List<Account> accoutListToReturn = new List<Account>();
        // transform a list of orders into a list of orders id
        Set<Id> accountIDList = new Set<Id>();
        for (Order orderCurent : orderList){
            accountIDList.add(orderCurent.accountId);
        }
        return getAccontsByIds(accountIDList);
    }

    public static Set<Account> getAccontsByIds(Set<Id> accountIDSet){
        List<Account> accoutListToReturn = new List<Account>();
        checkPermissionAccount();
        accoutListToReturn = [SELECT Id,
                                    Name,
                                    Active__c
                                FROM Account
                                WHERE Id IN :accountIDSet];
        Set<Account> accoutSetToReturn  = new Set<Account>(accoutListToReturn);
        return accoutSetToReturn;
    }
    public static List<Account> getAccountActiveTrue(){
        List<Account> accoutListToReturn = new List<Account>();
        checkPermissionAccount();
        accoutListToReturn = [SELECT Id,
                                     Name,
                                     Active__c
                                FROM Account
                                WHERE Active__c = true];
        return accoutListToReturn;
    }

    private static void checkPermissionAccount(){
        if( !Account.SObjectType.getDescribe().isAccessible() 
            || !Schema.SObjectType.Account.fields.Name.isAccessible()
            || !Schema.SObjectType.Account.fields.Active__c.isAccessible()
        ){
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Account reccord.');
        }
    }
}