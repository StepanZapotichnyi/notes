public with sharing class WeatherApiController {
    @AuraEnabled

    public static  WeatherApiResponse getWeatherData(String city) {
        String strResponse = null;
        WeatherApiResponse weatherData = new WeatherApiResponse();
        
        String endPonint = 'callout:WeatherApiNamedCred' 
                            + '/current.json?q='
                            + EncodingUtil.urlEncode(city, 'UTF-8'); 
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPonint);
        req.setMethod('GET');
        
        Http ht =  new Http(); 
        HttpResponse response = new HttpResponse();
        System.debug('---url-----' + req.getEndpoint() );
        response = ht.send(req);
        
        if (response.getStatusCode() == 200) {
            weatherData = WeatherApiResponse.parse(response.getBody());            
            return weatherData;
        }else{
            String errorResponse = response.getBody();
            WeatherError weatherError = WeatherError.parse(errorResponse);  
            throw new CalloutException(weatherError.error.message);
        }            
    }
}