import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';



export default class PokeCards extends NavigationMixin(LightningElement) {

    
    pokemon = {
        Name: 'Pikachu',
        Types__c: 'Electric',
        Generation__c: '1ra',
        heigth__c: 1.4,
        weigth__c: 60,
        ExtId__c: '10',
        Image__c: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png'
    };
    
    
    //@api pokemon='';
    

    navigateToRecordViewPage() {
        // View a custom object record
        this[NavigationMixin.Navigate](
            {
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.pokemon.Id,
                    objectApiName: 'Pokemon__c', // objectApiName is optional
                    actionName: 'view'
                }
            }
        );
    }

}