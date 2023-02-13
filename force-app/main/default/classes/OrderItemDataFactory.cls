/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderItemDataFactory {

    public static OrderItem constructOneOrderItem(Id orderId, Id product2Id, Id pricebookEntryId){
        OrderItem orderItemToInsert = new OrderItem(
            OrderId = orderId,
            Quantity = 24,
            UnitPrice = 240,
            Product2Id = product2Id,
            PricebookEntryId = pricebookEntryId //Required
        );
        return orderItemToInsert;
    }

    public static void createOrderItemsList(List<Order> orderList, Id product2Id, Id pricebookEntryId){
        List<OrderItem> orderItemsList = new List<OrderItem>();
        for(Order orderCurrent : orderList){
            //(Order orderForThisTest, Product2 product2ForThisTest, PricebookEntry pricebookEntryForThisTest)
            orderItemsList.add(OrderItemDataFactory.constructOneOrderItem(orderCurrent.Id, product2Id, pricebookEntryId));
        }        
        if (Schema.sObjectType.OrderItem.fields.OrderId.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an OrderItem record.');
        }else{
            insert orderItemsList;
        }
    }
}