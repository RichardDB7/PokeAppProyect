import { LightningElement, wire } from 'lwc';
import searchPokemons from '@salesforce/apex/PokemonController.searchPokemons';


export default class pokeList extends LightningElement {


	searchText = '';
	generation = 'All';
	type = 'All';

	
	@wire(searchPokemons,{ searchText: '$searchText', generation: '$generation', type: '$type' })
	 pokemons;
	

	get getType () {
		return (this.type === 'All');
	}

	get getGen () {
		return (this.generation === '0');
	}


	// FILTER BY POKEMON NAME
	handleSearchTextChange(event) {
		
		// console.log(event.detail.value);
        window.clearTimeout(this.delayTimeout);
		const searchText = event.target.value;
		
		// eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout =  setTimeout(() => {
			this.searchText = searchText;
		}, 100);
	}


	// FILTER BY POKEMON GENERATION
	get optionsGeneration () {
		return [
			{ label: 'All', value: 'All' },
			{ label: '1ra', value: '1ra' },
			{ label: '2da', value: '2da' },
			{ label: '3ra', value: '3ra' },
			{ label: '4ta', value: '4ta' },
			{ label: '5ta', value: '5ta' },
			{ label: '6ta', value: '6ta' },
			{ label: '7ma', value: '7ma' },
			{ label: '8va', value: '8va' }
		];
	}

	handleGeneracionChange(event) {

		// console.log(event.detail.value);
		window.clearTimeout(this.delayTimeout);
		const generation = event.target.value;

		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.generation = generation;
		}, 300);
	}


	// FILTER BY POKEMON TYPE 
	get optionsType () {
		return [
			{ label: 'All', value: 'All' },
			{ label: 'Normal', value: 'Normal' },
			{ label: 'Fighting', value: 'Fighting' },
			{ label: 'Flying', value: 'Flying' },
			{ label: 'Poison', value: 'Poison' },
			{ label: 'Ground', value: 'Ground' },
			{ label: 'Rock', value: 'Rock' },
			{ label: 'Bug', value: 'Bug' },
			{ label: 'Ghost', value: 'Ghost' },
			{ label: 'Steel', value: 'Steel' },
			{ label: 'Fire', value: 'Fire' },
			{ label: 'Water', value: 'Water' },
			{ label: 'Grass', value: 'Grass' },
			{ label: 'Electric', value: 'Electric' },
			{ label: 'Psychic', value: 'Psychic' },
			{ label: 'Ice', value: 'Ice' },
			{ label: 'Dragon', value: 'Dragon' },
			{ label: 'Dark', value: 'Dark' },
			{ label: 'Fairy', value: 'Fairy' }
		];
	}

	handleTypeChange(event) {
		// console.log(event.detail.value);
		this.type = event.detail.value;
	}

}