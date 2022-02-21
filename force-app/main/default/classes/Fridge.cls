Public Class Fridge {

    public integer unitPrice = 18; 
    
    public static integer stockThreshold= 5;    
    
    public integer setPrice(integer price){
        
      integer newPrice = price * 10; 
         unitPrice = unitPrice * 20; 
        return newPrice;
        
    }
    
}