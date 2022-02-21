public class ExceptionTest {
    public class checkexception extends Exception{}
    public static void excpMthd(integer i){
    
    //system.debug('i');
        try{
        for(integer j=0 ; j < i ; j++){
        if(j == 11)
        {
            throw new checkexception('exception here' + j);
            system.debug(' exception j'+j);
        }
        system.debug('j'+j);
        }
        }
        
        catch(exception e){
            system.debug(e);
        }
    }
}