@isTest
public with sharing class ExchangeApiController_Test {
    @isTest
    static void testGetExchangeData() {
        String mockExchangeData = '{"data": {"AUD": 1.5306802355, "BGN": 1.80972023,"BRL": 4.9673306889,"CAD": 1.348590205,"CHF": 0.8810001511,"CNY": 7.1917012636,"CZK": 23.5811829368,"DKK": 6.9168607077,"EUR": 0.9277901434,"GBP": 0.7936301211,"HKD": 7.8198109495,"HRK": 7.0219212915,"HUF": 361.1739928031,"IDR": 15601 } }';

        Test.setMock(HttpCAlloutMock.class, new ExchangeDataHttpCalloutMock(200 , mockExchangeData));

        ExchangeApiResponse result = ExchangeApiController.getExchangeData();

        System.assertNotEquals(null, result, 'Returned result should not be null');

        System.assertEquals(1.80972023, result.data.BGN,  'BNG will be 1.80972023');
        System.assertEquals(1.5306802355, result.data.AUD,  'AUD will be 1.5306802355');
        System.assertEquals(0.8810001511, result.data.CHF,  'CHF will be 0.88100015113');
        System.assertEquals(23.5811829368, result.data.CZK,  'CZK will be 23.5811829368');

    }

    @isTest
    static void testGetExchangeData_Error() {

        
        Test.setMock(HttpCAlloutMock.class, new ExchangeDataHttpCalloutMock(400 , ''));
        
        try {
            // Call the method under test
            ExchangeApiController.getExchangeData();
            
            // If the method does not throw an exception, fail the test
            System.assert(false, 'The method should have thrown a CalloutException');
        } catch (CalloutException ex) {
            // Verify that the exception message is correct
            System.assert(ex.getMessage().contains('HTTP request failed with status code 400'), 'The exception message should indicate the HTTP status code');
        }

    }
}