/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderFormat {

    public static Map<Id, Order> orderFormatListToMap(List<Order> orderList) {
        Map<Id, Order> orderMapToReturn = new Map<Id, Order>();
        for(Order orderCurent : orderList){
            if(! orderMapToReturn.containsKey(orderCurent.Id)){
                orderMapToReturn.put(orderCurent.Id, orderCurent);
            }
        }
        return orderMapToReturn;
    }

}