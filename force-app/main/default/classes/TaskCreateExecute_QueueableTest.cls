/**
 * @description       : 
 * @author            : Muriel Proton
 * @group             : 
 * @last modified on  : 13-02-2023
 * @last modified by  : Muriel Proton
**/
@isTest
public with sharing class TaskCreateExecute_QueueableTest {

    // H M S jour du mois  mois  jour de semaine  année
    public static String CRON_EXP = '0 0 0 ? * 2#1 *';

    @isTest
    public static void testTaskCreateExecute() {

        Test.startTest();
            // Schedule the test job        
            String jobId = System.schedule('taskCreateExecutScheduelTest', TaskCreateExecute_QueueableTest.CRON_EXP, new TaskCreateExecute_Queueable());
        
            // Get the information from the CronTrigger API object
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                NextFireTime
                FROM CronTrigger WHERE id = :jobId];
        Test.stopTest();

        // Verify the expressions are the same
        System.assertEquals(TaskCreateExecute_QueueableTest.CRON_EXP, ct.CronExpression, 'This test should have run TaskCreateExecute_Queueable.');
    
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered, 'Why was it not runed at the right time, TaskCreateExecute_Queueable.');
    }
   
}