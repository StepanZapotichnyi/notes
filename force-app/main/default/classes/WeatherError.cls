
public class WeatherError {

	public class Error {
		@AuraEnabled public Integer code;
		@AuraEnabled public String message;
	}

	@AuraEnabled public Error error;

	
	public static WeatherError parse(String json) {
		return (WeatherError) System.JSON.deserialize(json, WeatherError.class);
	}
}