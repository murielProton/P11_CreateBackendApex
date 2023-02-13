/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class AccountGet {

    /**
    * @description Get method for all the records on Account with the name passed as parametter
    * @author Muriel Proton | 13-02-2023 
    * @param String 
    * @return Account 
    **/
    public static Account getAccountByName(String accountName){
        
        Account accountToReturn;
        checkPermissionAccount();
        accountToReturn = [SELECT Id,
                                        Name
                                    FROM Account
                                    WHERE Name= :accountName 
                                    LIMIT 1];
        return accountToReturn;
    }

    /**
    * @description Get method for all the records on Account
    * @author Muriel Proton | 13-02-2023 
    * @return List<Account> 
    **/
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

    /**
    * @description Get all Account records linked to a record on Order, in the list of Orders passed as parametter
    * @author Muriel Proton | 13-02-2023 
    * @param List<Order> 
    * @return Set<Account> 
    **/
    public static Set<Account> getAccontsLinkedToOrders(List<Order> orderList){
        List<Account> accoutListToReturn = new List<Account>();
        // transform a list of orders into a list of orders id
        Set<Id> accountIDList = new Set<Id>();
        for (Order orderCurrent : orderList){
            accountIDList.add(orderCurrent.accountId);
        }
        return getAccontsByIds(accountIDList);
    }

    /**
    * @description Get all Account records which have the same Ids as the one in the Set passed as parametter.
    * @author Muriel Proton | 13-02-2023 
    * @param Set<Id>
    * @return Set<Account> 
    **/
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

    /**
    * @description Get all Account records where the field Active__c is true
    * @author Muriel Proton | 13-02-2023 
    * @return List<Account> 
    **/
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

    /**
    * @description Get all Account records where the field Active__c is false
    * @author Muriel Proton | 13-02-2023 
    * @return List<Account> 
    **/
    public static List<Account> getAccountActiveFalse(){
        List<Account> accoutListToReturn = new List<Account>();
        checkPermissionAccount();
        accoutListToReturn = [SELECT Id,
                                     Name,
                                     Active__c
                                FROM Account
                                WHERE Active__c = false];
        return accoutListToReturn;
    }
    
    /**
    * @description Get all Account records not linked to a record on Order
    * @author Muriel Proton | 13-02-2023 
    * @param Set<Id>
    * @return List<Account> 
    **/
    public static List<Account> getAccontsNOTLinkedToOrders(Set<Id> accountIDSetOfAllDeletedOrders){
        List<ID> accountIDListOfAllDeletedOrders = new List<ID>(accountIDSetOfAllDeletedOrders);
        List<Order> orderList = OrderGet.getOrdersAll();
        List<ID> accountIDListOfAllOrders = new List<ID>();
        for(Order orderCurrent : orderList){
            if(!accountIDListOfAllOrders.contains(orderCurrent.AccountId)){
                accountIDListOfAllOrders.add(orderCurrent.AccountId);
            }
        }
        checkPermissionAccount();
        List<Account> accoutListToReturn =[SELECT Id,
                                                    Name,
                                                    Active__c
                                            FROM Account
                                            WHERE Id NOT IN :accountIDListOfAllOrders
                                            AND Id IN :accountIDListOfAllDeletedOrders];
        return accoutListToReturn;
    }
    
    /**
    * @description Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation) Apex PMD
    * @author Muriel Proton | 13-02-2023 
    **/
    private static void checkPermissionAccount(){
        if( !Account.SObjectType.getDescribe().isAccessible() 
            || !Schema.SObjectType.Account.fields.Name.isAccessible()
            || !Schema.SObjectType.Account.fields.Active__c.isAccessible()
        ){
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Account record.');
        }
    }
}