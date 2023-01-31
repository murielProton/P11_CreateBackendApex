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
        return new Set<Order>(orderList);
    }

    public static List<Order> transformSetToList(Set<Order> orderSet) {
        return new List<Order>(orderSet);
    }

    public static Map<Id, Order> transformSetToMap(Set<Order> orderSet) {
        Map<Id, Order> orderMapToReturn = new Map<Id, Order>();
        for(Order orderCurent : orderSet){
            orderMapToReturn.put(orderCurent.Id, orderCurent);
        }
        return orderMapToReturn;
    }

}