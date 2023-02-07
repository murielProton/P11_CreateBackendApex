/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-02-2023
 * @last modified by  : Muriel Proton
**/
trigger OrderTrigger on Order (after insert, before update, after delete) {
    new OrderTriggerHandler().run();
}