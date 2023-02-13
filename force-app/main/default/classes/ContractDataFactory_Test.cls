/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class ContractDataFactory_Test {
    
    private static String accountName = 'accountName-0';

    /**
    * @description TestSetup for ContractDataFactory_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupContractDataFactory(){
        //Create an Account
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsList = AccountGet.getAccountsAll();
    }

    /**
    * @description Test method for ContractDataFactory.constructContract(accountForTest.Id)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testConstructContract(){
        Account accountForTest = AccountGet.getAccountByName(accountName);
        Test.startTest();
        Contract contractToTest = ContractDataFactory.constructContract(accountForTest.Id);
        Test.stopTest();
        System.assertEquals(accountForTest.Id, contractToTest.AccountId, 'ContractDataFactory.constructContract(accountID) should construct one Contract.');
    }

    /**
    * @description Test method for ContractDataFactory.createContractsList(accountsList)
    * @author Muriel Proton | 13-02-2023 
    **/
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