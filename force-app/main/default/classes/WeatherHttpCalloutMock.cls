global class WeatherHttpCalloutMock implements HttpCalloutMock {
    global Integer statusCode;
    global String body;

    global WeatherHttpCalloutMock(Integer statusCode, String body) {
        this.statusCode = statusCode;
        this.body = body;
    }


    global HttpResponse respond(HttpRequest req) {
        System.assertEquals('GET', req.getMethod());
        // System.assertEquals('http://api.weatherapi.com/v1/current.json?key=8407b67d2f2f471682d140154242901&q='+ city, req.getEndpoint());
        System.assertNotEquals(null, req.getEndpoint(), 'Endpoint should not be null');

        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(statusCode);
        res.setBody(body);
        return res;
    }
}