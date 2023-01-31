/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class OrderUpdate_Test {
    
    private static String pricebook2Name = 'France Price Book';
    private static String productName = 'WIFI';

    @TestSetup
    static void setupOrderUpdate(){
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
        for(Order orderCurent : orderList){
            //(Order orderForThisTest, Product2 product2ForThisTest, PricebookEntry pricebookEntryForThisTest)
            orderItemsList.add(OrderItemDataFactory.constructOneOrderItem(orderCurent.Id, product2ListForThisTest[0].Id, pricebookEntryListForThisTest[0].Id));
        }
        insert orderItemsList;
    }

    @isTest
    static void testUpdateOrdersStatusToActivated(){
        
        List<Order> orderListForTest = OrderGet.getOrdersAll();
        
        Test.startTest();
        OrderUpdate.updateOrdersStatusToActivated(orderListForTest);
        Test.stopTest();

        List<Order> orderListForThisTest = OrderGet.getOrdersWhereStatusActivated();
        System.assertEquals('Activated', orderListForThisTest[0].Status, 'OrderUpdate.updateOrdersStatusToActivated should update Status to Activated.');
    }
    
}