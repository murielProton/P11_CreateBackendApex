/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderTriggerHandler extends TriggerHandler {
    List<Order> orderListNew =(List<Order>)Trigger.new;
    List<Order> orderListOld =(List<Order>)Trigger.old;

    public override void beforeUpdate() {
        /*TODO Add a methode from OrderTrigerHelper That doese :
        If the field Status value changes from Draft to Activated
        Check if the record on Order is linked to a Product2
        display a message for the user
        message value : "'vous devez saisir un Product2 sur l'enregistrement Order '+orderName"
        OrderTriggerHelper.methodName(orderListNew, orderListOld);*/
    }
    
}