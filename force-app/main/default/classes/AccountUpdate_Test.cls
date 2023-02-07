/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 07-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class AccountUpdate_Test {

    @TestSetup
    static void setupAccountUpdate() {
        AccountDataFactory.createAccountsList(5);
    }

    @isTest
    public static void testUpdateAccountFieldActive(){
        List<Account> accountListToUpdate = AccountGet.getAccountsAll();

        Test.startTest();
        AccountUpdate.updateAccountFieldActive(accountListToUpdate);
        Test.stopTest();

        List<Account> accountListToTest = AccountGet.getAccountsAll();

        System.assertEquals(true, accountListToTest[0].Active__c,'updateAccountFieldActive(List<Account> accountList) Should update field Active__c to true on all accounts.');
    }
}