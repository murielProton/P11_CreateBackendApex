/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-02-2023
 * @last modified by  : Muriel Proton
**/
trigger OrderTrigger on Order (before update) {
    new OrderTriggerHandler().run();
}