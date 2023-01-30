/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderUpdate {

    public static void updateOrdersStatusToActivated(List<Order> ordersList) {
        List<Order> ordersListToUpdate = new List<Order>();
        for(Order orderCurrent : ordersList){
            orderCurrent.Status = 'Activated';
            ordersListToUpdate.add(orderCurrent);
        }
        if (Schema.sObjectType.Order.fields.Status.isUpdateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to update the field Status on Order records.');
         }else{
            update ordersListToUpdate;
        }
    }
    
}