/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class OrderDataFactory_Test {

    private static String accountName = 'accountName-0';
    private static String pricebook2Name = 'France Price Book';
    private static String orderName = '042';

    @TestSetup
    static void setupForOrderDataFactory_test(){
        //Create a List of Accounts
        AccountDataFactory.createAccountsList(1);
        List<Account> accountListForTest = AccountGet.getAccountsAll();
        //create a Contract for this Account
        ContractDataFactory.createContractsList(accountListForTest);
        // Make sure the Pricebook2 entry is active and standard
        Pricebook2DataFactory.createPricebook2();  
    }

    @isTest
    static void testConstructOneOrder(){
        // get sObjects for Test
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];
        List<Account> accountListForTest = AccountGet.getAccountsAll();
        Account accountForThisTest = accountListForTest[0];
        List<Contract> contractListForThisTest = ContractGet.getContractsAll();
        Contract contractForThisTest = contractListForThisTest[0];

        Test.startTest();
        Order orderForThisTest = OrderDataFactory.constructOneOrder(orderName, accountForThisTest.ID, contractForThisTest.ID, pricebookForThisTest);
        Test.stopTest();

        System.assertEquals( 'Draft', orderForThisTest.Status, 'OrderDataFactory.constructOneOrder should create one order.');
    }

    @isTest
    static void testCreateOrdersListForEachContract(){
        //TODO correct this methode
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name)[0];
        List<Account> accountListForTest = AccountGet.getAccountsAll();
        Account accountForThisTest = accountListForTest[0];
        List<Contract> contractsListToUpdate = ContractGet.getContractsAll();
        // The Order must have at least one Product, so we can change Order.Status to Ordered
        // Link these accounts to some products = for each accounts create a contract + create pricebook custom + create pricebook standard + create products + create price book entry + create order
        // for each accounts create a contract 
        ContractUpdate.updateContractsStatusToActivated(contractsListToUpdate);
        
        System.debug('Pricebook '+ pricebookForThisTest);
        System.debug('accountForThisTest '+ accountForThisTest);

        List<Contract> contractListForForTest = ContractGet.getContractsAll();
        System.debug('contractListForForTest '+ contractListForForTest);
        Test.startTest();
        OrderDataFactory.createOrdersListForEachContract(contractListForForTest, pricebookForThisTest);
        Test.stopTest();

        List<Order> orderListForThisTest = OrderGet.getOrdersAll();
        System.debug('orderListForThisTest '+ orderListForThisTest);

        System.assertEquals(1, orderListForThisTest.size(), 'OrderDataFactory.createOrdersListForEachContract should reate a list of records on Order.');
    }
}