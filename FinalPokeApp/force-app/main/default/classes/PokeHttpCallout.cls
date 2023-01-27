public with sharing class PokeHttpCallout {

    public static Pokemon__c getPokemon(Integer pokemonId) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pokemonId);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
		Pokemons pokemonBodyToParse = new Pokemons();
        
        if(response.getStatusCode() == 200) {String result = String.valueOf(response.getBody());
        pokemonBodyToParse = Pokemons.parse(result);return returnPokemon(pokemonBodyToParse);}
        else{System.debug('Status code: ' + response.getStatusCode());return null;}}
    
		//Metodo de creacion de instancia con paso de parametro
   		 public static Pokemon__c returnPokemon(Pokemons pokeParsed) {

        Pokemon__c newPokemon = new Pokemon__c();
		//Asignacion de variables traidos del objeto Pokemons
       	newPokemon.ExtId__c = pokeParsed.id;newPokemon.name = pokeParsed.name.capitalize(); 
        newPokemon.heigth__c = pokeParsed.height;newPokemon.Image__c = pokeParsed.sprites.front_default;   
       	newPokemon.weigth__c = pokeParsed.weight; 
        
        //Recorrido de asignacion a los tipos
        for (Integer i = 0; i <= 4; i++) 
        {try{if(i == 0) {newPokemon.Types__c = pokeParsed.types.get(i).type.name;}
        else {newPokemon.Types__c = newPokemon.Types__c + ';' + pokeParsed.types.get(i).type.name;}
        }catch (Exception error) {break;}}
       
        
        Integer AbilityAssign  = Integer.valueof((Math.random() * pokeParsed.abilities.Size()));
        String ability = pokeParsed.abilities.get(AbilityAssign).ability.name; 
        
        //Asignacion de Habilidad mediante busqueda del id     
        try{newPokemon.Ability__c = [SELECT Id FROM Ability__c WHERE Name=:ability LIMIT 1].Id;}
        catch(System.QueryException error) {System.debug(error);}
        
     	//Creo un mapeo claves int y valores string
        Map<Integer, String> statsMap = new Map<Integer, String>
        {0 => 'stats_hp__c',1 => 'stats_attack__c',2 => 'stats_defense__c',5 => 'stats_speed__c'};
        //Compruebo en cada vuelta si la lista es mayor    
		for(Integer i : statsMap.keySet()){if(pokeParsed.stats.size() > i)
        //Añado el valor convertido base_stat de la lista pokemonParsed.stats al objeto     
        {newPokemon.put(statsMap.get(i), String.valueOf(pokeParsed.stats.get(i).base_stat));}}
        
        for(Integer i = 1; i <= 4; i++){
        //En cada iteracion se asigna un numero aleatorio a la variable SlotMove  y al tamaño de la lista  
   		Integer SlotMove = Integer.valueof((Math.random()*pokeParsed.moves.Size()));
        //Utilizo el numero para obtener el nombre del moviemiento de la lista    
    	String movement = pokeParsed.moves.get(SlotMove).move.name;
        //Consulto si el registro contiene un nombre igual al anterior    
    	Movement__c move = [SELECT Id FROM Movement__c WHERE Name=:movement LIMIT 1];
        //Si es el caso añado mediante el metodo put dentro del campo custom mas el id encontrado    
    	if(move != null){newPokemon.put('Slot' + i + '__c', move.Id);}
        else {System.debug('Movement not found');}}
        return newPokemon;

    }
  }