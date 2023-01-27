import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import pokeIcon from '@salesforce/resourceUrl/PokeIcon';



export default class PokemonTile extends NavigationMixin(LightningElement) {

    pokeBall = pokeIcon;
    @api pokemon;

	
    // Ejecucion del metodo para navegar a la pagina de registro
    //Del objeto custom Pokemon__c 
    navigateToRecordViewPage(){this[NavigationMixin.Navigate](
                    //Paso de parámetros
                    {type: 'standard__recordPage',
                    attributes: {//Objeto Adicional para el mixin
                    recordId: this.pokemon.Id,
                    objectApiName: 'Pokemon__c', 
                    actionName: 'view'//Accion a realizar
                    }
                }
            );
        }
    }