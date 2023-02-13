/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class AccountGet_Test {

    private static String accountName = 'AccountName-';

    /**
    * @description TestSetup for AccountGet_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupAccountGet(){
        AccountDataFactory.createAccountsList(5);
    }

    /**
    * @description Test method for AccountGet.getAccountByName(accountName+3)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testGetAccountByName(){
                
        Test.startTest();
        Account accountToTest = AccountGet.getAccountByName(accountName+3);
        Test.stopTest();

        System.assertEquals(accountName+3, accountToTest.name, 'getAccountByName(accountName) from AccountGet should return only one Account record by the name of :'+accountName+3+'.');
    }

    /**
    * @description Test method for AccountGet.getAccountsAll()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testGetAccountsAll(){
        
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccountsAll();
        Test.stopTest();

        System.assertEquals( 5, accountsListToTest.size(),'AccountGet.getAccountsAll() should return a list of five records.');
    }

    /**
    * @description Test method for AccountGet.getAccontsLinkedToOrders(orderList)
    * @author Muriel Proton | 13-02-2023 
    **/
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

    /**
    * @description Test method for AccountGet.getAccontsByIds(accountIDSet)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testGetAccontsByIds(){
        List<Account> accountList = AccountGet.getAccountsAll();
        Set<Id> accountIDSet = new Map<Id,Account>(accountList).keySet();

        Test.startTest();
        Set<Account> accountsListToTest = AccountGet.getAccontsByIds(accountIDSet);
        Test.stopTest();

        System.assertEquals( accountIDSet.size(), accountsListToTest.size(),'AccountGet.getAccontsByIds(accountIDSet) should return a set of records of all the IDs in parametter.');
    }


    /**
    * @description Test method for AccountGet.getAccountActiveTrue()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testGetAccountActiveTrue(){
        List<Account> accountList = AccountGet.getAccountsAll();
        AccountUpdate.updateAccountFieldActiveToTrue(accountList);
        
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccountActiveTrue();
        Test.stopTest();

        System.assertEquals( accountList.size(), accountsListToTest.size(),'AccountGet.getAccountActiveTrue() should return a list of five records.');
    }

    /**
    * @description Test method for AccountGet.getAccountActiveFalse()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testGetAccountActiveFalse(){
        List<Account> accountList = AccountGet.getAccountsAll();
        AccountUpdate.updateAccountFieldActiveToFalse(accountList);
        
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccountActiveFalse();
        Test.stopTest();

        System.assertEquals( accountList.size(), accountsListToTest.size(),'AccountGet.getAccountActiveFalse() should return a list of five records.');
    }
    
    /**
    * @description Test method for AccountGet.getAccontsNOTLinkedToOrders(accountIDSetOfAllDeletedOrders)
    * @author Muriel Proton | 13-02-2023 
    **/
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
        Set<Id> orderIDSetAll = new Set<Id>();
        for (Order orderCurrent : orderList){
            orderIDSetAll.add(orderCurrent.Id);
        }
        insert new Account(Name = 'AccountName-6');
        List<Account> accountsList = AccountGet.getAccountsAll();
        Set<Id> accountIDSetOfAllDeletedOrders = new Set<Id>();
        for(Account accountCurrent : accountsList){
            accountIDSetOfAllDeletedOrders.add(accountCurrent.Id);
        }
        Test.startTest();
        List<Account> accountsListToTest = AccountGet.getAccontsNOTLinkedToOrders(accountIDSetOfAllDeletedOrders);
        Test.stopTest();

        System.assertEquals( 1, accountsListToTest.size(),'AccountGet.getAccontsNOTLinkedToOrders(Set<Id>, List<Accounts>) should return a list of 1 record.');
    }
}