/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderGet {

    /**
    * @description Get methdod all records on Order
    * @author Muriel Proton | 13-02-2023 
    * @return List<Order> 
    **/
    public static List<Order> getOrdersAll(){
        checkPermissionOrder();
        List<Order> orderList = [SELECT Id, 
                                        AccountId,
                                        ContractId,
                                        Pricebook2Id,
                                        Status
                                FROM Order];
        return orderList;
    }

    /**
    * @description Get methdod Order records with the field Status set to Activated
    * @author Muriel Proton | 13-02-2023 
    * @return List<Order> 
    **/
    public static List<Order> getOrdersWhereStatusActivated(){
        checkPermissionOrder();
        List<Order> orderList = [SELECT Id,
                                        Name,
                                        AccountId,
                                        Status
                                FROM Order
                                WHERE Status = 'Activated'];
        return orderList;
    }

    /**
    * @description Get methdod Order records with the Id of the list passed as parametter
    * @author Muriel Proton | 13-02-2023 
    * @param orderIdList 
    * @return List<Order> 
    **/
    public static List<Order> getOrderWithOrderItem(List<id> orderIdList){
        checkPermissionOrder();
        List<Order> orderListToReturn = [SELECT Id,
                                                Name,
                                                (SELECT Id, Product2Id, OrderId
                                                FROM OrderItems
                                                WHERE Product2Id != null)
                                FROM Order
                                WHERE Id IN: orderIdList];
        return orderListToReturn;
    }

    /**
    * @description Get method Order records linked to both parametters Account Id and Contract ID
    * @author Muriel Proton | 13-02-2023 
    * @param Id 
    * @param Id 
    * @return List<Order> 
    **/
    public static List<Order> getOrderByAccountAndContract(Id accountId, Id contractId){
        checkPermissionOrder();
        List<Order> orderList = [SELECT Id,
                                        Name,
                                        AccountId,
                                        Status,
                                        ContractId
                                FROM Order
                                WHERE AccountId = :accountId
                                AND ContractId = :contractId];
        return orderList;  
    }

    /**
    * @description Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation) Apex PMD
    * @author Muriel Proton | 13-02-2023 
    **/
    private static void checkPermissionOrder(){
        if( !Order.SObjectType.getDescribe().isAccessible() 
            || !Schema.SObjectType.Order.fields.Name.isAccessible()
            || !Schema.SObjectType.Order.fields.AccountId.isAccessible()
        ){
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order record.');
        }
    }

}