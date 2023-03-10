public with sharing class PokemonController {
	@AuraEnabled(cacheable = true)//acceso y mejora de rendimiento
	//Las llamadas al backend siempre son estaticas
        public static List<Pokemon__c> searchPokemons(String searchText, String generation, String type) {

        //system.debug(generation);	
        //Concateno el valor de busqueda con los caracteres
        String entryData = '%' + searchText + '%';//% se utiliza para buscar la palabra
        String QUERY = 'SELECT Name, Id, ExtId__c, Generation__c, Image__c, heigth__c, weigth__c, Types__c, stats_hp__c,stats_attack__c FROM Pokemon__c';
	
		  
        if (entryData != ''){QUERY += ' WHERE Name LIKE :entryData';}
          
        if (type != 'All'){QUERY += ' AND Types__c INCLUDES(:type)';}
          
        if (generation != 'All') {QUERY += ' AND Generation__c =:generation';}
          
        QUERY += ' ORDER BY ExtId__c';
     
        return Database.query(QUERY);
    }
}
