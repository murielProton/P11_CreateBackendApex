/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
global with sharing class TaskCreateExecute_Queueable implements Schedulable{
    /**
    * @description Batch method TaskCreateExecute_Queueable implements native class execute
    * @author Muriel Proton | 13-02-2023 
    * @param SchedulableContext 
    **/
    global void execute(SchedulableContext sc) {
        TaskCreate_Queueable taskCreate_Queueable = new TaskCreate_Queueable();
        Database.executebatch(taskCreate_Queueable);

    }
}