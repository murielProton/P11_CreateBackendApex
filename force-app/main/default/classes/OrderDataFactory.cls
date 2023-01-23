/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderDataFactory {
    // Idée passer les paramettres  dans un array
    public static String orderName = 'Telepathy-';

    public static Order constructOneOrder(String orderName, Id accountID, Id contractID, Id pricebookId){
        Order orderConstructed = new Order(
            Name = orderName,
            AccountId = accountID,
            ContractId = contractID,
            Status = 'Draft',
            EffectiveDate = Date.today(),
            // essential for the creation of OrderItem
            Pricebook2Id =  pricebookId
            //TotalAmount = not writable This is Why Order links to a Product2 with OrderItem
        );
        return orderConstructed;
    }

    public static void createOrdersListForEachContract(List<Contract> contractListToCreateOrders, PriceBook2 pricebook){

        List<Order> ordersListToInsertForTest = new List<Order>();
        
        for(Contract contractCurent : contractListToCreateOrders){
            ordersListToInsertForTest.add(constructOneOrder(orderName+contractCurent.Name, 
                                                            contractCurent.AccountId, 
                                                            contractCurent.Id , 
                                                            pricebook.Id));
        }
        if (Schema.sObjectType.Order.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Order reccord.');
        }else{
            insert ordersListToInsertForTest;
        }
    } 
}