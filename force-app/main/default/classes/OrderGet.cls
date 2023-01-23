/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderGet {

    public static List<Order> getOrdersAll(){
        List<Order> orderList = [SELECT Id, 
                                        AccountId,
                                        Status
                                  FROM Order];
        return orderList;
    }

    public static List<Order> getOrdersWhereStatusActivated(){
        List<Order> orderList = [SELECT Id, 
                                        AccountId,
                                        Status
                                  FROM Order
                                  WHERE Status = :'Activated'];
        return orderList;
    }
}