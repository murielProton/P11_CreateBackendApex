/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
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

    public static void createOrderItemsList(List<Order> orderList, Id product2Id, Id pricebookEntryId){
        List<OrderItem> orderItemsList = new List<OrderItem>();
        for(Order orderCurent : orderList){
            //(Order orderForThisTest, Product2 product2ForThisTest, PricebookEntry pricebookEntryForThisTest)
            orderItemsList.add(OrderItemDataFactory.constructOneOrderItem(orderCurent.Id, product2Id, pricebookEntryId));
        }
        insert orderItemsList;
    }
}