/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderItemDataFactory {

    public static OrderItem constructOneOrderItem(Id orderId, Id product2Id, Id pricebookEntryId){
        OrderItem orderItemToInsert = new OrderItem(
            OrderId = orderId,
            Quantity = 24,
            UnitPrice = 240,
            Product2Id = product2Id,
            PricebookEntryId = pricebookEntryId
        );
        return orderItemToInsert;
    }

    public static void createOrderItemssList(Integer numberOfOrderItems, Id orderId, Id product2Id, Id pricebookEntryId){
        List<OrderItem> orderItemsListToInsert = new List<OrderItem>();
        for(Integer i = 0 ; i < numberOfOrderItems ; i++){
            orderItemsListToInsert.add(constructOneOrderItem(orderId, product2Id, pricebookEntryId));
        }
        if (Schema.sObjectType.OrderItem.fields.Quantity.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an OrderItem reccord.');
        }else{
            insert orderItemsListToInsert;
        }
    }
}