/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class LeadTriggerTest {

    @isTest
    static void testLeadTrigger_handleTitleNormalization() {
        // TO DO: implement unit test
        List<Lead> leads = new List<Lead>();
        for (Integer i = 1; i <=37; i++) {
            Lead ld = new Lead();
            Switch on i
            {
                when 1,2,3
                {
                 ld.Title = 'vp'+i;
                } 
                 when 4,5,6
                {
                 ld.Title = 'v.p.'+i;
                }
                when 7,8,9
                {
                 ld.Title = 'vice president'+i;
                }
                when 10,11,12
                {
                 ld.Title = 'mgr'+i;
                } 
                when 13,14,15
                {
                 ld.Title = 'manage'+i;
                }
                when 16,17,18
                {
                 ld.Title = 'head of department'+i;
                }
                when 19,20,21
                {
                 ld.Title = 'exec'+i;
                } 
                when 22,23,24
                {
                 ld.Title = 'chief'+i;
                }
                when 25,26,27
                {
                 ld.Title = 'head'+i;
                }
                when 28,29,30
                {
                 ld.Title = 'assist'+i;
                } 
                when 31,32,33
                {
                 ld.Title = 'deputy'+i;
                }
                when 34,35,36
                {
                 ld.Title = 'jr'+i;
                }
                when else {
                    ld.Title =null;
                }
            }
            ld.LastName = 'Lead_Title'+i;
            ld.Company = 'Company_Title'+i;
            leads.add(ld);
        }
        
        Test.startTest();
        Database.DMLOptions dml = new Database.DMLOptions(); 
        dml.DuplicateRuleHeader.allowSave = true;
        dml.DuplicateRuleHeader.runAsCurrentUser = true;
        List<Database.SaveResult> saveresult = Database.insert(leads, dml);
        
        List<Lead> leadVicePResident = [SELECT Id, Title 
                                        FROM Lead
                                        WHERE Title = 'Vice President'];
       
        System.assertEquals(9, leadVicePResident.size(), 'Number of leads inserted with the title Vice PResident is incorrect.');
        
        List<Lead> leadManager = [SELECT Id, Title 
                                  FROM Lead
                                  WHERE Title ='Manager'];

        System.assertEquals(9, leadManager.size(), 'Number of leads inserted with the title Manager is incorrect.');

        List<Lead> leadExecutive = [SELECT Id, Title 
                                  FROM Lead
                                  WHERE Title = 'Executive'];

        System.assertEquals(9, leadExecutive.size(), 'Number of leads inserted with the title Executive is incorrect.');

        List<Lead> leadAssistant = [SELECT Id, Title 
                                  FROM Lead
                                  WHERE Title ='Assistant'];

        System.assertEquals(9, leadAssistant.size(), 'Number of leads inserted with the title Assistant is incorrect.');
        
        List<Lead> leadNoTitle = [SELECT Id, Title 
                                  FROM Lead
                                  WHERE Title = null];

        System.assertEquals(1, leadNoTitle.size(), 'Number of leads inserted is incorrect.');

       List<Lead> updateLeads = [SELECT Id, Title 
                                  FROM Lead
                                  WHERE Title = 'Vice President' OR Title = 'Manager' OR Title = 'Executive' OR Title = 'Assistant' OR Title = Null];
        for(Lead l : updateLeads)
        {
            l.Title = 'vp';
        }

        saveresult = Database.update(updateLeads, dml);
        Test.stopTest();
        List<Lead> updatedLeads = [SELECT Id, Title 
                                        FROM Lead
                                        WHERE Title = 'Vice President' OR Title = 'Manager' OR Title = 'Executive' OR Title = 'Assistant' OR Title = Null];
       
        System.assertEquals(37, updatedLeads.size(), 'Number of leads inserted is incorrect.');
    
    }

    @isTest
    static void testLeadTrigger_handleAutoLeadScoring() {
        // TO DO: implement unit test
        List<Lead> leads = new List<Lead>();
        for (Integer i = 1; i <=6; i++) {
            Lead ld = new Lead();
           Switch on i {
                when 1 {
                    ld.LeadSource = 'Website';
                    ld.Email = null;
                    ld.phone = null;
                    ld.Industry = 'Banking';
                }
                when 2 {
                    ld.LeadSource = 'Website';
                    ld.Email = 'aaaa@gmail.com';
                    ld.phone = null;
                    ld.Industry = 'Banking';
                }
                when 3 {
                    ld.LeadSource = 'Website';
                    ld.Email = 'aaaa@gmail.com';
                    ld.phone = '888888888';
                    ld.Industry = 'Banking';
                }
                when 4 {
                    ld.LeadSource = 'Website';
                    ld.Email = 'aaaa@gmail.com';
                    ld.phone = null;
                    ld.Industry = 'Technology';
                }
                when 5 {
                    ld.LeadSource = 'Email';
                    ld.Email = 'aaaa@gmail.com';
                    ld.phone = '888888888';
                    ld.Industry = 'Banking';
                }
                when 6 {
                    ld.LeadSource = 'Website';
                    ld.Email = 'aaaa@gmail.com';
                    ld.phone = '888888888';
                    ld.Industry = 'Technology';
                }
           }
           ld.LastName = 'Lead_Score'+i;
           ld.Company = 'Company_LeadScore'+i;
           leads.add(ld);
        }
        Test.startTest();
        Database.DMLOptions dml = new Database.DMLOptions(); 
        dml.DuplicateRuleHeader.allowSave = true;
        dml.DuplicateRuleHeader.runAsCurrentUser = true;
        List<Database.SaveResult> saveresult = Database.insert(leads, dml);
        
        List<Lead> insertedLeads = [SELECT Id, Lead_Score__c, Industry, Phone, LeadSource, Email 
                                    FROM Lead 
                                    WHERE Id IN :leads];

          for (Lead lead : insertedLeads) {
            if (lead.LeadSource == 'Website' && lead.Email != null && lead.Phone != null && lead.Industry == 'Technology') {
                System.assertEquals(18, lead.Lead_Score__c, 'Lead Score should be 18');
            } else if (lead.Phone != null && lead.Industry == 'Technology') {
                System.assertEquals(15, lead.Lead_Score__c, 'Lead Score should be 15');
            } else if(lead.LeadSource == 'Website' && lead.Email != null  &&  lead.Industry == 'Technology') {
                System.assertEquals(13, lead.Lead_Score__c, 'Lead Score should be 13');
            } else if (lead.Industry == 'Technology') {
                System.assertEquals(10, lead.Lead_Score__c, 'Lead Score should be 10');
            } else if (lead.LeadSource == 'Website' && lead.Email != null && lead.Phone != null) {
                System.assertEquals(8, lead.Lead_Score__c, 'Lead Score should be 8');
            } else if (lead.Phone != null) {
                System.assertEquals(5, lead.Lead_Score__c, 'Lead Score should be 5');
            } else if (lead.LeadSource == 'Website' && lead.Email != null) {
                System.assertEquals(3, lead.Lead_Score__c, 'Lead Score should be 3');
            } else {
                System.assertEquals(0, lead.Lead_Score__c, 'Lead Score should be 0');
            }
        }

        for(Lead lead : insertedLeads)
        {
            Lead.Industry = 'Technology';
            Lead.LeadSource = 'Website';
            Lead.Phone = '8888888888';
            Lead.Email = 'aaaa@gmail.com';
        } 

        saveresult = Database.update(insertedLeads, dml);
        Test.stopTest();
   
        List<Lead> updatedLeads = [SELECT Id, Lead_Score__c, Industry, Phone, LeadSource, Email 
                                    FROM Lead 
                                    WHERE Id IN :insertedLeads];
        for (Lead lead : updatedLeads) {
              System.assertEquals(18, lead.Lead_Score__c, 'Lead Score should be 18');
        }
    }
    @isTest
    static void testLeadTrigger_handleLeadAutoConvert() {
        Account acc = new Account();
        acc.Name = 'Test Account Name';
        acc.Industry = 'Technology';
        insert acc;

        Contact con = new Contact();
        con.LastName='Test';
        con.FirstName = 'Lead';
        con.email = 'aa@gmail.com';
        con.AccountId = acc.ID;
        insert con;

        List<Lead> leads = new List<Lead>();
        for(integer i=0;i<3;i++)
        {
            Lead l = new Lead();
            switch on i{
                when 0{
                  l.Email = 'aa@gmail.com';
                 
                }
                when 1{
                  l.Email = null;
                }
                when 2{
                    l.Email = 'bb@gmail.com';
                }
            }
            l.LastName = 'Test Name ' + i;
            l.Company = 'Test Company ' + i; 
            leads.add(l);   
        }
        Test.startTest();
        Database.DMLOptions dml = new Database.DMLOptions(); 
        dml.DuplicateRuleHeader.allowSave = true;
        dml.DuplicateRuleHeader.runAsCurrentUser = true;
        List<Database.SaveResult> saveresult = Database.insert(leads, dml);

        Lead[] convertedLeads = [SELECT Id, IsConverted, Email FROM Lead WHERE Id IN :leads and IsConverted = true];
      
        System.assertEquals(1, convertedLeads.Size(), 'Lead has not been converted');
        
        for(integer i=0;i<leads.Size();i++)
        {
            if(leads[i].IsConverted == false)
            {
                leads[i].Email = 'aa@gmail.com';
            }
        }

        saveresult = Database.update(leads, dml);
        Test.stopTest();

        convertedLeads = [SELECT Id, IsConverted, Email FROM Lead WHERE Id IN :leads and IsConverted = true];
       
        System.assertEquals(3, convertedLeads.Size(), 'Lead has not been converted');
    }
}