/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-01-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderTriggerHandler extends TriggerHandler {
    List<Order> orderListOld =(List<Order>)Trigger.old;
    List<Order> orderListNew =(List<Order>)Trigger.new;
    
    Map<Id, Order> orderMapOld = (Map<Id, Order>)Trigger.oldMap;
    Map<Id, Order> orderMapNew = (Map<Id, Order>)Trigger.newMap;

    public override void beforeUpdate() {
        /*Add a methode from OrderTrigerHelper That doese :
        If the field Status value changes from Draft to Activated
        Check if the record on Order is linked to a Product2
        display a message for the user
        message value : "'vous devez saisir un Product2 sur l'enregistrement Order '+orderName"
        OrderTriggerHelper.methodName(orderListNew, orderListOld);*/
        OrderTriggerHelper.updateOrSendErrorOnOrder(orderMapOld, orderListNew);
    }
    
}