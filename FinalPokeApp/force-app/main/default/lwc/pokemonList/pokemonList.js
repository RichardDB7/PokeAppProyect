import { LightningElement ,wire} from 'lwc';
import getPokemons from '@salesforce/apex/PokeService.getPokemons';

export default class PokemonList extends LightningElement {

    //@wire(getPokemons)
    // pokemons;
    //@api pokemon;
    //pokemon=true;

    //Gestion del metodo getPokemons mediante decorador @wire
    @wire(getPokemons) pokemons;
    
    //connectedCallback(){console.log('AAAAAAAAAAAAAAAA',this.pokemons)}
    // pokemon = [
    //     {
    //     Name: "Pikachu",
    //     Types__c: "Electric",
    //     Generation__c: "1ra",
    //     heigth__c: "1.4",
    //     weigth__c: "60",
    //     ExtId__c: "10",
    //     Image__c: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    //     },
    //     {
    //         Name: "Pikachu",
    //         Types__c: "Electric",
    //         Generation__c: "1ra",
    //         heigth__c: "1.4",
    //         weigth__c: "60",
    //         ExtId__c: "10",
    //         Image__c: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    //         },
        
    //         {
    //             Name: "Pikachu",
    //             Types__c: "Electric",
    //             Generation__c: "1ra",
    //             heigth__c: "1.4",
    //             weigth__c: "60",
    //             ExtId__c: "10",
    //             Image__c: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    //             }, {
    //                 Name: "Pikachu",
    //                 Types__c: "Electric",
    //                 Generation__c: "1ra",
    //                 heigth__c: "1.4",
    //                 weigth__c: "60",
    //                 ExtId__c: "10",
    //                 Image__c: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    //                 }, {
    //                     Name: "Pikachu",
    //                     Types__c: "Electric",   
    //                     Generation__c: "1ra",
    //                     heigth__c: "1.4",
    //                     weigth__c: "60",
    //                     ExtId__c: "10",
    //                     Image__c: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    //                     }] 
                
                



}