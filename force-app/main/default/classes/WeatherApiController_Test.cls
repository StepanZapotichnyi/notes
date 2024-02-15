@isTest
public class WeatherApiController_Test {
    @isTest
    static void testGetWeatherData() {
        // Prepare test data
        String cityName = 'Brno';
        String mock = '{"location": {"name": "Brno", "country": "Czech Republic"}, "current": {"temp_c": 20.5, "condition": {"text": "Overcast"}}}';
        
        //  HTTP response layout
    
        Test.setMock(HttpCalloutMock.class, new WeatherHttpCalloutMock(200, mock));
    
       //  call to the method 
        WeatherApiResponse  result = WeatherApiController.getWeatherData(cityName);

        // verify StatusCode
        // System.assertEquals(200, result.getStatusCode(), 'StatusCode will be 200');
        // verify data response
        System.assertNotEquals(null, result, 'Returned result should not be null');
        System.assertEquals('Brno', result.location.name, 'Name city will be Brno');
        System.assertEquals('Czech Republic', result.location.country, 'Country will be Czech Republic');
        System.assertEquals(20.5, result.current.temp_c, 'temperature will be 20.5');
        System.assertEquals('Overcast', result.current.condition.text, 'The weather should be Overcast');
    }

    @isTest
    static void testGetWeatherData_Error() {
        // Prepare test data
        String cityName = 'YourCity';
        String mockError = '{"error":{"code":404,"message":"Not Found"}}';

        //  HTTP response layout to simulate an error
        Test.setMock(HttpCalloutMock.class, new WeatherHttpCalloutMock(400, mockError));

        // Call the method being 
        try {
            WeatherApiController.getWeatherData(cityName);
            // If the method does not throw an exception, fail the test
            System.assert(false, 'The method should have thrown a CalloutException');
        } catch (CalloutException ex) {
            // Verify that the exception message is correct
            System.assertEquals('Not Found', ex.getMessage(), 'The exception message should be "Not Found"');
        }
    }
}