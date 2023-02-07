/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-02-2023
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
    public static void testGetAccountByName(){
                
        Test.startTest();
        Account accountToTest = AccountGet.getAccountByName(accountName+3);
        Test.stopTest();

        System.assertEquals(accountName+3, accountToTest.name, 'getAccountByName(accountName) from AccountGet should return only one Account record by the name of :'+accountName+3+'.');
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

        Test.startTest();
        Set<Account> accountsListToTest = AccountGet.getAccontsLinkedToOrders(orderList);
        Test.stopTest();

        System.assertEquals( 5, accountsListToTest.size(),'AccountGet.getAccontsLinkedToOrders() should return a list of five records.');
    }
    @isTest
    public static void testGetAccountsById(){
        Set<Id> accountIDSet = new Set<Id>();
        List<Account> accountList = AccountGet.getAccountsAll();
        for(Account accountCurent : accountList){
            accountIDSet.add(accountCurent.Id);
        }
        
        Test.startTest();
        Set<Account> accountsSetToTest = AccountGet.getAccontsByIds(accountIDSet);
        Test.stopTest();

        System.assertEquals( accountList.size(), accountsSetToTest.size(),'AccountGet.getAccontsByIds(accountIDSet) should return a list of five records.');
    }
    @isTest
    public static void testGetAccountActiveTrue(){
        List<Account> accountList = AccountGet.getAccountsAll();
        AccountUpdate.updateAccountFieldActiveToTrue(accountList);
        
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccountActiveTrue();
        Test.stopTest();

        System.assertEquals( accountList.size(), accountsListToTest.size(),'AccountGet.getAccountActiveTrue() should return a list of five records.');
    }
    @isTest
    public static void testGetAccountActiveFalse(){
        List<Account> accountList = AccountGet.getAccountsAll();
        AccountUpdate.updateAccountFieldActiveToFalse(accountList);
        
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccountActiveFalse();
        Test.stopTest();

        System.assertEquals( accountList.size(), accountsListToTest.size(),'AccountGet.getAccountActiveFalse() should return a list of five records.');
    }
    @isTest
    public static void testGetAccountNotLinkedToOrders(){
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
        System.debug('orderList ' + orderList);
        System.debug('orderList ' + orderList);
        Set<Id> orderIDSetAll = new Set<Id>();
        for (Order orderCurent : orderList){
            orderIDSetAll.add(orderCurent.Id);
        }
        insert new Account(Name = 'AccountName-6');
        List<Account> accountsList = AccountGet.getAccountsAll();
        Set<Id> accountIDSetOfAllDeletedOrders = new Set<Id>();
        for(Account accountCurent : accountsList){
            accountIDSetOfAllDeletedOrders.add(accountCurent.Id);
        }
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccontsNOTLinkedToOrders(accountIDSetOfAllDeletedOrders);
        Test.stopTest();

        System.assertEquals( 1, accountsListToTest.size(),'AccountGet.getAccontsNOTLinkedToOrders(Set<Id>, List<Accounts>) should return a list of 1 record.');
    }
}