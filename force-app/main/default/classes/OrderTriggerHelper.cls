/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderTriggerHelper {
    
    public static List<Order> getOrderListToUpdate(Map<Id, Order>  orderMapOld, List<Order> orderListNew) {
        // If the field Status value changes from Draft to Activated
        Set<Order> orderSetStatusChanged = OrderFilter.orderListFilterStatusDraftToActivated(orderMapOld, orderListNew);
        // Check if the record on Order is linked to a Product2
        Set<Order> orderSetLinkedToProduct = OrderFilter.orderListFilterLinkedToProduct2(orderSetStatusChanged);
        // convert Set To List
        List<Order> orderListToReturn = OrderFormat.transformSetToList(orderSetLinkedToProduct);
        return orderListToReturn;
    }
    /*TODO 
    methode to get the list of Order records to display error message*/
    public static void displayMessageForEachOrderNotValid(List<Order> orderList){
        for(Order orderCurent : orderList){
            //Trigger.new[0].myField__c.addError('bad');
            orderCurent.addError('Avant de pouvoir passer le statut de '+orderCurent.Name+', il doit être associé à un produit (Product2).');
        }
    }
    /*TODO 
    methode to update the right list and send the message to the others*/
}  