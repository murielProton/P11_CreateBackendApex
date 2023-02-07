/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class ContractGet_Test {

    @TestSetup
    static void setupContractGet(){
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsList = AccountGet.getAccountsAll();
        ContractDataFactory.createContractsList(accountsList);
    }

    @isTest
    public static void testGetContractsAll(){
        
        Test.startTest();
        List<Contract> contractsListToTest = ContractGet.getContractsAll();
        Test.stopTest();

        System.assertEquals( 5, contractsListToTest.size(),'ContractGet.getContractsAll() should return a list of five records.');
    }
    @isTest
    public static void testGetContractsOfAccount(){

        String accountName = 'AccountName-0';
        Id accountId = AccountGet.getAccountByName(accountName).Id;

        Test.startTest();
        List<Contract> contractsListToTest = ContractGet.getContractsOfAccount(accountId);
        Test.stopTest();

        System.assertEquals( 1, contractsListToTest.size(),'ContractGet.getContractsOfAccount(accountId) should return a list of one records.');
    }
}