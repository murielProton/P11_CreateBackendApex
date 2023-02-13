/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
trigger OrderTrigger on Order (after insert, before update, after delete) {
    new OrderTriggerHandler().run();
}