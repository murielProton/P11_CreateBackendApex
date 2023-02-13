/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class ContractGet_Test {

    /**
    * @description TestSetup for ContractGet_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupContractGet(){
        AccountDataFactory.createAccountsList(5);
        List<Account> accountsList = AccountGet.getAccountsAll();
        ContractDataFactory.createContractsList(accountsList);
    }

    /**
    * @description Test method for ContractGet.getContractsAll()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testGetContractsAll(){
        
        Test.startTest();
        List<Contract> contractsListToTest = ContractGet.getContractsAll();
        Test.stopTest();

        System.assertEquals( 5, contractsListToTest.size(),'ContractGet.getContractsAll() should return a list of five records.');
    }
    /**
    * @description Test method for ContractGet.getContractsOfAccount(accountId)
    * @author Muriel Proton | 13-02-2023 
    **/
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