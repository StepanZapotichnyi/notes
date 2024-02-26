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
    }


    handleGetWeather() {

        this.isLoading= true;
        
        getWeatherData({city: this.searchCity})
            .then(response => {  ;                               
                this.result = response;
                                               
            })
            .catch(error => {
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

}