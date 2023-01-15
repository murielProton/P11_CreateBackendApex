/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class AccountDataFactory_Test {
    
    private static String nameLike = 'accountName-%';

    @isTest
    public static void testCreateAccountsList(){
        Test.startTest();
        AccountDataFactory.createAccountsList(5);
        Test.stopTest();
        List<Account> accountsListToTest = [SELECT Id,
                                                   Name
                                            FROM Account
                                            WHERE Name LIKE :nameLike
                                           ];
        System.assertEquals(accountsListToTest.size(), 5, 'AccountDataFactory.createAccountsList should create 5 records of Accounts.');
    }
}