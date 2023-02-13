@isTest
public class AbilityBatchTest {

    @isTest
    static void testAbilitySuccessBatch() {
        // Crea una lista de enteros con los IDs de los Abilitys
        List<Integer> AbilityIdList = new List<Integer>();
        for (Integer i = 1; i < 10; i++) {
            AbilityIdList.add(i);
        }

        // Crea una respuesta mock para la llamada HTTP a la API
		String mockResponse = '{"id": 1,"name": "pound", "accuracy": 100,"effect_chance": null,"effect_entries": [{"effect": "Inflicts regular damage.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Inflicts regular damage with no additional effect."}],"power": 40,"pp": 35,"priority": 0,"target": {"name": "selected-pokemon"},"type": {"name": "normal"}}';
        Test.setMock(HttpCalloutMock.class, new GeneralHttpMockCallout(mockResponse, 200));
        
        // Ejecuta el proceso en batch y detiene la prueba
        AbilityBatch batch = new AbilityBatch(AbilityIdList);
        Test.startTest();
        Database.executeBatch(batch, 10);
        Test.stopTest();

        // Comprobacion de inserción del objeto "Ability" con el nombre "Test"
        List<Ability__c> ab = [SELECT Name FROM Ability__c WHERE Name = 'Test Ability'];
        System.assertEquals(ab[0].Name, 'Test Ability');
    }

    @isTest
    static void testAbilityErrorBatch() {
        // Crea una lista de enteros con los IDs de los Abilitys
        List<Integer> AbilityIdList = new List<Integer>();
        for (Integer i = 1; i < 10; i++) {
            AbilityIdList.add(i);
        }

        // Crea una respuesta mock para la llamada HTTP a la API
		String mockResponse = '{"id": 1,"name": "pound", "accuracy": 100,"effect_chance": null,"effect_entries": [{"effect": "Inflicts regular damage.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Inflicts regular damage with no additional effect."}],"power": 40,"pp": 35,"priority": 0,"target": {"name": "selected-pokemon"},"type": {"name": "normal"}}';
        Test.setMock(HttpCalloutMock.class, new GeneralHttpMockCallout(mockResponse, 400));
        
        // Ejecuta el proceso en batch y detiene la prueba
       	AbilityBatch batch = new AbilityBatch(AbilityIdList);
        Test.startTest();
        try {
            Database.executeBatch(batch, 10);
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Error inserting ability'));
        }
        Test.stopTest();
    }
}
