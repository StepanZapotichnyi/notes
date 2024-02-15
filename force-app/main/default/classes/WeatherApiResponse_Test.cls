
@IsTest
public class WeatherApiResponse_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'    \"location\": {'+
		'        \"name\": \"Lviv\",'+
		'        \"region\": \"\",'+
		'        \"country\": \"Ukraine\",'+
		'        \"lat\": 49.83,'+
		'        \"lon\": 24.0,'+
		'        \"tz_id\": \"Europe/Kiev\",'+
		'        \"localtime_epoch\": 1707140714,'+
		'        \"localtime\": \"2024-02-05 15:45\"'+
		'    },'+
		'    \"current\": {'+
		'        \"last_updated_epoch\": 1707139800,'+
		'        \"last_updated\": \"2024-02-05 15:30\",'+
		'        \"temp_c\": 4.8,'+
		'        \"temp_f\": 40.7,'+
		'        \"is_day\": 1,'+
		'        \"condition\": {'+
		'            \"text\": \"Patchy rain nearby\",'+
		'            \"icon\": \"//cdn.weatherapi.com/weather/64x64/day/176.png\",'+
		'            \"code\": 1063'+
		'        },'+
		'        \"wind_mph\": 20.6,'+
		'        \"wind_kph\": 33.1,'+
		'        \"wind_degree\": 287,'+
		'        \"wind_dir\": \"WNW\",'+
		'        \"pressure_mb\": 1006.0,'+
		'        \"pressure_in\": 29.69,'+
		'        \"precip_mm\": 0.01,'+
		'        \"precip_in\": 0.0,'+
		'        \"humidity\": 90,'+
		'        \"cloud\": 100,'+
		'        \"feelslike_c\": -0.5,'+
		'        \"feelslike_f\": 31.2,'+
		'        \"vis_km\": 10.0,'+
		'        \"vis_miles\": 6.0,'+
		'        \"uv\": 1.0,'+
		'        \"gust_mph\": 29.4,'+
		'        \"gust_kph\": 47.3'+
		'    }'+
		'}';
		WeatherApiResponse obj = WeatherApiResponse.parse(json);
		System.assert(obj != null);
	}
}