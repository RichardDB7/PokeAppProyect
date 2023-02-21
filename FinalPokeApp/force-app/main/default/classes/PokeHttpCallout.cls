public with sharing class PokeHttpCallout {

    public static Pokemon__c getPokemon(Integer pokemonId) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pokemonId);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
		
	Pokemons pokemonBodyToParse = new Pokemons();
        
        if(response.getStatusCode() == 200) {String result = String.valueOf(response.getBody());
       
        pokemonBodyToParse = Pokemons.parse(result);return returnedPokemon(pokemonBodyToParse);}
        else{System.debug('Status code: ' + response.getStatusCode());return null;}}
    
		
   	public static Pokemon__c returnedPokemon(Pokemons pokemonBodyToParse) {

        Pokemon__c newPokemon = new Pokemon__c();
        
        newPokemon.ExtId__c = pokemonBodyToParse.id;
        newPokemon.Name = pokemonBodyToParse.name.capitalize();
        newPokemon.Name__c = pokemonBodyToParse.name.capitalize();
        newPokemon.Heigth__c = Double.valueOf(pokemonBodyToParse.height) / 10;
        newPokemon.Weigth__c = Double.valueOf(pokemonBodyToParse.weight) / 10;         
  	newPokemon.Image__c = pokemonBodyToParse.sprites.front_default;
	newPokemon.stats_hp__c = String.valueOf(pokemonBodyToParse.stats.get(0).base_stat);
	newPokemon.stats_attack__c = String.valueOf(pokemonBodyToParse.stats.get(1).base_stat);
	newPokemon.stats_defense__c = String.valueOf(pokemonBodyToParse.stats.get(2).base_stat);
	newPokemon.stats_speed__c = String.valueOf(pokemonBodyToParse.stats.get(5).base_stat);
         
        for (Integer i = 0; i <= 4; i++){
      	try{if(i == 0){newPokemon.Types__c = pokemonBodyToParse.types.get(i).type.name;
        }else {newPokemon.Types__c = newPokemon.Types__c +';'+ pokemonBodyToParse.types.get(i).type.name;}
        }catch (Exception error){break;}}
        
        Integer randomAbility = Integer.valueof((Math.random() * pokemonBodyToParse.abilities.Size()));
        String ability = pokemonBodyToParse.abilities.get(randomAbility).ability.name;  
             
        try{newPokemon.Ability__c = [SELECT Id FROM Ability__c WHERE Name=:ability LIMIT 1].Id;
        }catch(System.QueryException error) {System.debug(error);}
  
        try {for (Integer i = 0; i < pokemonBodyToParse.moves.size(); i++){
        String movement = pokemonBodyToParse.moves.get(i).move.name;
        String fieldName = 'Slot' + (i + 1) + '__c';
        List<Movement__c> movements = [SELECT Id FROM Movement__c WHERE Name = :movement LIMIT 1];
        if (!movements.isEmpty()){newPokemon.put(fieldName, movements[0].Id);}}
	}catch (Exception e){System.debug(e.getMessage());}		
             
        return newPokemon;
     }
  }
