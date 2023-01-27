public class PokeBatch implements Database.Batchable<Integer>,
Database.AllowsCallouts,Database.Stateful{
    
    List<Integer> PokemonList;//Almaceno los id`s
	//asigno esa lista a la variable de instancia
    public PokeBatch(List<Integer> PokemonList){this.PokemonList = PokemonList;}
    
	//retorno la lista de enteros que mediante la interfaz "iterable" recorro la lista de forma secuencial
	//procesando cada id y obteniendo la info para luego insertarlos
    public Iterable<Integer> start(Database.BatchableContext bc){return this.PokemonList;}
	//recibo la lista de id`s y las proceso 
    public void execute(Database.BatchableContext bc, List<Integer> records) {
        //por cada id invoco el metodo getPokemon pasando el id como parametro.
        Integer pokemonId = Integer.valueOf(records[0]);
        Pokemon__c pokemonToInsert = PokeHttpCallout.getPokemon(pokemonId);
			
            if(pokemonToInsert != null) {insert pokemonToInsert;}
       		else{System.debug('Error inserting Pokemon!');}
    }
    public void finish(Database.BatchableContext bc){}
}