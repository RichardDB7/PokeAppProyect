import { LightningElement } from 'lwc';
import searchPokemons from '@salesforce/apex/PokemonController.searchPokemons';

export default class PokeFilter extends LightningElement {
    
    //Variables de que mantienenn los datos actuales y la paginacion:
    // Todos los datos   // Indice actual // Columnas actuales
    FindPokemons =  [];   Paginated = 0;     DataRows = [];
    
     // Variables para almacenar los valores de los filtros
    searchText = ''; generation = 'All'; type = 'All';

    //Promise
    //Recupero datos filtrados de la clase Apex y actualizo datos 
                                //Llamado a la clase apex y paso de argumentos
    GetDataAndPutOnPage(){searchPokemons({ searchText: this.searchText, generation: this.generation, type: this.type })
        //La promesa devuelve el resultado,se asigna a FindPokemons y actualiza mediante updatePage
        .then((result) => { this.FindPokemons = result; this.updatePage();})
        //Si la llamada falla se captura el error y se asigna a la propiedad error para su posterior manejo                  
        .catch((error) => {this.error = error;});
    }
    
    get getType () {return (this.type === 'All');}
    get getGen () {return (this.generation === '0');}

    
    // Inicializacion de pagina mediante conected callback(insercion de elemento customizado)
    connectedCallback(){this.GetDataAndPutOnPage();}

    // Actualizacion del estado de la pagina
    //Divido el resultado almacenado en el primer array mediante la funcion slice
    updatePage() {this.DataRows = this.FindPokemons.slice(this.Paginated * 12, this.Paginated * 12 + 12);}
    // Actualiza la propiedad "Paginated" para asegurarse de que se está retrocediendo una página.
    previous() {this.Paginated = Math.max(0, this.Paginated - 1);this.updatePage();}
    // Adelanta y Asigna un nuevo valor a la propiedad Paginated
    //Calculo el nuevo valor para Paginated como el mínimo 
    //entre el resultado de la operación Math.floor((this.FindPokemons.length - 9) / 10) 
    next(){this.Paginated = Math.min(Math.floor((this.FindPokemons.length - 9) / 10), this.Paginated + 1);this.updatePage();}
    
    // Gestion de entrada de texto y retraso de ejecución mediante set.timeout
    //Limpio temporizador previamente establecido con window.clearTimeout(this.delayTimeout
    // console.log(event.detail.value);
    FindPokemonBox(event) {window.clearTimeout(this.delayTimeout);                  
        //Establece un nuevo temporizador con setTimeout, ejecuto en 100ms, asigno valor de busqueda   
        const searchText = event.target.value;this.delayTimeout =  setTimeout(() => {this.searchText = searchText;
            this.GetDataAndPutOnPage();}, 100);}

    //El propósito de establecer un temporizador es permitir que la búsqueda 
       //se realice después de un retraso de 100 milisegundos en lugar de inmediatamente 
       //después de cada tecla presionada. Esto es para evitar una sobrecarga 
       //en la búsqueda y puede ser útil para mejorar la experiencia del usuario 
       //y el rendimiento de la aplicación.
    
    
   //Getter que devuelve el arrray de objetos con las opciones para generation
    get optionsGeneration () {
        return [       
            { label: 'All', value: 'All' },{ label: '1st. Generation', value: '1st. Generation' },
            { label: '2nd. Generation', value: '2nd. Generation' },{ label: '3th. Generation', value: '3th. Generation' },
            { label: '4th. Generation', value: '4th. Generation' },{ label: '5th. Generation', value: '5th. Generation' },
            { label: '6th. Generation', value: '6th. Generation' },{ label: '7th. Generation', value: '7th. Generation' },
            { label: '8th. Generation', value: '8th. Generation' }
        ];
    }
    
      //Cambio de valores de filtro generacion y retraso de ejecución mediante set.timeout
    GetPokesToChangeGeneration(event) {console.log(event.detail.value);window.clearTimeout(this.delayTimeout);
        //Almaceno el valor de la generación seleccionada y establesco un timeout en 300ms
          const generation = event.target.value;this.delayTimeout = setTimeout(() => {
        //invoco GetDataAndPutOnPage para actualizar la página con los datos actualizados.
            this.generation = generation;this.GetDataAndPutOnPage();}, 300);}
            
        // Getter que retorna el array de objetos donde cada objeto es un pokemon type
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
    //Al producirse un evento actualizo el objeto y llamo a otra funcion para mostrar los datos actualizados
    GetPokeToChangeTypes(event) {this.type = event.detail.value;this.GetDataAndPutOnPage();}
}
