
public class WeatherApiResponse {
	// public class Status {
	// 	@AuraEnabled public Integer statusCode;
	// }

	public class Condition {
		//add auraEnabled
		@AuraEnabled public String text;
		@AuraEnabled public String icon;
		@AuraEnabled public Integer code;
	}

	@AuraEnabled public Location location;
	@AuraEnabled public Current current;

	public class Current {
		@AuraEnabled public Integer last_updated_epoch;
		@AuraEnabled public String last_updated;
		@AuraEnabled public Double temp_c;
		@AuraEnabled public Double temp_f;
		@AuraEnabled public Integer is_day;
		@AuraEnabled public Condition condition;
		@AuraEnabled public Double wind_mph;
		@AuraEnabled public Double wind_kph;
		@AuraEnabled public Integer wind_degree;
		@AuraEnabled public String wind_dir;
		@AuraEnabled public Double pressure_mb;
		@AuraEnabled public Double pressure_in;
		@AuraEnabled public Double precip_mm;
		@AuraEnabled public Double precip_in;
		@AuraEnabled public Integer humidity;
		@AuraEnabled public Integer cloud;
		@AuraEnabled public Double feelslike_c;
		@AuraEnabled public Double feelslike_f;
		@AuraEnabled public Double vis_km;
		@AuraEnabled public Double vis_miles;
		@AuraEnabled public Double uv;
		@AuraEnabled public Double gust_mph;
		@AuraEnabled public Double gust_kph;
	}

	public class Location {
		@AuraEnabled public String name;
		@AuraEnabled public String region;
		@AuraEnabled public String country;
		@AuraEnabled public Double lat;
		@AuraEnabled public Double lon;
		@AuraEnabled public String tz_id;
		@AuraEnabled public Integer localtime_epoch;
		@AuraEnabled public String localtime;
	}
	
	public static WeatherApiResponse parse(String json) {
		return (WeatherApiResponse) System.JSON.deserialize(json, WeatherApiResponse.class);
	}
}