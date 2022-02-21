public with sharing class pageOneController {

  


    public List<Contact> con  {get;set;}
    public pageOneController()
    {
    con = [Select Name, email, phone, id from Contact];
    }
    
    public void save()
    {
        update con;
    }
}