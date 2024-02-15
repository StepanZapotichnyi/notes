import { LightningElement, track } from 'lwc';
// import getConvertData from '@salesforce/apex/ExchangeApiController.getConvertData';
import getExchangeData from '@salesforce/apex/ExchangeApiController.getExchangeData';

export default class ConvertAPIApp extends LightningElement {
    // exchangeFrom;
    // exchangeTo;
    // ledAmount;
    // convertResult;
    // convertKey;
    // convertRate;
    // exchangeText;
    @track exchangeData;

    // exPnL;
    // exEur;
    // exCzk;
    // exGbp;



    connectedCallback(){
        this.allDataOfCurrency(); 
        console.log('connected');
    }



    // handleCurrencyFrom(event) {
    //     let fromE =  event.target.value;
    //     this.exchangeFrom = fromE.toUpperCase();
    // }

    // handleCurrencyTo(event) {
    //     let to = event.target.value;
    //     this.exchangeTo = to.toUpperCase();

    // }

    // handleCurrencySum(event) {
    //     this.ledAmount = event.target.value;
    // }

    // handleGetConvert(){
    //     console.log('After click', this.exchangeFrom);
    //     console.log('After click', this.exchangeTo);
    //     console.log('After click', this.ledAmount);
    //     let selectedExchange = this.exchangeTo;
    //         console.log('No exchange');
    //         getConvertData({since: this.exchangeFrom,
    //                         to: this.exchangeTo,
    //                         amount: this.ledAmount})
    //         .then(response => {
    //             let convertParsData = JSON.parse(response);
    //             this.convertResult = convertParsData.result;
    //             this.convertRate = convertParsData.result.rate;
    //             console.log('I '+ this.exchangeTo);

    //             console.log('I work1');
    //             for(let key in this.convertResult) {
    //                 if(selectedExchange == key){
    //                     this.convertKey = key +'------'+ this.convertResult[key];
                
    //                 }
    //                 console.log('I work4');
    //             }
    //             console.log(this.convertKey);

    //             console.log(this.convertRate);


                

    //         })
    //         .catch(error => {
    //             this.exchangeText = 'This data is wrong!';
    //             console.error('<---------error---------->', JSON.stringify(error) );

    //         }) 
            
    //         this.exchangeFrom = '';
    //         this.exchangeTo = '';
    //         this.ledAmount = '';
        
    // }

    allDataOfCurrency() {

        // console.log('hhh' + data);
        getExchangeData()
        
        .then(response =>{
            console.log('respo:  ' + response);

            this.exchangeData = JSON.parse(response);
            console.log('reeeessss' + exchangeData);
            // let exchange = exchangeData.data;
            // console.log('exchange' + exchange);

            // for(let key in exchange) {

            //     if(key == "PLN") {
            //         this.exPnL = exchange[key];
            //     }else if (key == "CZK") {
            //         this.exCzk = exchange[key];
            //     }else if (key == "EUR") {
            //         this.exEur = exchange[key];
            //     }else if (key == "GBP") {
            //         this.exGbp = exchange[key];
            //     }
            // }
            
            
            // this.exPnL = exchangeData.data.PLN;
            // this.exCzk = exchangeData.data.CZK;
            // this.exEur = exchangeData.data.EUR;
            // this.exGbp = exchangeData.data.GBP;
            
            // console.log('All----' + this.exPnL + '-' + this.exCzk +'-' + this.exEur +'-' + this.exGbp);



        })
        .catch(error => {
            this.exchangeText = 'This data is wrong!';
            console.error('<---------error---------->', JSON.stringify(error) );

        })
    }



}