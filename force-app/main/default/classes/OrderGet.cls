/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-02-2023
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
                                ContractId,
                                Pricebook2Id,
                                Status
                        FROM Order];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order reccord.');
        }
        return orderList;
    }

    public static List<Order> getOrderWithOrderItem(List<id> orderIdList){
        List<Order> orderListToReturn = [SELECT Id,
                                                Name,
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
                                Name,
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
}