public class AccExtn{

    private final Account acc;
    
    public AccExtn(ApexPages.StandardController stdController) {
        this.acc = (Account)stdController.getRecord();

    }

    public String getGreeting() {
    	system.debug('test2');
        return 'Hello ' + Acc.Id;
        

    }
}