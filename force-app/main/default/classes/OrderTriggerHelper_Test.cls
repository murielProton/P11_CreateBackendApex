/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class OrderTriggerHelper_Test {

    private static String pricebook2Name = 'France Price Book';
    private static String productName = 'WIFI';
    private static String orderName = 'Telepathy-';

    /**
    * @description TestSetup for OrderTriggerHelper_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupOrderTriggerHelper(){
        // Create a bunch of Accounts
        AccountDataFactory.createAccountsList(1);
        List<Account> accountList1ToCompare = AccountGet.getAccountsAll();
        Set<Account> accountSet1ToCompare = new Set<Account>(accountList1ToCompare);
        // The Order must have at least one Product, so we can change Order.Status to Ordered
        // Link these accounts to some products = for each accounts create a contract + create pricebook custom + create pricebook standard + create products + create price book entry + create order
        // for each accounts create a contract 
        ContractDataFactory.createContractsList(accountList1ToCompare);
        // for the test to succeed the Contract Status should be Activated, but it can't be inserted as such, so we need to update it
        List<Contract> contractsListToUpdate = ContractGet.getContractsAll();
        ContractUpdate.updateContractsStatusToActivated(contractsListToUpdate);
        //1 to create a Pricebook2 field Standard = true the price book needs to be linked to a Product2
        // Create Product2
        Product2DataFactory.createProduct2();
        // Now make sure the Salesforce process doese create a standard Pricebook2
        Pricebook2 pricebookStandardToUpdate = new PriceBook2 (
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        //Execute an update DML on the Pricebook2 record, to make IsStandard to true
        update pricebookStandardToUpdate; 
        List<PriceBook2> pricebook2ListALL = Pricebook2Get.getPriceBook2All();  

        PriceBook2 pricebook2Standard = Pricebook2Get.getPriceBook2Standard();
        System.assertEquals(true, pricebook2Standard.IsStandard, 'price book 2 not standard');
        //1 END

        List<Product2> product2ListForThisTest = Product2Get.getProduct2ListByName(productName);
        Product2 product2ForThisTest = product2ListForThisTest[0];
        
        // then PricebookEntry for normal Pricebook2 can be inserted.
        PricebookEntryDataFactory.createPriceBookEntry(pricebook2Standard, product2ForThisTest);
        // WHY NO STANDARD PRICEBOOK ARE CREATED ???
        
        List<Pricebook2> listforTestPB2 = [SELECT Id, IsStandard FROM PriceBook2];
        
        // get records to construct an Order
        Account accountForTest = AccountGet.getAccountByName('accountName-0');
        List<Contract> contractsListForTest = ContractGet.getContractsOfAccount(accountForTest.Id);
        Contract contractForTest = contractsListForTest[0];
        //Create Orders
        List<Order> listOfOrdersToInsert = new List<Order>();
        // if you change the numbers below you must change all the sytem asserts
        for(Integer i = 0 ; i < 1 ; i++){
            Order orderToAdd = OrderDataFactory.constructOneOrder(orderName, accountForTest.Id, contractForTest.Id , pricebook2Standard.Id);
            listOfOrdersToInsert.add(orderToAdd);
        }
        insert listOfOrdersToInsert;
        // they need to have their Status set to Ordered
        List<Order> orderList = OrderGet.getOrdersAll();

        //OrderItem links product to Order 
        // for each Orders create an OrderItem
        List<OrderItem> orderItemsList = new List<OrderItem>();
        PricebookEntry pricebookEntryForThisTest = PricebookEntryGet.getPricebookEntryByPricebook2AndProduct2(pricebook2Standard.Id, product2ForThisTest.Id)[0];

        for(Order orderCurrent : orderList){
            //(Order orderForThisTest, Product2 product2ForThisTest, PricebookEntry pricebookEntryForThisTest)
            orderItemsList.add(OrderItemDataFactory.constructOneOrderItem(orderCurrent.Id, product2ForThisTest.Id, pricebookEntryForThisTest.Id));
        }
        insert orderItemsList;
        

    }

    /**
    * @description Test method for sendErrorOnOrder(orderMapOld, orderMapNew)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testSendErrorOnOrder(){

        Id accountId = AccountGet.getAccountsAll()[0].Id;
        Id contractId = ContractGet.getContractsAll()[0].Id;

        List<Order> listOfOrdersToInsert = new List<Order>();
        for(Integer i = 0 ; i < 2 ; i++){
            Order orderToAdd = new Order (
                                        Name = orderName+i,
                                        AccountId = accountId, //Required
                                        ContractId = contractId,
                                        Status = 'Draft',
                                        EffectiveDate = Date.today()
                                );
            listOfOrdersToInsert.add(orderToAdd);
        }
        insert listOfOrdersToInsert;
        List<Order> orderList = OrderGet.getOrdersAll();
        for (Order orderCurrent : orderList){
            orderCurrent.Status = 'Activated';
        }
         
        Boolean checkIfIWasInCatch = false;
        Test.startTest();
        try{
            update orderList;
        }catch(DMLException e){
            System.assert(e != null && e.getMessage().contains('Avant de pouvoir passer le statut à /"Activated/" de '), 
                'An exception message should have been triggered.');
            checkIfIWasInCatch = true;
        }
        Test.stopTest();

        System.assertEquals(true, checkIfIWasInCatch, 'this test should run through catch!');
    }

    /**
    * @description Test method for displayMessageForEachOrderNotValid(orderList,  orderMapNew) doese not exist beacause it is alredy tested with an other test method
    * @author Muriel Proton | 13-02-2023 
    **/
   @isTest
    public static void testDisplayMessageForEachOrderNotValid(){
        // already tested above
    }

    /**
    * @description Test method for OrderTriggerHelper.updateAccountActiveIfLinkedToOrder(orderListForTest)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testUpdateAccountActiveIfLinkedToOrder(){
        List<Order> orderListForTest = OrderGet.getOrdersAll();

        Test.startTest();
        OrderTriggerHelper.updateAccountActiveIfLinkedToOrder(orderListForTest);
        Test.stopTest();

        List<Account> accountListToTest = AccountGet.getAccountActiveTrue();
        
        System.assertEquals(1, accountListToTest.size(), 'AccountUpdate.updateAccountActiveIfLinkedToOrder(List<Order>) should update Accounts fields Active__c.');
    }
    /**
    * @description Test method for OrderTriggerHelper.updateAccountActiveIfOrderDelete(orderListForTest)
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testUpdateAccountActiveIfOrderDelete(){
        List<Order> orderListForTest = OrderGet.getOrdersAll();
        Set<Id> orderIDSetAll = new Set<Id>();
        for (Order orderCurrent : orderListForTest){
            orderIDSetAll.add(orderCurrent.Id);
        }
        insert new Account(Name = 'AccountName-6');
        List<Account> accountsList = AccountGet.getAccountsAll();
        Set<Id> accountIDSetOfAllDeletedOrders = new Set<Id>();
        for(Account accountCurrent : accountsList){
            accountIDSetOfAllDeletedOrders.add(accountCurrent.Id);
        }

        Test.startTest();
        OrderTriggerHelper.updateAccountActiveIfOrderDelete(orderListForTest);
        Test.stopTest();

        List<Account> accountListToTest = AccountGet.getAccountActiveFalse();
        
        System.assertEquals(1, accountListToTest.size(), 'AccountUpdate.updateAccountActiveIfOrderDelete(List<Order>) should update Accounts fields Active__c To FALSE.');
    }
}