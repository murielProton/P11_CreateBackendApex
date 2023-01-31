/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderTriggerHelper {
    /*TODO Create methodes That do :
        display a message for the user
        message value : "'vous devez saisir un Product2 sur l'enregistrement Order '+orderName"*/
    public static void orderTriggerHelper(Map<Order>  orderMapOld, List<Order> orderListNew) {
        // If the field Status value changes from Draft to Activated
        Set<Order> orderSet = OrderFilter.orderListFilterStatusDraftToActivated(orderMapOld, orderListNew)
        // Check if the record on Order is linked to a Product2
        OrderFilter.orderListFilterOrdersLinkedToProduct2(Set<Order> orderSet);
        //display a message for the user
        //RecordName.Order.adError('messsage Here !');
    }
}  