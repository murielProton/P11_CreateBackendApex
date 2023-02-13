/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class AccountDataFactory_Test {
    
    private static String nameLike = 'accountName-%';

    /**
    * @description Test method for AccountDataFactory.createAccountsList(5)
    * @author Muriel Proton | 13-02-2023 
    **/
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
        System.assertEquals( 5, accountsListToTest.size(), 'AccountDataFactory.createAccountsList should create 5 records of Accounts.');
    }
}