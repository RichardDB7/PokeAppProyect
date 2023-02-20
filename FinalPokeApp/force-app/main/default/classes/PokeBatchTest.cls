@isTest
public class PokemonsBatchTest {
    
    @IsTest
    static void testPokemonsSuccessBatch() {
        List<Integer> pokeList = new List<Integer>();
        for (Integer i = 1; i < 10; i++) {pokeList.add(i);}
        
        List<Movement__c> moves = new List<Movement__c> {
            new Movement__c(Name = 'Toxic'),
            new Movement__c(Name = 'Poison-powder'),
            new Movement__c(Name = 'Ingrain'),
            new Movement__c(Name = 'Sludge')
            };insert moves;
        
        String pokemonResponse = '{"id": 1,"weight":69, "height":8, "name": "Bulbasaur", "sprites": {"other": {"home": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"}}}, "types": [{"type": {"name": "grass"}}], "abilities": [{"ability": {"name": "overgrow"}}], "stats": [{"base_stat": 45}, {"base_stat": 49}, {"base_stat": 49}, {"base_stat": 65}, {"base_stat": 65}, {"base_stat": 45}], "moves": [{"move":{"name":"Toxic"}},{"move":{"name":"Poison-powder"}},{"move":{"name":"Ingrain"}},{"move":{"name":"Sludge"}}]}';
        HttpCalloutMock mock = new GeneralHttpMockCallout(pokemonResponse, 200);
        Test.setMock(HttpCalloutMock.class, mock);
        
        Test.startTest();
        PokeBatch batch = new PokeBatch(pokeList);
        Database.executeBatch(batch, 10);
        Test.stopTest();
        
        List<Pokemon__c> pokemon = [SELECT Name, ExtId__c, Image__c, Types__c, Weigth__c, Heigth__c
                          FROM Pokemon__c WHERE Name = 'Bulbasaur'];
        
        //System.assertEquals('Bulbasaur', pokemon[0].Name);
        //System.assertEquals(1, pokemon[0].ExtId__c);
        //System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png', pokemon[0].Image__c);
        //System.assertEquals('Grass', pokemon[0].Types__c);
        //System.assertEquals(6.90, pokemon[0].Weigth__c);
        //System.assertEquals(0.8, pokemon[0].Heigth__c);
    }
    
    
    
    @isTest
    static void testPokeErrorBatch() {
        
        List<Integer> PokeIdList = new List<Integer>();
        
        for (Integer i = 1; i < 10; i++) {PokeIdList.add(i);}
        
        
        String mockResponse = '{"message": "Not Found", "status": 404}';
        
        Test.setMock(HttpCalloutMock.class, new GeneralHttpMockCallout(mockResponse, 404));
        
      
        PokeBatch batch = new PokeBatch(PokeIdList);
        
        Test.startTest();
        Database.executeBatch(batch, 10);
        Test.stopTest();
        
        
        List<Pokemon__c> poke = [
            SELECT Name, ExtId__c, Image__c, Types__c, Weigth__c, Heigth__c
            FROM Pokemon__c ];
        
        System.assertEquals(true, poke.isempty(),'La lista no está vacia');
    }    
}
