@IsTest
public class WeatherError_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'    \"error\": {'+
		'        \"code\": 1006,'+
		'        \"message\": \"No matching location found.\"'+
		'    }'+
		'}';
		WeatherError obj = WeatherError.parse(json);
		System.assert(obj != null);
	}
}