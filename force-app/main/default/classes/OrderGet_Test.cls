/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class OrderGet_Test {

    private static String accountName = 'AccountName-0';
    private static String orderName = 'Telepathy';
    private static String productName = 'WIFI';
    private static String pricebook2Name = 'France Price Book';


    /**
    * @description TestSetup for OrderGet_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupOrderGet(){
        //Create an Account
        AccountDataFactory.createAccountsList(5);
        List<Account> accountForThisTest = AccountGet.getAccountsAll();
        //create a Contract for this Account
        ContractDataFactory.createContractsList(accountForThisTest);
        // Make sure the Pricebook2 entry is active and standard
        Pricebook2DataFactory.createPricebook2();
        // The Order must have at least one Product, so we can change Order.Status to Activated
        // Link these accounts to some products = for each accounts create a contract + create pricebook custom + create pricebook standard + create products + create price book entry + create order
        // for each accounts create a contract 
        ContractDataFactory.createContractsList(accountForThisTest);
        // for the test to succeed the Contract Status should be Activated, but it can't be inserted as such, so we need to update it
        List<Contract> contractsListToUpdate = ContractGet.getContractsAll();
        ContractUpdate.updateContractsStatusToActivated(contractsListToUpdate);
        // to create a Pricebook2 field Standard = true the price book needs to be linked to a Product2
        // Create Product2
        Product2DataFactory.createProduct2();
        // Now make sure the Salesforce process doese create a standard Pricebook2
        List<Pricebook2> pricebookListForThisTest = Pricebook2Get.getPriceBook2ListByName(pricebook2Name);
        List<Product2> product2ListForThisTest = Product2Get.getProduct2ListByName(productName);
        // Process needs an entry in th Pricebook2 Standard = true, first ;
        PricebookEntryDataFactory.createPriceBookEntryForPricebookStandard(product2ListForThisTest[0]);
        // then PricebookEntry for normal Pricebook2 can be inserted.
        PricebookEntryDataFactory.createPriceBookEntry(pricebookListForThisTest[0], product2ListForThisTest[0]);
        
        
        // get contracts List we just inserted
        List<Contract> contractsListForTest = ContractGet.getContractsAll();
        //Create Order for each Contracts
        OrderDataFactory.createOrdersListForEachContract(contractsListForTest, pricebookListForThisTest[0]);
        // get a list of Orders records
        List<Order> orderList = OrderGet.getOrdersAll();

        //OrderItem links product to Order 
        // for each Orders create an OrderItem
        List<OrderItem> orderItemsList = new List<OrderItem>();
        List<PricebookEntry> pricebookEntryListForThisTest = PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebookListForThisTest[0].Id, product2ListForThisTest[0].Id);
        for(Order orderCurrent : orderList){
            //(Order orderForThisTest, Product2 product2ForThisTest, PricebookEntry pricebookEntryForThisTest)
            orderItemsList.add(OrderItemDataFactory.constructOneOrderItem(orderCurrent.Id, product2ListForThisTest[0].Id, pricebookEntryListForThisTest[0].Id));
        }
        insert orderItemsList;

    }

    /**
    * @description Test method for OrderGet.getOrdersAll()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetOrdersAll(){

        Test.startTest();
        List<Order> orderListForThisTest = OrderGet.getOrdersAll();
        Test.stopTest();

        System.assertEquals(10, orderListForThisTest.size(), 'OrderGet.getOrdersAll should return at least one order.');
    }

    /**
    * @description Test method for OrderGet.getOrdersWhereStatusActivated()
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetOrdersWhereStatusActivated(){

        List<Order> orderListForUpdate = OrderGet.getOrdersAll();
        OrderUpdate.updateOrdersStatusToActivated(orderListForUpdate);

        Test.startTest();
        List<Order> orderListForThisTest = OrderGet.getOrdersWhereStatusActivated();
        Test.stopTest();

        System.assertEquals(10, orderListForThisTest.size(), 'OrderGet.getOrdersWhereStatusActivated should return at least one order.');
    }

    /**
    * @description Test method for OrderGet.getOrderWithOrderItem(orderIdList)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetOrderWithOrderItem(){
        List<Order> orderList = OrderGet.getOrdersAll();
        Set<Id> orderIdSet = new Map<Id, Order>(orderList).keySet();
        List<Id> orderIdList = new List<Id>(orderIdSet);

        Test.startTest();
        List<Order> orderListForThisTest = OrderGet.getOrderWithOrderItem(orderIdList);
        Test.stopTest();

        System.assertEquals(orderIdList.size(), orderListForThisTest.size(), 'OrderGet.getOrderWithOrderItem should return the same number of records as all Orders inserted have OrderItems.');
    }

    /**
    * @description Test method for OrderGet.getOrderByAccountAndContract(accountId, contractId)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    static void testGetOrderByAccountAndContract(){

        Id accountId = AccountGet.getAccountsAll()[0].Id;
        Id contractId = ContractGet.getContractsAll()[0].Id;

        Test.startTest();
        List<Order> orderListForThisTest = OrderGet.getOrderByAccountAndContract(accountId, contractId);
        Test.stopTest();

        System.assertEquals(1, orderListForThisTest.size(), 'OrderGet.getOrderByAccountAndContract should return one record.');
    }
}