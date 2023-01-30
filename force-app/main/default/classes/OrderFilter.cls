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
                System.debug('orderCurentOld.Status => '+orderCurentOld.Status);
                System.debug('orderCurentOld.Status == "Draft" => '+(orderCurentOld.Status == 'Draft'));
                System.debug('orderCurentOld.Status.equals("Draft") => '+(orderCurentOld.Status.equals('Draft')));
                System.debug('orderCurentNew.Status => '+orderCurentNew.Status);
                if( orderCurentOld.Status == 'Draft'
                    && orderCurentNew.Status == 'Activated'){
                        orderSetToReturn.add(orderCurentNew);
                    }
            }

        return orderSetToReturn;
    }
}