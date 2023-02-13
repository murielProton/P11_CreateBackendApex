/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class ContractUpdate_Test {
    
    String accountName = 'AccountName-0';
    
    /**
    * @description TestSetup for ContractUpdate_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupContractUpdate(){
        //Create an Account
        AccountDataFactory.createAccountsList(1);
        List<Account> accountsListForThisTest = AccountGet.getAccountsAll();
        //create a Contract for this Account
        ContractDataFactory.createContractsList(accountsListForThisTest);
    }

    /**
    * @description Test method for ContractUpdate.updateContractsStatusToActivated(contractsList)
    * @author Muriel Proton | 13-02-2023 
    **/
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