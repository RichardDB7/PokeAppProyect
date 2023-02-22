@isTest
public with sharing class PokemonControllerTest {
    
    @isTest
    public static void PokemonsControllerSuccessTest() {
        
        test.startTest();
        delete [SELECT fields(standard) FROM Pokemon__c];//Borro registro 
        insert New Pokemon__c(ExtId__c = 1);
        test.stopTest();        
        
        List<Pokemon__c> pokemonToTest = [SELECT Name, ExtId__c, Image__c, Types__c, 
                                          Generation__c, heigth__c, weigth__c FROM Pokemon__c 
                                          WHERE ExtId__c = 1 LIMIT 1]; //Busco coincidencia
        
        List<Pokemon__c> pokemonSearch = PokemonController.searchPokemons('Pikachu', '', '0');
        System.assertEquals(pokemonSearch.get(0), pokemonToTest.get(0));//Comparo listas
        
    }
    
    @isTest
    public static void PokemonsControllerErrrorTest() {
        
        Test.startTest();
        delete [SELECT fields(standard) FROM Pokemon__c];
        insert new Pokemon__c(ExtId__c = 1);
        Test.stopTest();
        
        List<Pokemon__c> pokemonToTest = [SELECT Name, ExtId__c, Image__c, Types__c, 
                                          Generation__c, heigth__c, weigth__c FROM Pokemon__c 
                                          WHERE ExtId__c = 2 LIMIT 1];
        
        List<Pokemon__c> pokemonSearch = PokemonController.searchPokemons('Bulbasaur', 'Grass', '2');
        System.assertEquals(pokemonSearch.get(0), pokemonToTest.get(0));
       
    
    }
}
