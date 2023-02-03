/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderTriggerHelper {

    public static void updateOrSendErrorOnOrder(Map<Id, Order> orderMapOld, List<Order> orderListNew){
        // If the field Status value changes from Draft to Activated
        List<Order> orderListStatusChanged = OrderFilter.orderListFilterStatusDraftToActivated(orderMapOld, orderListNew);

        // get the list of orders you need to update
        List<Order> orderListUpdatable = OrderFilter.orderListFilterLinkedToProduct2(orderListStatusChanged);
        // No need to update because we are used in a before update !!
        
        // get the list for the error messages
        Set<Order> oderSetUnupdatable = new Set<Order>(orderListStatusChanged);
        oderSetUnupdatable.removeAll(orderListUpdatable);
        List<Order> oderListUnupdatable = new List<Order>(oderSetUnupdatable);
        // send error messages
        displayMessageForEachOrderNotValid(oderListUnupdatable);
    }

    /*methode connot be tested without a mock
    methode to get the list of Order records to display error message*/
    public static void displayMessageForEachOrderNotValid(List<Order> orderList){
        for(Order orderCurent : orderList){
            //sObject.addError('bad');
            orderCurent.addError('Avant de pouvoir passer le statut de '+orderCurent.Name+', il doit être associé à un produit (Product2).');
        }
    }

}  