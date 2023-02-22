public class AbilityHttpCallout {
    
 public static Ability__c getAbility(Integer abilityId) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint('https://pokeapi.co/api/v2/ability/' + abilityId);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        Abilities abilityBodyToParse = new Abilities();


        if(response.getStatusCode() == 200) {String result = String.valueOf(response.getBody());
            abilityBodyToParse = Abilities.parse(result);
             return returnedAbility(abilityBodyToParse);}
        else {System.debug('Status code: ' + response.getStatusCode());
              return null;}}
       
        public static Ability__c returnedAbility(Abilities abilityParsed) {
        
        Ability__c newAbility = new Ability__c();

        newAbility.Name__c = abilityParsed.Name.capitalize();
        newAbility.Name = abilityParsed.Name.capitalize();
        newAbility.ExtId__c = abilityParsed.id;
        
         //Verifico que la lista effect entries esta vacia 
        if (abilityParsed.effect_entries.isEmpty()){newAbility.Effect__c = 'None';}
        
        else{//Verifico que el id es menor a 191 dado que desde este indice rompe
            if (abilityParsed.id < 191){//Se asigna el valor al segundo indice
                newAbility.Effect__c = abilityParsed.effect_entries[1].short_effect;
            }//Se asigna el valor al primer indice
            else{newAbility.Effect__c = abilityParsed.effect_entries[0].short_effect;
            }
        }
        
        return newAbility;
    }
}
