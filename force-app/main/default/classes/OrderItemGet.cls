/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-02-2023
 * @last modified by  : Muriel Proton
 * OrderItem are linked to a Product2 by default. It is impossible to creat a record on OrderItem without a Product2 and a PricebookEntry.
**/
public with sharing class OrderItemGet {

    public static List<OrderItem> getOrderItemListAll(){

        List<OrderItem> orderItemList = new List<OrderItem>();

        if(OrderItem.SObjectType.getDescribe().isAccessible() &&
        Schema.SObjectType.OrderItem.fields.Product2Id.isAccessible() &&
        Schema.SObjectType.OrderItem.fields.OrderId.isAccessible()){
            orderItemList = [SELECT Id, 
                                OrderId,
                                Product2Id,
                                PricebookEntryId
                        FROM OrderItem];
        } else {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to get an OrderItem reccord.');
        }
        return orderItemList;
        
    }

}