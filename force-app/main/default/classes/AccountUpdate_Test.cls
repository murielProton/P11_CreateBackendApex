/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class AccountUpdate_Test {

    /**
    * @description TestSetup for AccountUpdate_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupAccountUpdate() {
        AccountDataFactory.createAccountsList(5);
    }

    /**
    * @description test method for AccountUpdate.updateAccountFieldActiveToTrue(accountListToUpdate)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testUpdateAccountFieldActiveToTrue(){
        List<Account> accountListToUpdate = AccountGet.getAccountsAll();

        Test.startTest();
        AccountUpdate.updateAccountFieldActiveToTrue(accountListToUpdate);
        Test.stopTest();

        List<Account> accountListToTest = AccountGet.getAccountsAll();

        System.assertEquals(true, accountListToTest[0].Active__c,'updateAccountFieldActiveToTrue(List<Account> accountList) Should update field Active__c to true on all accounts.');
    }
    
    /**
    * @description test method for AccountUpdate.updateAccountFieldActiveToFalse(accountListToUpdate)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testUpdateAccountFieldActiveToFalse(){
        List<Account> accountListToUpdate = AccountGet.getAccountsAll();
        AccountUpdate.updateAccountFieldActiveToTrue(accountListToUpdate);

        Test.startTest();
        AccountUpdate.updateAccountFieldActiveToFalse(accountListToUpdate);
        Test.stopTest();

        List<Account> accountListToTest = AccountGet.getAccountsAll();

        System.assertEquals(false, accountListToTest[0].Active__c,'updateAccountFieldActiveToFalse(List<Account> accountList) Should update field Active__c to false on all accounts.');
    }
}