/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class OrderGet_Test {

    String accountName = 'AccountName-0';

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
        Contract contractForThisTest = ContractGet.getContractsOfAccount(Id AccountId);
        Pricebook2 pricebookForThisTest = Pricebook2DataFactory.getPriceBook2ByName(pricebook2Name);

        // create order
        Order orderConstructed = new Order(
            Name = orderName,
            AccountId = accountForThisTest.Id,
            ContractId = contractForThisTest.Id,
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
}