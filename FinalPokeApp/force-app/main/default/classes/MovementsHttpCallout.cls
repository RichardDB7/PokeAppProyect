//Llamada a los movimientos de la api mediante el protocolo http
public class MovementsHttpCallout {
    //Metodo de llamada con parámetro de tipo entero
	public static Movement__c getMove(Integer movimientId) {
        //Instancias para crear la solicitud GET
        Http http = new Http();HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://pokeapi.co/api/v2/move/'+ movimientId);request.setMethod('GET');
        
        HttpResponse response = http.send(request);Moves movementBodyToParse = new Moves();
        
        if(response.getStatusCode() == 200){
			//Recibo el status 200		
            String result = String.valueOf(response.getBody());
            //Si el resultado es 200 se parsea el body en el objeto moves mediante parse()	
            movementBodyToParse = Moves.parse(result);
            //Retorno el objeto custom con el body parseado
			return returnMove(movementBodyToParse);
        }else { System.debug('Status code: ' + response.getStatusCode());return null;}
    }
    
	//Metodo de objeto custom  que me trae los datos con paso de parámetro objeto moves
    public static Movement__c returnMove(Moves movementParsed){
		//Instancia del objeto custom
        Movement__c newMove = new Movement__c();
        //Asignacion de valores al objeto custom
        if(movementParsed.name != null){newMove.Name = movementParsed.name.capitalize();newMove.name__c = movementParsed.name;}
        else{newMove.Name = 'No Name found';newMove.name__c = 'No Name found';}
		if(movementParsed.id != null){newMove.ExtId__c = movementParsed.id;}else{newMove.ExtId__c = 0;}
		if(movementParsed.accuracy != null){newMove.accuracy__c = String.valueOf(movementParsed.accuracy);}
        else{newMove.accuracy__c = 'None';}
		if(movementParsed.effect_chance != null){newMove.effect_chance__c = movementParsed.effect_chance;}
        else{newMove.effect_chance__c = 'None';}
		if(!movementParsed.effect_entries.isEmpty()){newMove.effect__c = movementParsed.effect_entries[0].short_effect;}  
        else{newMove.effect__c = 'No Effect';}if(movementParsed.power != null){newMove.power__c = String.valueOf(movementParsed.power);}           
        else{newMove.power__c = 'None';}
		if(movementParsed.pp != null){newMove.pp__c = String.valueOf(movementParsed.pp);}else{newMove.pp__c = 'None';}
		if(movementParsed.priority != null){newMove.priority__c = String.valueOf(movementParsed.priority);}
        else{newMove.priority__c = 'None';}
		if(movementParsed.type.name != null){newMove.type_name__c = movementParsed.type.name.capitalize();}
        else{newMove.type_name__c = 'None';}
		if(movementParsed.target.name != null){newMove.target_name__c = movementParsed.target.name;}
        else{newMove.target_name__c = 'None';}
        
        
        return newMove;
    }

    
}