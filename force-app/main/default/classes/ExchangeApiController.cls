public with sharing class ExchangeApiController {
    
    @AuraEnabled
    public static ExchangeApiResponse getExchangeData() {
        String endPoint = 'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_OsP57KqcRYsQ9Z7E3fZLDUGA24ycn1yynOhtAVCJ';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        HttpResponse res;
        Http http = new Http();
        res = http.send(req);

        try {
            if (res.getStatusCode() == 200) {
                // Parse the JSON response
                ExchangeApiResponse exchangeData = ExchangeApiResponse.parse(res.getBody());
                System.debug('Exchange Data: ' + exchangeData);
                return exchangeData;
            } 
            else {
                System.debug('Error: HTTP request failed with status code ' + res.getStatusCode());
                throw new CalloutException('Error: HTTP request failed with status code ' + res.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            throw new CalloutException('Error: ' + e.getMessage());
        }
    }  
    
}