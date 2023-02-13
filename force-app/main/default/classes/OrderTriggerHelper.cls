/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderTriggerHelper {

    public static void sendErrorOnOrder(Map<Id, Order> orderMapOld, Map<Id, Order> orderMapNew){
        // If the field Status value changes from Draft to Activated
        List<Order> orderListStatusChanged = OrderFilter.orderListFilterStatusDraftToActivated(orderMapOld, orderMapNew);
        // the update part is done without intervention
        // No need to update because this method is used in a before update !!

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
    
    public static void updateAccountActiveIfLinkedToOrder(List<Order> orderList){
        // get the right list to update
        Set<Account> accountSetToUpdate = AccountGet.getAccontsLinkedToOrders(orderList);
        List<Account> accountListToUpdate = new List<Account>(accountSetToUpdate);

        // update this list
        AccountUpdate.updateAccountFieldActiveToTrue(accountListToUpdate);
    }

    //USE in Trigger After DELETE
    public static void updateAccountActiveIfOrderDelete(List<Order> orderList){
        // get the list of Accounts of the deleted Orders
        Set<Account> accountsSetOfDeletedOrders = AccountGet.getAccontsLinkedToOrders(orderList);
        Set<ID> accountIDSetOfAllDeletedOrders = new  Set<ID>();
        for(Account accountCurent : accountsSetOfDeletedOrders){
            accountIDSetOfAllDeletedOrders.add(accountCurent.Id);
        }

         // Get the list of Accounts that have NO Orders Linked to them
         List<Account> accountListToUpdateActiveToFalse = AccountGet.getAccontsNOTLinkedToOrders(accountIDSetOfAllDeletedOrders);
        // update this List Account Field Active__c to False
        AccountUpdate.updateAccountFieldActiveToFalse(accountListToUpdateActiveToFalse);
        System.debug('etape update account faite !');
    }
}  