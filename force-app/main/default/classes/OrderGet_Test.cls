/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class OrderGet_Test {

    private static String accountName = 'AccountName-0';
    private static String orderName = 'Telepathy';

    @TestSetup
    static void setupOrderGet(){
        //Create an Account
        AccountDataFactory.createAccountsList(1);
        List<Account> accountsList = AccountGet.getAccountsAll();
        //create a Contract for this Account
        ContractDataFactory.createContractsList(accountsList);
        // Make sure the Pricebook2 entry is active and standard
        Pricebook2DataFactory.createPricebook2();

        // get sObjects for Test
        Account accountForThisTest = accountsList[0];
        List<Contract> contractForThisTest = ContractGet.getContractsOfAccount(accountForThisTest.Id);
        Pricebook2 pricebookForThisTest = Pricebook2Get.getPriceBook2ListByName('France Price Book')[0];

        // create order
        Order orderConstructed = new Order(
            Name = orderName,
            AccountId = accountForThisTest.Id,
            ContractId = contractForThisTest[0].Id,
            Status = 'Draft',
            EffectiveDate = Date.today(),
            // essential for the creation of OrderItem
            Pricebook2Id =  pricebookForThisTest.Id
            //TotalAmount = not writable This is Why Order links to a Product2 with OrderItem
        );
        insert orderConstructed;

    }

    @isTest
    static void testGetOrdersAll(){

        Test.startTest();
        List<Order> orderListForThisTest = OrderGet.getOrdersAll();
        Test.stopTest();

        System.assertEquals(orderListForThisTest.size(), 1, 'OrderGet.getOrdersAll should return one order.');
    }
    
    @isTest
    static void testGetOrderWhereNOPricebook2(){
        List<Account> accountsList = AccountGet.getAccountsAll();
        List<Contract> contractForThisTest = ContractGet.getContractsOfAccount(accountsList[0].Id);
        Order orderConstructed = new Order(
            Name = orderName+'-'+accountName,
            AccountId = accountsList[0].Id,
            ContractId = contractForThisTest[0].Id,
            Status = 'Draft',
            EffectiveDate = Date.today()
        );
        insert orderConstructed;

        Test.startTest();
        List<Order> orderListToTest = OrderGet.getOrderWhereNOPricebook2();
        Test.stopTest();

        System.debug('orderListForThisTest ' +orderListToTest);

        System.assertEquals(1, orderListToTest.size(), 'OrderGet.getOrderWhereNOPricebook2 should return at least one order without a Pricebook2 attached.');
    }
}