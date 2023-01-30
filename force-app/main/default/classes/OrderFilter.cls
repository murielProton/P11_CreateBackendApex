/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
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

    public static Map<Id, Order> orderListFilterOrdersLinkedToProduct2(Set<Order> orderSet) {
        // TODO returns a Map of OrderItem ID and Order
        Map<Id, Order> orderItemIdOrderMap = new Map<Id, Order>();
        // Get OrderItem WHERE Order ID
        List<OrderItem> orderItemList = OrderItemGet.getOrderItemWhereProduct2AndOrderExist();
        //TODO transforme it into a Map
            for(Order orderCurent : orderSet){
                OrderItem orderCurentOld = orderItemMap.get(orderCurent.Id);
                if( orderCurentOld.Status == OrderId
                    && orderCurentNew.Status == 'Activated'){
                        orderSetToReturn.add(orderCurentNew);
                    }
            }

        return orderMapToReturn;
    }

    public static Map<Id, Order> orderListFilterOrdersLinkedToProduct2(Set<Order> orderSet) {
        // TODO returns a Map of ProductId and Order
        /*Map<Id, Order> orderMapToReturn = new Map<Id, Order>();

            for(Order orderCurentNew : orderListNew){
                Order orderCurentOld = orderMapOld.get(orderCurentNew.Id);
                if( orderCurentOld.Status == 'Draft'
                    && orderCurentNew.Status == 'Activated'){
                        orderSetToReturn.add(orderCurentNew);
                    }
            }*/

        return orderMapToReturn;
    }
}