/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
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
        //Declare the Set to return
        List<Order> orderListToReturn = new List<Order>();

        // return a List of OrderItems when the OrderItem is linked to a Product2 and an Order
        List<OrderItem> orderItemList = OrderItemGet.getOrderItemWhereProduct2AndOrderExist();
        // convert the list to a Map<OrderItem.OrderId, OrderItem>
        Map<Id, OrderItem> orderItemMap = OrderItemFormat.transformListToMapOrderIdOrderItem(orderItemList);

        // transforme it into a Set of Order
            for(Order orderCurent : orderList){
                OrderItem orderCurentOld = orderItemMap.get(orderCurent.Id);
                orderListToReturn.add(orderCurent);
            }
        return orderListToReturn;
    }

}