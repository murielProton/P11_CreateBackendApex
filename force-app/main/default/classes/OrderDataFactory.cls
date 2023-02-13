/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class OrderDataFactory {
    // Idée passer les paramettres  dans un array
    public static String orderName = 'Telepathy-';

    public static Order constructOneOrder(String orderName, Id accountID, Id contractID, Id pricebookId){
        Order orderConstructed = new Order(
            Name = orderName,
            AccountId = accountID, //Required
            ContractId = contractID,
            Status = 'Draft',
            EffectiveDate = Date.today(),
            // essential for the creation of OrderItem
            Pricebook2Id =  pricebookId //Required
            //TotalAmount = not writable This is Why Order links to a Product2 with OrderItem
        );
        return orderConstructed;
    }

    public static void createOrdersListForEachContract(List<Contract> contractListToCreateOrders, PriceBook2 pricebook){

        List<Order> ordersListToInsertForTest = new List<Order>();
        
        for(Contract contractCurrent : contractListToCreateOrders){
            ordersListToInsertForTest.add(constructOneOrder(orderName+contractCurrent.Name, 
                                                            contractCurrent.AccountId, 
                                                            contractCurrent.Id , 
                                                            pricebook.Id));
        }
        if (Schema.sObjectType.Order.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Order record.');
        }else{
            insert ordersListToInsertForTest;
        }
    } 
}