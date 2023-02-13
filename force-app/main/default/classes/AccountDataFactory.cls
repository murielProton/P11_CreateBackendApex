/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
public with sharing class AccountDataFactory {
    
    /**
    * @description insert method, a number of records on Account equal to the parametter
    * @author Muriel Proton | 13-02-2023 
    * @param Integer 
    **/
    public static void createAccountsList(Integer numberOfAccounts){
        List<Account> accountsListToInsertForTest = new List<Account>();
        for(Integer i = 0 ; i < numberOfAccounts ; i++){
            accountsListToInsertForTest.add(new Account(Name = 'AccountName-'+i));
        }
        if (Schema.sObjectType.Account.fields.Name.isCreateable() == false) {
            throw new CRUDPermissionBeforSOQLDMLException('You have no permission to insert an Account record.');
        }else{
            insert accountsListToInsertForTest;
        }
    }
}