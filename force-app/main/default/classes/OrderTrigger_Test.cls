/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class OrderTrigger_Test {

    private static String pricebook2Name = 'France Price Book';
    private static String productName = 'WIFI';
    private static String orderName = 'Telepathy-';

    /**
    * @description TestSetup for OrderTrigger_Test
    * @author Muriel Proton | 13-02-2023 
    **/
    @TestSetup
    static void setupOrderTrigger() {
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
    * @description Test method to trigger OrderTrigger.trigger when updating unvalid Order records
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testOrderTriggerUpdateNOTValid(){
        List<Order> orderList = OrderGet.getOrdersAll();
        Boolean exectionOK = false;
        Account accountForTest = AccountGet.getAccountsAll()[0];
        Contract contractForTest = ContractGet.getContractsAll()[0]; 
        Pricebook2 pricebookEntryForThisTest = Pricebook2Get.getPriceBook2Standard();
        // get a list of Orders records
        Order orderToAdd = OrderDataFactory.constructOneOrder('Discord', accountForTest.Id, contractForTest.Id , pricebookEntryForThisTest.Id);
        insert orderToAdd;

        orderToAdd.Status = 'Activated';
        Test.startTest();
        try{
            update orderToAdd;
        }catch(DMLException e){
            exectionOK = true;
            System.assert(e != null && e.getMessage().contains(', il doit être associé à un produit (Product2).'), 'An exception message should have been triggered.'+e.getMessage());
        }
        Test.stopTest();
        System.assertEquals(true, exectionOK, 'An execptions should have been thorwn.');
    }

    /**
    * @description Test method to trigger OrderTrigger.trigger when updating valid Order records
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testOrderTriggerUpdateValid(){
        List<Order> orderListToUpdate = OrderGet.getOrdersAll();
        Boolean exectionOK = true;
        // Change the Orders -> Order.Status to Activated

        Test.startTest();
        try{
            OrderUpdate.updateOrdersStatusToActivated(orderListToUpdate);
        }catch(DMLException e){
            exectionOK = false;
            System.assert(e != null && e.getMessage().contains(', il doit être associé à un produit (Product2).'), 'An exception message should have been triggered.'+e.getMessage());
        }
        Test.stopTest();
        List<Order> orderListForTest = OrderGet.getOrdersAll();
        System.assertEquals(true, exectionOK, 'NO execptions should have been thorwn.');
        System.assertEquals('Activated', orderListForTest[0].Status, 'The Status of the Order record should be Activated.');
    }

    /**
    * @description Test method to trigger OrderTrigger.trigger to check if the field Active__c on Account records is set to tue 
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testOrderTriggerHandlerAfterInsert(){
        List<Contract> contractListToCreateOrders = ContractGet.getContractsAll();
        PriceBook2 pricebook = Pricebook2Get.getPriceBook2Standard();
        List<Order> orderbeforeInsert = OrderGet.getOrdersAll();

        List<Order> orderList = new List<Order>();
        Order orderConstructed = new Order(
            Name = orderName,
            AccountId = contractListToCreateOrders[0].AccountId, //Required
            ContractId = contractListToCreateOrders[0].Id,
            Status = 'Draft',
            EffectiveDate = Date.today(),
            // essential for the creation of OrderItem
            Pricebook2Id =  pricebook.Id //Required
            //TotalAmount = not writable This is Why Order links to a Product2 with OrderItem
        );
        orderList.add(orderConstructed);
        
        Test.startTest();
            insert orderList;
        Test.stopTest();

        List<Order> orderToInsert = OrderGet.getOrdersAll();

        List<Account> accountList = AccountGet.getAccountActiveTrue();

        System.assertEquals(1, accountList.size(), 'After inserting records on Order, Account field Active__c should be updated.');
    }
    /**
    * @description Test method to trigger OrderTrigger.trigger to check if the field Active__c on Account is set to false when the record Account has no Orders linked to it
    * @author Muriel Proton | 13-02-2023 
    **/
    @isTest
    public static void testOrderTriggerHandlerAfterDelete(){
        /*Need a new set of Accont, Contract to create a record on order that is not valid. */
        List<Contract> contractListToCreateOrders = ContractGet.getContractsAll();
        PriceBook2 pricebook = Pricebook2Get.getPriceBook2Standard();
        List<Order> orderbeforeInsert = OrderGet.getOrdersAll();
        
        insert new Account(Name = 'AccountName-6');
        Account account6 = AccountGet.getAccountByName('AccountName-6');
        Id accountIdForDeletion = account6.Id;
        //insert contract for doomed Account
        Contract contract = new Contract(
            AccountId = accountIdForDeletion,
            //can't create a contract with the Status set to Activated
            Status = 'Draft',
            StartDate = Date.today(),
            ContractTerm = 6
        );
        insert contract;

        Contract contractDoomed = [SELECT Id
                                    FROM Contract
                                    WHERE AccountId = :accountIdForDeletion
                                    LIMIT 1];
        List<Order> orderList = new List<Order>();
        Order orderConstructed1 = new Order(
            Name = orderName+'1',
            AccountId = contractListToCreateOrders[0].AccountId, //Required
            ContractId = contractListToCreateOrders[0].Id,
            Status = 'Draft',
            EffectiveDate = Date.today(),
            // essential for the creation of OrderItem
            Pricebook2Id =  pricebook.Id //Required
            //TotalAmount = not writable This is Why Order links to a Product2 with OrderItem
        );
        Order orderConstructed2 = new Order(
            Name = orderName+'2',
            AccountId = accountIdForDeletion, //Required
            ContractId = contractDoomed.Id,
            Status = 'Draft',
            EffectiveDate = Date.today(),
            // essential for the creation of OrderItem
            Pricebook2Id =  pricebook.Id //Required
            //TotalAmount = not writable This is Why Order links to a Product2 with OrderItem
        );
        orderList.add(orderConstructed1);
        orderList.add(orderConstructed2);
        insert orderList;

        Order doomedOrder = [SELECT Id, Name, AccountId
                            FROM Order
                            WHERE AccountId = :accountIdForDeletion
                            LIMIT 1];
        Test.startTest();
            delete doomedOrder;
        Test.stopTest();

        List<Order> orderToInsert = OrderGet.getOrdersAll();
        List<Account> accountList = AccountGet.getAccountActiveFalse();

        System.assertEquals(1, accountList.size(), 'After deleting records on Order, Account field Active__c should be updated to flase, if Account not linked to an Order.');
    }
}