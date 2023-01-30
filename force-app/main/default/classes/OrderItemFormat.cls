/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderItemFormat {

    public static Map<Id, OrderItem> transformListToMap(List<OrderItem> orderItemList) {
        Map<Id, OrderItem> orderItemMapToReturn = new Map<Id, OrderItem>();
        for(OrderItem orderItemCurent : orderItemList){
            if(! orderItemMapToReturn.containsKey(orderItemCurent.Id)){
                orderItemMapToReturn.put(orderItemCurent.Id, orderItemCurent);
            }
        }
        return orderItemMapToReturn;
    }
}