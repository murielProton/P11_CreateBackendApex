/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderUpdate {

    /**
    * @description Update method changes Status field to Activated on Order
    * @author Muriel Proton | 13-02-2023 
    * @param List<Order> 
    **/
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