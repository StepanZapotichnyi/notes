public with sharing class WeatherApiController {
    @AuraEnabled

    public static  WeatherApiResponse getWeatherData(String city) {
        // add try and catch+
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
        //add deserialization+
        
        if (response.getStatusCode() == 200) {
            System.debug('work');
            /////////////////////////////////////////////////
            weatherData = WeatherApiResponse.parse(response.getBody());
            System.debug('weather' +weatherData);
            return weatherData;
            ///////////////////////////////////////////////////////////////////
        }else{
            String errorResponse = response.getBody();
            WeatherError weatherError = WeatherError.parse(errorResponse);  
                System.debug('eeeeerorr'+ weatherError);
            throw new CalloutException(weatherError.error.message);
        }            
            //return error message+
            //create class with response structure(JSON2 APEX)+
            //write test class
    }
}