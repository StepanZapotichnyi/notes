public class ExchangeApiResponse {

	@AuraEnabled public Data data {get;set;} 

	public ExchangeApiResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new Data(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'ExchangeApiResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Data {
		@AuraEnabled public Double AUD {get;set;} 
		@AuraEnabled public Double BGN {get;set;} 
		@AuraEnabled public Double BRL {get;set;} 
		@AuraEnabled public Double CAD {get;set;} 
		@AuraEnabled public Double CHF {get;set;} 
		@AuraEnabled public Double CNY {get;set;} 
		@AuraEnabled public Double CZK {get;set;} 
		@AuraEnabled public Double DKK {get;set;} 
		@AuraEnabled public Double EUR {get;set;} 
		@AuraEnabled public Double GBP {get;set;} 
		@AuraEnabled public Double HKD {get;set;} 
		@AuraEnabled public Double HRK {get;set;} 
		@AuraEnabled public Double HUF {get;set;} 
		@AuraEnabled public Double IDR {get;set;} 
		@AuraEnabled public Double ILS {get;set;} 
		@AuraEnabled public Double INR {get;set;} 
		@AuraEnabled public Double ISK {get;set;} 
		@AuraEnabled public Double JPY {get;set;} 
		@AuraEnabled public Double KRW {get;set;} 
		@AuraEnabled public Double MXN {get;set;} 
		@AuraEnabled public Double MYR {get;set;} 
		@AuraEnabled public Double NOK {get;set;} 
		@AuraEnabled public Double NZD {get;set;} 
		@AuraEnabled public Double PHP {get;set;} 
		@AuraEnabled public Double PLN {get;set;} 
		@AuraEnabled public Double RON {get;set;} 
		@AuraEnabled public Double RUB {get;set;} 
		@AuraEnabled public Double SEK {get;set;} 
		@AuraEnabled public Double SGD {get;set;} 
		@AuraEnabled public Double THB {get;set;} 
		@AuraEnabled public Double TRY_Z {get;set;} // in json: TRY
		@AuraEnabled public Integer USD {get;set;} 
		@AuraEnabled public Double ZAR {get;set;} 

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'AUD') {
							AUD = parser.getDoubleValue();
						} else if (text == 'BGN') {
							BGN = parser.getDoubleValue();
						} else if (text == 'BRL') {
							BRL = parser.getDoubleValue();
						} else if (text == 'CAD') {
							CAD = parser.getDoubleValue();
						} else if (text == 'CHF') {
							CHF = parser.getDoubleValue();
						} else if (text == 'CNY') {
							CNY = parser.getDoubleValue();
						} else if (text == 'CZK') {
							CZK = parser.getDoubleValue();
						} else if (text == 'DKK') {
							DKK = parser.getDoubleValue();
						} else if (text == 'EUR') {
							EUR = parser.getDoubleValue();
						} else if (text == 'GBP') {
							GBP = parser.getDoubleValue();
						} else if (text == 'HKD') {
							HKD = parser.getDoubleValue();
						} else if (text == 'HRK') {
							HRK = parser.getDoubleValue();
						} else if (text == 'HUF') {
							HUF = parser.getDoubleValue();
						} else if (text == 'IDR') {
							IDR = parser.getDoubleValue();
						} else if (text == 'ILS') {
							ILS = parser.getDoubleValue();
						} else if (text == 'INR') {
							INR = parser.getDoubleValue();
						} else if (text == 'ISK') {
							ISK = parser.getDoubleValue();
						} else if (text == 'JPY') {
							JPY = parser.getDoubleValue();
						} else if (text == 'KRW') {
							KRW = parser.getDoubleValue();
						} else if (text == 'MXN') {
							MXN = parser.getDoubleValue();
						} else if (text == 'MYR') {
							MYR = parser.getDoubleValue();
						} else if (text == 'NOK') {
							NOK = parser.getDoubleValue();
						} else if (text == 'NZD') {
							NZD = parser.getDoubleValue();
						} else if (text == 'PHP') {
							PHP = parser.getDoubleValue();
						} else if (text == 'PLN') {
							PLN = parser.getDoubleValue();
						} else if (text == 'RON') {
							RON = parser.getDoubleValue();
						} else if (text == 'RUB') {
							RUB = parser.getDoubleValue();
						} else if (text == 'SEK') {
							SEK = parser.getDoubleValue();
						} else if (text == 'SGD') {
							SGD = parser.getDoubleValue();
						} else if (text == 'THB') {
							THB = parser.getDoubleValue();
						} else if (text == 'TRY') {
							TRY_Z = parser.getDoubleValue();
						} else if (text == 'USD') {
							USD = parser.getIntegerValue();
						} else if (text == 'ZAR') {
							ZAR = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static ExchangeApiResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new ExchangeApiResponse(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	




}