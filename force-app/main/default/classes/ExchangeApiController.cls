public with sharing class ExchangeApiController {
    @AuraEnabled
    public static String getConvertData(String since , String to, Integer amount) {

        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.fastforex.io/convert?from='+ since +'&to='+ to +'&amount='+ amount +'&api_key=d4fc3cc97c-efe2b83743-s84pdf');
        // request.setHeader( 'accept: application/json');
        request.setMethod('GET');

        HttpResponse response = new HttpResponse();
        Http ht = new Http();

        response = ht.send(request);

        
        System.debug('THe exchange data :'+ response.getBody());
        return response.getBody();
        
    }

    
    @AuraEnabled
    public static String getExchangeData() {
        
        String strExchange = null;
        String endPoinnt = 'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_OsP57KqcRYsQ9Z7E3fZLDUGA24ycn1yynOhtAVCJ';
         HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoinnt);
        req.setMethod('GET');
        HttpResponse res;
        Http http = new Http();
        res = http.send(req);
        
        try {
            if (res.getStatusCode() == 200) {
                // Parse the JSON response and serialize it
                ExchangeApiControllerJSON exchangeData = ExchangeApiControllerJSON.parse(res.getBody());
                strExchange = JSON.serialize(exchangeData);
                System.debug('Str--------' + strExchange);
                return strExchange;
                
            } else {
                System.debug('Error: HTTP request failed with status code ' + res.getStatusCode());
                return null;
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            return null;
        }
    }        
}