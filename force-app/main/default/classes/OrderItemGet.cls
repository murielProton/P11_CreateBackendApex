/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderItemGet {
    public static List<OrderItem> getOrderItemByOrderProductPricebookEntry(Id orderId, Id product2Id, Id pricebookEntryId){

        List<OrderItem> orderItemList = new List<OrderItem>();

        if(OrderItem.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.OrderItem.fields.Product2Id.isAccessible() &&
        Schema.SObjectType.OrderItem.fields.OrderId.isAccessible()){
            orderItemList = [SELECT Id, 
                                OrderId,
                                Product2Id,
                                PricebookEntryId
                        FROM OrderItem
                        WHERE OrderId = :orderId
                        AND Product2Id = :product2Id
                        AND PricebookEntryId = :pricebookEntryId];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an OrderItem reccord.');
        }
        return orderItemList;
        
    }
}