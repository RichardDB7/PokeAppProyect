import { LightningElement } from 'lwc';
import searchPokemons from '@salesforce/apex/PokemonController.searchPokemons';

export default class PokeFilter extends LightningElement {
    
    //Variables de paginado:
    // Todos los datos   // Indice actual // Columnas actuales
    FindPokemons =  [];   Paginated = 0;     DataRows = [];
    
    // Variables para los filtros
    searchText = ''; generation = 'All'; type = 'All';

    //Recupero datos filtrados de la clase Apex y actualizo datos 
    GetDataAndPutOnPage(){searchPokemons({ searchText: this.searchText, generation: this.generation, type: this.type })
        .then((result) => { this.FindPokemons = result; this.updatePage();})
        .catch((error) => {this.error = error;});
    }
    
    get getType () {return (this.type === 'All');}
    get getGen () {return (this.generation === '0');}

    
    // Inicializacion de pagina
    connectedCallback(){this.GetDataAndPutOnPage();}

    // Seteo el estado actual de la pagina
    updatePage() {this.DataRows = this.FindPokemons.slice(this.Paginated * 12, this.Paginated * 12 + 12);}
    // Regresar
    previous() {this.Paginated = Math.max(0, this.Paginated - 1);this.updatePage();}
    // Adelantar
    next(){this.Paginated = Math.min(Math.floor((this.FindPokemons.length - 9) / 10), this.Paginated + 1);this.updatePage();}
    
    // Gestion de entrada de texto y retraso de ejecución mediante set.timeout
    // console.log(event.detail.value);
    FindPokemonBox(event) {window.clearTimeout(this.delayTimeout);
        const searchText = event.target.value;this.delayTimeout =  setTimeout(() => {this.searchText = searchText;
            this.GetDataAndPutOnPage();}, 100);}

    //Filtro por generacion
    get optionsGeneration () {
        return [       
            { label: 'All', value: 'All' },{ label: '1st. Generation', value: '1st. Generation' },
            { label: '2nd. Generation', value: '2nd. Generation' },{ label: '3th. Generation', value: '3th. Generation' },
            { label: '4th. Generation', value: '4th. Generation' },{ label: '5th. Generation', value: '5th. Generation' },
            { label: '6th. Generation', value: '6th. Generation' },{ label: '7th. Generation', value: '7th. Generation' },
            { label: '8th. Generation', value: '8th. Generation' }
        ];
    }// Gestion de entrada de texto y retraso de ejecución mediante set.timeout
    GetPokesToChangeGeneration(event) {console.log(event.detail.value);window.clearTimeout(this.delayTimeout);
        const generation = event.target.value;this.delayTimeout = setTimeout(() => {
            this.generation = generation;this.GetDataAndPutOnPage();}, 300);}
            
    // Filtrado por tipos
    get optionsType () {
        return [
            { label: 'All', value: 'All' },{ label: 'Normal', value: 'Normal' },{ label: 'Fighting', value: 'Fighting' },
            { label: 'Flying', value: 'Flying' },{ label: 'Poison', value: 'Poison' },{ label: 'Ground', value: 'Ground' },
            { label: 'Rock', value: 'Rock' },{ label: 'Bug', value: 'Bug' },{ label: 'Ghost', value: 'Ghost' },
            { label: 'Steel', value: 'Steel' },{ label: 'Fire', value: 'Fire' },{ label: 'Water', value: 'Water' },
            { label: 'Grass', value: 'Grass' },{ label: 'Electric', value: 'Electric' },{ label: 'Psychic', value: 'Psychic' },
            { label: 'Ice', value: 'Ice' },{ label: 'Dragon', value: 'Dragon' },{ label: 'Dark', value: 'Dark' },
            { label: 'Fairy', value: 'Fairy' }
        ];
    }
    // console.log(event.detail.value);
    GetPokeToChangeTypes(event) {this.type = event.detail.value;this.GetDataAndPutOnPage();}
}