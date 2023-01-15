/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class AccountGet_Test {

    private static String accountName = 'AccountName-';

    @TestSetup
    static void setupForTestGetAccount(){
        AccountDataFactory.createAccountsList(5);
    }

    @isTest
    public static void testGetAccount(){
                
        Test.startTest();
        Account accountToTest = AccountGet.getAccount(accountName+3);
        Test.stopTest();

        System.assertEquals(accountName+3, accountToTest.name, 'getAccount(accountName) from AccountDataFactory should return only one Account record by the name of :'+accountName+3+'.');
    }
    @isTest
    public static void testGetAccountsAll(){
        
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccountsAll();
        Test.stopTest();

        System.assertEquals( 5, accountsListToTest.size(),'AccountDataFactory.getAccountsAll() should return a list of five records.');
    }
}