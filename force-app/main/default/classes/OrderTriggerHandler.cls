/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderTriggerHandler extends TriggerHandler {
    List<Order> orderListOld =(List<Order>)Trigger.old;
    List<Order> orderListNew =(List<Order>)Trigger.new;
    
    Map<Id, Order> orderMapOld = (Map<Id, Order>)Trigger.oldMap;
    Map<Id, Order> orderMapNew = (Map<Id, Order>)Trigger.newMap;

    public override void afterInsert() {
        /*If Account is linked To the Order
        AND If the checkbox 'Active' on Account is not checked
        check the checkbox 'Active'*/
        // TODO get all records on Account that are linked to an Order
    }
    public override void beforeUpdate() {
        /*Add a methode from OrderTrigerHelper That doese :
        If the field Status value changes from Draft to Activated
        Check if the record on Order is linked to a Product2
        display a message for the user
        message value : "'vous devez saisir un Product2 sur l'enregistrement Order '+orderName"
        OrderTriggerHelper.methodName(orderListNew, orderListOld);*/
        OrderTriggerHelper.sendErrorOnOrder(orderMapOld, orderMapNew);
    }
}