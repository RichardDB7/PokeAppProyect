@isTest
public class PokeBatchTest {
    @isTest
    static void testPokeSuccesseBatch() {
        
        // Creo una lista de enteros con los IDs de los Pokemons
        List<Integer> pokeIdList = new List<Integer>();
        for(Integer i = 1; i < 10; i++){pokeIdList.add(i);}
        
        // Creo una respuesta mock para la llamada HTTP a la API
        String body = '{"id": 1, "name": "bulbasaur", "sprites": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"}, "types": [{"type": {"name": "grass"}}], "abilities": [{"ability": {"name": "overgrow"}}], "stats": [{"base_stat": 45}, {"base_stat": 49}, {"base_stat": 49}, {"base_stat": 65}, {"base_stat": 65}, {"base_stat": 45}], "moves": [{"move": {"name": "razor-leaf"}}, {"move": {"name": "solar-beam"}}]}';
        HttpCalloutMock mock = new GeneralHttpMockCallout(body, 200);
        
        // Asigno el mock para las llamadas HTTP en el test
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Ejecuta el proceso en batch y detiene la prueba
        PokeBatch batch = new PokeBatch(pokeIdList);
        Test.startTest();Database.executeBatch(batch, 10);Test.stopTest();
       
        // Comprobacion de inserción del objeto "Pokemon" con sus respectivos atributos
        List<Pokemon__c> poke = [SELECT Name, ExtId__c, Image__c, Types__c, heigth__c, weigth__c  FROM Pokemon__c WHERE Name = 'Bulbasur'];
        
		/*System.assertEquals(poke[0].Name, 'Bulbasur');
        System.assertEquals(poke[0].id, '1');
        System.assertEquals(poke[0].Image__c, '{"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"}');
        System.assertEquals(poke[0].Ability__c, '[{"ability": {"name": "overgrow"}}]');
        System.assertEquals(poke[0].stats_hp__c, '[{"base_stat": 45}, {"base_stat": 49}, {"base_stat": 49}, {"base_stat": 65}, {"base_stat": 65}, {"base_stat": 45}]');
        System.assertEquals(poke[0].Slot1__c,'[{"move":{"name": "razor-leaf"}}]');
        System.assertEquals(poke[0].Slot2__c,'[{"move":{"name": "solar-beam"}}]');*/
       
    }
    
    
    @isTest
    static void testPokeErrorBatch() {
        // Crea una lista de enteros con los IDs de los Pokemon
        List<Integer> PokeIdList = new List<Integer>();
        for (Integer i = 1; i < 10; i++){PokeIdList.add(i);}
        
        // Crea una respuesta mock para la llamada HTTP a la API
        String mockResponse = '{"id": 1, "name": "bulbasaur", "sprites": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"}, "types": [{"type": {"name": "grass"}}], "abilities": [{"ability": {"name": "overgrow"}}], "stats": [{"base_stat": 45}, {"base_stat": 49}, {"base_stat": 49}, {"base_stat": 65}, {"base_stat": 65}, {"base_stat": 45}], "moves": [{"move": {"name": "razor-leaf"}}, {"move": {"name": "solar-beam"}}]}';
        Test.setMock(HttpCalloutMock.class, new GeneralHttpMockCallout(mockResponse, 400));
        
        // Ejecuta el proceso batch y detiene la prueba
        PokeBatch batch = new PokeBatch(PokeIdList);
        Test.startTest();try{Database.executeBatch(batch, 10);}      
        catch (Exception e){System.assert(e.getMessage().contains('Error inserting Pokemon'));}
        Test.stopTest();
    }   
    
}
