/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
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
                        WHERE Status = :'Activated'];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an Order reccord.');
        }
        return orderList;
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
}