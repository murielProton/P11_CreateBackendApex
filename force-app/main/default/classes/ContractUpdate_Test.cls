/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class ContractUpdate_Test {
    
    String accountName = 'AccountName-0';
    
    @TestSetup
    static void setupForContract_TestDataFactory_Test(){
        //Create an Account
        AccountDataFactory.createAccountsList(1);
        List<Account> accountsListForThisTest = AccountGet.getAccountsAll();
        //create a Contract for this Account
        ContractDataFactory.createContractsList(accountsListForThisTest);
    }

    @isTest
    static void testUpdateContractsListStatusToActivated(){
        // Get variables for the test
        List<Contract> contractsList = ContractGet.getContractsAll();

        Test.startTest();
        ContractUpdate.updateContractsStatusToActivated(contractsList);
        Test.stopTest();

        List<Contract> contractsListToTest = [SELECT Status
                                                FROM Contract 
                                                WHERE Status = 'Activated'
                                                ];

        System.assertEquals(contractsListToTest[0].Status, 'Activated', 'ContractUpdate.updateContractsStatusToActivated should update one Contracts with a Status set to Activated.');
    }
}