/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderFilter {

    public static List<Order> orderListFilterStatusDraftToActivated(Map<Id, Order> orderMapOld, Map<Id, Order> orderMapNew) {
        Set<Order> orderSetToReturn = new Set<Order>();
            for(Order orderCurrentNew : orderMapNew.values()){
                Order orderCurrentOld = orderMapOld.get(orderCurrentNew.Id);
                if( orderCurrentOld.Status == 'Draft'
                    && orderCurrentNew.Status == 'Activated'){
                        orderSetToReturn.add(orderCurrentNew);
                    }
            }
        return new List<Order>(orderSetToReturn);
    }

    public static List<Order> orderListFilterNOTLinkedToProduct2(List<Order> orderList) {
        //Declare the List to return
        List<Order> orderListToReturn = new List<Order>();
        // transform a list of orders into a list of orders id
        List<Id> orderIdList = new List<Id>(new Map<Id, SObject> (orderList).keySet());
        // return a List of OrderItems when the OrderItem is linked to a Product2 and an Order
        List<Order> orderWithOrderItem = OrderGet.getOrderWithOrderItem(orderIdList);

        // transforme it into a Set of Order
        for(Order orderCurrent : orderWithOrderItem){
            if(orderCurrent.orderItems.size() == 0){
                orderListToReturn.add(orderCurrent);
            }
        }
        return orderListToReturn;
    }

}