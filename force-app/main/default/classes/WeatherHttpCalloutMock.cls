global class WeatherHttpCalloutMock implements HttpCalloutMock {
    global Integer statusCode;
    global String body;

    global WeatherHttpCalloutMock(Integer statusCode, String body) {
        this.statusCode = statusCode;
        this.body = body;
    }


    global HttpResponse respond(HttpRequest req) {
        System.assertEquals('GET', req.getMethod());
        System.assertNotEquals(null, req.getEndpoint(), 'Endpoint should not be null');

        
        HttpResponse res = new HttpResponse();
        res.setStatusCode(statusCode);
        res.setBody(body);
        return res;
    }
}