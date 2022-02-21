public class AnimalLocator {
    
    public static String getAnimalNameById(integer i){
        string retString;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        string endPoint = 'https://th-apex-http-callout.herokuapp.com/animals/' + i;
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug(response.getStatusCode());
        system.debug(response.getBody());
        
            Map<string, object> resp = (Map<string, object>) JSON.deserializeUntyped(response.getBody());
            	system.debug((Map<string, Object>) resp.get('animal'));
            
                return (string) ((Map<string, Object>) resp.get('animal')).get('name');
            
        
        
    }
}