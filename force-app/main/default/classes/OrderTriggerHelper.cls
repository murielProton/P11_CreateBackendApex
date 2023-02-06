/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderTriggerHelper {

    public static void sendErrorOnOrder(Map<Id, Order> orderMapOld, Map<Id, Order> orderMapNew){
        // If the field Status value changes from Draft to Activated
        List<Order> orderListStatusChanged = OrderFilter.orderListFilterStatusDraftToActivated(orderMapOld, orderMapNew);
        // the update part is done without intervention
        // No need to update because we are used in a before update !!

        // get the list for the error messages
        List<Order> oderListUnupdatable = OrderFilter.orderListFilterNOTLinkedToProduct2(orderListStatusChanged);
        // send error messages 
        displayMessageForEachOrderNotValid(oderListUnupdatable, orderMapNew);

    }

    /* Methode has to be used within a condition or with a specified list */
    public static void displayMessageForEachOrderNotValid(List<Order> orderList, Map<Id, Order> orderMapNew){
        for(Order orderCurent : orderList){
            //We need a map here cause we are using this in trigger !!
            //sObject.addError('bad');
            Order orderToAddErrorTo = orderMapNew.get(orderCurent.Id);
            orderToAddErrorTo.addError('Avant de pouvoir passer le statut à /"Activated/" de '+orderCurent.Name+', il doit être associé à un produit (Product2).');
        }
    }

}  