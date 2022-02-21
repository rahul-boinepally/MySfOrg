public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(integer num, string secondName){
        List<Contact> contacts = new List<Contact>();
        for(integer i =0; i< num; i ++){
            Contact con = new Contact(LastName = secondName,
                                     FirstName = 'Test' + i);
            contacts.add(con);
        }        
        return contacts;
    }
    
}