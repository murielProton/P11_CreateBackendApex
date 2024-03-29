# P11_CreateBackendApex
This is an OpenClassroom's exercisse. I'm asked to create a Salesforce Application with the sObjects : Account, Contract, Order, Task and OrderItem. OrderItem is the API name of Order Product.
This exercisse demands that I create a trigger on Order, two Apex classes to set 2 different fuctions, and a batch.
# Trigger on Order
- when the field Status changes from Draft to Active, verify if the record is linked to an actual Product. If not send an Error to the user.
- When an record of Order is deleted, check if the related Account has any other Orders linked to it. If not the Active__c field on Account will be unchecked.
# Two Apex Classes
- RG-01 : check if the record of Order is linked to an actual Product.
- RG-O2 : check if the record of Order is the only one linked to an Accont.
# Schedulable Batch 
- each first monday of the month
- gets all records of Accounts with no Orders neither Tasks linked to them.
- create a new tasks to attach to each of theese records
    - Subject : Call
    - Status : New
    - Priority : Normal
    - every 5 days send an alert
# Naming convention design pattern
Folow the rules of this GitHub Repository
https://github.com/cfpb/salesforce-docs/blob/master/_pages/Salesforce-Naming-Conventions.md
# Design pattern 'domain layer class'
Classes
ClassName_Test → Regroups all tests methods on a specific class.
SobjectNameAction_Queueable →  Class that contains the methode start(), execute(), finish().  _Queueable stands for automaticaly launch code.
SobjectNameActionExecute_Queueable → Class that calls on, and instantiate _Queueable.  _Queueable stands for automaticaly launch code. _Queueable stands for automaticaly launch code.
SobjectNameActionHelper_Queueable → Class that will regroup all methodes used by the _Queueable class, disregarding code duplication. _Queueable stands for automaticaly scheduled Batch.
SobjectNameDataFactory → Class that contains all the methodes that generates records for the tests.
SobjectNameFilter → Class that contains all the methodes to filter throught the cited type. 
SobjectNameGet → Class that contains all the methodes used to get records, using SOQL.
SobjectNameTrigger _Test →  Regroups all tests methods for the Trigger.
SobjectNameTriggerHandler → implements all the methods declared in TriggerHandler class. Calls on methods in SobjectNameTriggerHelper.
SobjectNameTriggerHelper →  Regroups all tests methods called by SobjectNameTriggerHandler.
TriggerHandler → methods defining how all triggers will work.

Methods
All methods begin by a verb.
All tests methods begin by test.
CheckSobjectNamePermissions → method that will chek CRUD before DML operation.
setupClassName -> design pattern for all setup method begining a test class.
# CRUD DML
Check CRUD before DML operation documentation :
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_perms_enforcing.htm
 # APex Dox
 To use the documentation in it's full capacity, you need a WAMP server.
 Use this link : http://localhost/P11_CreateBackendApex/ApexDocumentation/AccountDataFactory_Test.html
