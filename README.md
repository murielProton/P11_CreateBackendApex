# P11_CreateBackendApex
This is an OpenClassroom's exercisse. I'm asked to create a Salesforce Application with the sObjects : Account, Contract, Order and OrderItem. OrderItem is the API name of Order Product.
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
