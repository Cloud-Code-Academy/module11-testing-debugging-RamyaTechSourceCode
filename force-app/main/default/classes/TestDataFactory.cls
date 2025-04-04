public class TestDataFactory {
    public static List<Lead> testDataForLeads() {
      
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
        return leads;
    }
    public static List<Lead> autoLeadScoring()
    {
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
        return leads;
    }
    
    public static List<Lead> convertLeads(){
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
        return leads;
    }
}
