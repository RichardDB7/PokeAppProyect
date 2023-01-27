public with sharing class PokeService {
    
	//Metodo de retorno hacia el controlador js
    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> getPokemons() {
      
      return[SELECT Id, Name, Generation__c, Types__c, weigth__c, heigth__c,  Image__c, ExtId__c,stats_hp__c
        FROM Pokemon__c];}


}