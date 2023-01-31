/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderFilter {

    public static Set<Order> orderListFilterStatusDraftToActivated(Map<Id, Order> orderMapOld, List<Order> orderListNew) {

        Set<Order> orderSetToReturn = new Set<Order>();

            for(Order orderCurentNew : orderListNew){
                Order orderCurentOld = orderMapOld.get(orderCurentNew.Id);
                if( orderCurentOld.Status == 'Draft'
                    && orderCurentNew.Status == 'Activated'){
                        orderSetToReturn.add(orderCurentNew);
                    }
            }

        return orderSetToReturn;
    }

    public static Set<Order> orderListFilterLinkedToProduct2(Set<Order> orderSet) {
        //Declare the Set to return
        Set<Order> orderSetToReturn = new Set<Order>();

        // return a List of OrderItems when the OrderItem is linked to a Product2 and an Order
        List<OrderItem> orderItemList = OrderItemGet.getOrderItemWhereProduct2AndOrderExist();
        // convert the list to a Map<OrderItem.OrderId, OrderItem>
        Map<Id, OrderItem> orderItemMap = OrderItemFormat.transformListToMapOrderIdOrderItem(orderItemList);

        // transforme it into a Map Product2.Id Order
            for(Order orderCurent : orderSet){
                OrderItem orderCurentOld = orderItemMap.get(orderCurent.Id);
                orderSetToReturn.add(orderCurent);
            }
        return orderSetToReturn;
    }

    /*public static Map<Id, Order> orderListFilterOrdersLinkedToProduct2(Set<Order> orderSet) {
        // TODO returns a Map of ProductId and Order
        Map<Id, Order> orderMapToReturn = new Map<Id, Order>();

            for(Order orderCurentNew : orderListNew){
                Order orderCurentOld = orderMapOld.get(orderCurentNew.Id);
                if( orderCurentOld.Status == 'Draft'
                    && orderCurentNew.Status == 'Activated'){
                        orderSetToReturn.add(orderCurentNew);
                    }
            }

        return orderMapToReturn;
    }*/
}