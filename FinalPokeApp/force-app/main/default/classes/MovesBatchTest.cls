@isTest
public class MovesBatchTest {

    @isTest
    static void testMovesSuccessBatch() {
        // Crea una lista de enteros con los IDs de los Abilitys
        List<Integer> MovesIdList = new List<Integer>();
        for (Integer i = 1; i < 150; i++){MovesIdList.add(i);}

        // Crea una respuesta mock para la llamada HTTP a la API
		String mockResponse = '{"id": 1,"name": "pound", "accuracy": 100,"effect_chance": null,"effect_entries": [{"effect": "Inflicts regular damage.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Inflicts regular damage with no additional effect."}],"power": 40,"pp": 35,"priority": 0,"target": {"name": "selected-pokemon"},"type": {"name": "normal"}}';        
        Test.setMock(HttpCalloutMock.class, new GeneralHttpMockCallout(mockResponse, 200));
        
        // Ejecuta el proceso en batch y detiene la prueba
        MovesBatch batch = new MovesBatch(MovesIdList);
        Test.startTest();Database.executeBatch(batch, 150);Test.stopTest();

        // Comprobacion de inserción del objeto "Movement" con el nombre "Test"
        List<Movement__c> ab = [SELECT Name, accuracy__c, effect__c, effect_chance__c, ExtId__c, name__c, power__c, pp__c, priority__c, target_name__c, type_name__c FROM Movement__c WHERE Name = 'Test Movement'];
        System.assertEquals(ab[0].Name, 'Test Movement');
    }

    @isTest
    static void testAbilityErrorBatch() {
        
        // Crea una lista de enteros con los IDs de los Movement
        List<Integer> MovesIdList = new List<Integer>();
        for (Integer i = 1; i < 150; i++){MovesIdList.add(i);}

        // Crea una respuesta mock para la llamada HTTP a la API
		String mockResponse = '{"id": 1,"name": "pound", "accuracy": 100,"effect_chance": null,"effect_entries": [{"effect": "Inflicts regular damage.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Inflicts regular damage with no additional effect."}],"power": 40,"pp": 35,"priority": 0,"target": {"name": "selected-pokemon"},"type": {"name": "normal"}';
        Test.setMock(HttpCalloutMock.class, new GeneralHttpMockCallout(mockResponse, 400));
        
        // Ejecuta el proceso en batch y detiene la prueba
        MovesBatch batch = new MovesBatch(MovesIdList);
        Test.startTest();try {Database.executeBatch(batch, 150);} 
        catch (Exception e){System.assert(e.getMessage().contains('Error inserting Movement'));}Test.stopTest();
    }
}
