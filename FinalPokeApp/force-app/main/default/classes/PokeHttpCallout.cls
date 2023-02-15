public with sharing class PokeHttpCallout {

    public static Pokemon__c getPokemon(Integer pokemonId) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pokemonId);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
	//instancia que va a contener mi respuesta 200
	Pokemons pokemonBodyToParse = new Pokemons();
        
        if(response.getStatusCode() == 200) {String result = String.valueOf(response.getBody());
	//Si el status es 200 parseo la respuesta y la asigno al nuevo objeto pokemon
        pokemonBodyToParse = Pokemons.parse(result);return returnedPokemon(pokemonBodyToParse);}
        else{System.debug('Status code: ' + response.getStatusCode());return null;}}
    
	//Metodo de creacion de instancia con paso de parametro
   	 public static Pokemon__c returnedPokemon(Pokemons pokemonBodyToParse) {

        Pokemon__c newPokemon = new Pokemon__c();

        newPokemon.ExtId__c = pokemonBodyToParse.id;
        newPokemon.Name = pokemonBodyToParse.name.capitalize();
        newPokemon.Name__c = pokemonBodyToParse.name.capitalize();
        newPokemon.Heigth__c = Double.valueOf(pokemonBodyToParse.height) / 10;
        newPokemon.Weigth__c = Double.valueOf(pokemonBodyToParse.weight) / 10;
        newPokemon.Image__c = pokemonBodyToParse.sprites.front_default;   
        

        for (Integer i = 0; i <= 4; i++) {
            try {
                if(i == 0) {
                    newPokemon.Types__c = pokemonBodyToParse.types.get(i).type.name;
                }
                else {
                    newPokemon.Types__c = newPokemon.Types__c + ';' + pokemonBodyToParse.types.get(i).type.name;
                }
            }
            catch (Exception error) {
                break;
            }
        }
        
       
       
        Integer randomAbility = Integer.valueof((Math.random() * pokemonBodyToParse.abilities.Size()));
        String ability = pokemonBodyToParse.abilities.get(randomAbility).ability.name;  
             
        try {
            newPokemon.Ability__c = [
                SELECT Id 
                FROM Ability__c 
                WHERE Name=:ability 
                LIMIT 1
            ].Id;
        }
        catch(System.QueryException error) {
            System.debug(error);
        }
          
        // Creo metodo try catch para que no largue error, el error que salia es que en el campo velocidad estaba fuera de los limites List index out of bounds: 5
        if(pokemonBodyToParse.stats.get(0).base_stat != null) {
            newPokemon.stats_hp__c = String.valueOf(pokemonBodyToParse.stats.get(0).base_stat);
        }
        
        if(pokemonBodyToParse.stats.get(1).base_stat != null) {
        	newPokemon.stats_attack__c = String.valueOf(pokemonBodyToParse.stats.get(1).base_stat);
        }
        
        if(pokemonBodyToParse.stats.get(2).base_stat != null) {
            newPokemon.stats_defense__c = String.valueOf(pokemonBodyToParse.stats.get(2).base_stat);
        }
        
        if(pokemonBodyToParse.stats.get(5).base_stat != null) {
            newPokemon.stats_speed__c = String.valueOf(pokemonBodyToParse.stats.get(5).base_stat);
        }
                    
 
        try {if (pokemonBodyToParse.moves.size() >= 1) {

                String movement = pokemonBodyToParse.moves.get(0).move.name; 

                newPokemon.Slot1__c = [SELECT Id FROM Movement__c WHERE Name=:movement.capitalize()LIMIT 1].Id;}

            if (pokemonBodyToParse.moves.size() >= 2) {

                String movement = pokemonBodyToParse.moves.get(1).move.name;

                newPokemon.Slot2__c = [SELECT Id FROM Movement__c WHERE Name=:movement.capitalize()].Id;}
            
            if (pokemonBodyToParse.moves.size() >= 3) {

                String movement = pokemonBodyToParse.moves.get(2).move.name;  
            
      			newPokemon.Slot3__c = [SELECT Id FROM Movement__c WHERE Name=:movement].Id;}
            
            if (pokemonBodyToParse.moves.size() >= 4) {

                String movement = pokemonBodyToParse.moves.get(3).move.name;  
            
                newPokemon.Slot4__c = [SELECT Id FROM Movement__c WHERE Name=:movement].Id;}         
        }
        catch(System.NullPointerException error) {
            System.debug(error);
        }
        
             
        return newPokemon;  
    }
  }
