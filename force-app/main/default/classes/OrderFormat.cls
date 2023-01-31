/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderFormat {

    public static Map<Id, Order> transformListToMap(List<Order> orderList) {
        Map<Id, Order> orderMapToReturn = new Map<Id, Order>();
        for(Order orderCurent : orderList){
            if(! orderMapToReturn.containsKey(orderCurent.Id)){
                orderMapToReturn.put(orderCurent.Id, orderCurent);
            }
        }
        return orderMapToReturn;
    }

    public static Set<Order> transformListToSet(List<Order> orderList) {
        Set<Order> orderSetToReturn = new Set<Order>();
        for(Order orderCurent : orderList){
            orderSetToReturn.add(orderCurent);
        }
        return orderSetToReturn;
    }

    public static List<Order> transformSetToList(Set<Order> orderSet) {
        List<Order> orderListToReturn = new List<Order>();
        for(Order orderCurent : orderSet){
            orderListToReturn.add(orderCurent);
        }
        return orderListToReturn;
    }

}