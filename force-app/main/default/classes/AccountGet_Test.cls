/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class AccountGet_Test {

    private static String accountName = 'AccountName-';

    @TestSetup
    static void setupAccountGet(){
        AccountDataFactory.createAccountsList(5);
    }

    @isTest
    public static void testGetAccount(){
                
        Test.startTest();
        Account accountToTest = AccountGet.getAccount(accountName+3);
        Test.stopTest();

        System.assertEquals(accountName+3, accountToTest.name, 'getAccount(accountName) from AccountGet should return only one Account record by the name of :'+accountName+3+'.');
    }
    @isTest
    public static void testGetAccountsAll(){
        
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccountsAll();
        Test.stopTest();

        System.assertEquals( 5, accountsListToTest.size(),'AccountGet.getAccountsAll() should return a list of five records.');
    }
    @isTest
    public static void testGetAccontsLinkedToOrders(){
        List<Account> accountList = AccountGet.getAccountsAll();
        ContractDataFactory.createContractsList(accountList);
        List<Contract> contractListToCreateOrders = ContractGet.getContractsAll();
        // Now make sure the Salesforce process doese create a standard Pricebook2
        Pricebook2 pricebookStandardToUpdate = new PriceBook2 (
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        //Execute an update DML on the Pricebook2 record, to make IsStandard to true
        update pricebookStandardToUpdate; 
        List<PriceBook2> pricebook2ListALL = Pricebook2Get.getPriceBook2All();  
        PriceBook2 pricebook2Standard = Pricebook2Get.getPriceBook2Standard();
        OrderDataFactory.createOrdersListForEachContract(contractListToCreateOrders, pricebook2Standard);
        List<Order> orderList = OrderGet.getOrdersAll();

        System.debug('list size Contract '+contractListToCreateOrders.size());
        System.debug('list size Order '+orderList.size());
        Test.startTest();
        Set<Account> accountsListToTest = AccountGet.getAccontsLinkedToOrders(orderList);
        Test.stopTest();

        System.assertEquals( 5, accountsListToTest.size(),'AccountGet.getAccontsLinkedToOrders() should return a list of five records.');
    }
}