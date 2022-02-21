public with sharing class StringArrayTest {
	
       
	public static list<string> generateStringArray(integer A) {
        
        list<String> passedV = new list<String>();
        for( integer i=0;i<A;i++){
        
            passedV.add('Test '+i);
            system.debug(passedV);
        }
		
        return passedV;		
}
}