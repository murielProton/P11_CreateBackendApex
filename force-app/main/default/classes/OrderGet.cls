/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderGet {

    public static List<Order> getOrdersAll(){

        List<Order> orderList = new List<Order>();

        if(Order.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.Order.fields.Name.isAccessible() &&
        Schema.SObjectType.Order.fields.Status.isAccessible()){
            orderList = [SELECT Id, 
                                AccountId,
                                Status
                        FROM Order];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order reccord.');
        }
        return orderList;
    }

    public static List<Order> getOrdersWhereStatusActivated(){

        List<Order> orderList = new List<Order>();

        if(Order.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.Order.fields.Name.isAccessible() &&
        Schema.SObjectType.Order.fields.Status.isAccessible()){
            orderList = [SELECT Id, 
                                AccountId,
                                Status
                        FROM Order
                        WHERE Status = 'Activated'];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order reccord.');
        }
        return orderList;
    }

    public static List<Order> getOrderWithOrderItem(List<id> orderIdList){
        List<Order> orderListToReturn = [SELECT Id,
                                        (SELECT Id, Product2Id, OrderId
                                        FROM OrderItems
                                        WHERE Product2Id != null)
                                FROM Order
                                WHERE Id IN: orderIdList];
        return orderListToReturn;
    }

    public static List<Order> getOrderByAccountAndContract(Id accountId, Id contractId){
        List<Order> orderList = new List<Order>();

        if(Order.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.Order.fields.Name.isAccessible() &&
        Schema.SObjectType.Order.fields.Status.isAccessible()){
            orderList = [SELECT Id, 
                                AccountId,
                                Status,
                                ContractId
                        FROM Order
                        WHERE AccountId = :accountId
                        AND ContractId = :contractId];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order reccord.');
        }
        return orderList;
        
    }
    /* as an OrderItem cannot be created without an Procuct2, 
    and a PricebookEntry cannot be created without a Product2 and a Pricebook2,
    an Order without a Pricebook2 has no Product attached.*/
    public static List<Order> getOrderWhereNOPricebook2(){
        List<Order> orderList = new List<Order>();

        if(Order.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.Order.fields.Name.isAccessible() &&
        Schema.SObjectType.Order.fields.Status.isAccessible()){
            orderList = [SELECT Id, 
                                AccountId,
                                Status,
                                ContractId
                        FROM Order
                        WHERE Pricebook2Id = Null];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order reccord.');
        }
        return orderList;
        
    }
    public static List<Order> getOrderWherePricebook2Exist(){
        List<Order> orderList = new List<Order>();

        if(Order.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.Order.fields.Name.isAccessible() &&
        Schema.SObjectType.Order.fields.Status.isAccessible()){
            orderList = [SELECT Id, 
                                AccountId,
                                Status,
                                ContractId
                        FROM Order
                        WHERE Pricebook2Id != Null];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order reccord.');
        }
        return orderList;
        
    }
}