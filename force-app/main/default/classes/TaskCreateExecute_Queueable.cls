/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 09-02-2023
 * @last modified by  : Muriel Proton
**/
global with sharing class TaskCreateExecute_Queueable implements Schedulable{
    global void execute(SchedulableContext sc) {
        TaskCreate_Queueable taskCreate_Queueable = new TaskCreate_Queueable();
        Database.executebatch(taskCreate_Queueable);

    }
}