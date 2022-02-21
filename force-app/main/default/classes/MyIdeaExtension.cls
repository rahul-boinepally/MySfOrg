public class MyIdeaExtension{

    private final Idea ide;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public MyIdeaExtension(ApexPages.StandardController stdController) {
        this.ide = (Idea)stdController.getRecord();
    }

    public String getGreeting() {
        return 'Hello ' + ide.body;
    }
}