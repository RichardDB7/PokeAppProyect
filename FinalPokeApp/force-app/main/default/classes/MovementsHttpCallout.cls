public class MovementsHttpCallout {
	
	public static Movement__c getMove(Integer movimientId) {
    
        Http http = new Http();HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://pokeapi.co/api/v2/move/'+ movimientId);request.setMethod('GET');
        
        HttpResponse response = http.send(request);Moves movementBodyToParse = new Moves();
        
        if(response.getStatusCode() == 200){
            String result = String.valueOf(response.getBody());movementBodyToParse = Moves.parse(result);
           return returnMove(movementBodyToParse);
       	}else { System.debug('Status code: ' + response.getStatusCode());return null;}}
    
	//Metodo de objeto custom  que me trae los datos con paso de parámetro objeto moves
    public static Movement__c returnMove(Moves movementParsed){
	//Instancia del objeto custom
        Movement__c newMove = new Movement__c();
        //Asignacion de valores al objeto custom
        newMove.name = movementParsed.name == null ? 'No Name' : movementParsed.name.capitalize();
        newMove.name__c = movementParsed.name == null ? 'No Name' : movementParsed.name.capitalize();
        newMove.ExtId__c = movementParsed.id == null ? 0 : movementParsed.id;         
        newMove.accuracy__c = movementParsed.accuracy == null ? 'None' : String.valueOf(movementParsed.accuracy);                        
        newMove.effect_chance__c = movementParsed.effect_chance == null ? 'None' : movementParsed.effect_chance;            
        newMove.effect__c = movementParsed.effect_entries.isEmpty() ? 'No Effect' : movementParsed.effect_entries[0].short_effect;           
        newMove.power__c = movementParsed.power == null ? 'None' : String.valueOf(movementParsed.power);           
        newMove.pp__c = movementParsed.pp == null ? 'None' : String.valueOf(movementParsed.pp);            
        newMove.priority__c = movementParsed.priority == null ? 'None' : String.valueOf(movementParsed.priority);          
        newMove.type_name__c = movementParsed.type.name == null ? 'None' : movementParsed.type.name.capitalize();
        newMove.target_name__c = movementParsed.target.name == null ? 'None' : movementParsed.target.name;
        
        
        return newMove;
    }

    
}
