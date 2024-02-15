import { LightningElement, track } from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import getWeatherData from '@salesforce/apex/WeatherApiController.getWeatherData';

export default class WeatherAPIApp extends LightningElement {
    
    searchCity;
    @track result;
    @track error;
    @track isLoading = false;
    

    handleDataChange(event) {
        this.searchCity = event.target.value;
        console.log('input-------'+this.searchCity);
    }


    handleGetWeather() {

        this.isLoading= true;
        console.log('after click-------' +this.searchCity);

        
        getWeatherData({city: this.searchCity})
            .then(response => {  
                console.log('response-----'+response);                               
                this.result = response;
                
                console.log('response-----'+ result);                               
            })
            .catch(error => {
                // console.log('error: ' + JSON.stringify(error));
                // console.log('error message: ' + JSON.parse(error.body.message).error.message);
                this.error = error.body.message;
                console.log('error message: ' + this.error);
                

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error ' ,
                        message: this.error,
                        variant: 'error'
                    })
                );

            })
            .finally(() =>{
                this.isLoading = false;
                this.searchCity = '';
            });
    }

        //add spinner
}