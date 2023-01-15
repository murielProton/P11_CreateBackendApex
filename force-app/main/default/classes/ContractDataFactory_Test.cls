/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class ContractDataFactory_Test {
    
    private static String accountName = 'accountName-0';

    @TestSetup
    static void setupForContract(){
        //Create an Account
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsList = AccountGet.getAccountsAll();
    }

    @isTest
    static void testConstructContract(){
        Account accountForTest = AccountGet.getAccount(accountName);
        Test.startTest();
        Contract contractToTest = ContractDataFactory.constructContract(accountForTest.Id);
        Test.stopTest();
        System.assertEquals(accountForTest.Id, contractToTest.AccountId, 'ContractDataFactory.constructContract(accountID) should construct one Contract.');
    }

    @isTest
    static void testCreateContractsList(){
        List<Account> accountsList = AccountGet.getAccountsAll();
        Test.startTest();
        ContractDataFactory.createContractsList(accountsList);
        Test.stopTest();
        List<Contract> contractsListToTest = [SELECT Id,
                                                     AccountId
                                              FROM Contract 
                                             ];
        System.assertEquals(5, contractsListToTest.size(), 'ContractDataFactory.createContractsList(accountToTest) should create 5 Contracts, one for each Accounts created.');
    }
}