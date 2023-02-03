/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderFilter {

    public static List<Order> orderListFilterStatusDraftToActivated(Map<Id, Order> orderMapOld, List<Order> orderListNew) {
        Set<Order> orderSetToReturn = new Set<Order>();
            for(Order orderCurentNew : orderListNew){
                Order orderCurentOld = orderMapOld.get(orderCurentNew.Id);
                if( orderCurentOld.Status == 'Draft'
                    && orderCurentNew.Status == 'Activated'){
                        orderSetToReturn.add(orderCurentNew);
                    }
            }
        return new List<Order>(orderSetToReturn);
    }

    public static List<Order> orderListFilterLinkedToProduct2(List<Order> orderList) {
        //Declare the List to return
        List<Order> orderListToReturn = new List<Order>();
        // transform a list of orders into a list of orders id
        List<Id> orderIdList = new List<Id>(new Map<Id, SObject> (orderList).keySet());
        // return a List of OrderItems when the OrderItem is linked to a Product2 and an Order
        List<Order> orderWithOrderItem = OrderGet.getOrderWithOrderItem(orderIdList);

        // transforme it into a Set of Order
        for(Order orderCurent : orderWithOrderItem){
            if(orderCurent.orderItems.size() > 0){
                orderListToReturn.add(orderCurent);
            }
        }
        return orderListToReturn;
    }

}