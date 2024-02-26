import { LightningElement, track } from 'lwc';
import getExchangeData from '@salesforce/apex/ExchangeApiController.getExchangeData';

const columns = [
    // { label: 'Country', fieldName: 'country' },
    { label: 'Country', fieldName: 'country' },
    { label: 'Price', fieldName: 'price' },
    { label: 'Currency', fieldName: 'currency' },
];


export default class ConvertAPIApp extends LightningElement {
    @track exchangeData;
    columns = columns;
    @track isLoading = false;

    connectedCallback(){
        this.allDataOfCurrency(); 
        console.log('connected');
    }

    allDataOfCurrency() {
        this.isLoading = true;
        getExchangeData()
        .then(response =>{
            console.log('respo:  ' + response);
            this.exchangeData = Object.keys(response.data).map(key =>({
                country: key,
                price: response.data[key],
                currency: parseFloat(response.data[key]).toFixed(2)
            }));
        })
        .catch(error => {
            this.exchangeText = 'This data is wrong!';
        });
        this.isLoading = false;
    }
}