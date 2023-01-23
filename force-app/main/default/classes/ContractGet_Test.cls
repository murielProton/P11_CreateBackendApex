/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class ContractGet_Test {

    @TestSetup
    static void setupForTestGetContract(){
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
}