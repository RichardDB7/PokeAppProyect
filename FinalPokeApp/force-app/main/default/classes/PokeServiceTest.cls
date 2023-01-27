@isTest
public class PokeServiceTest {
    @isTest
    static void testGetPokemons() {
        
        // Crea registros de Pokemon__c de prueba
        List<Pokemon__c> pokeList = new List<Pokemon__c>();
        for (Integer i = 1; i <= 50; i++) {
            pokeList.add(new Pokemon__c(Name='Test' + i, Types__c='Fire', weigth__c=i, heigth__c=i, Image__c='https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/' + i + '.png', ExtId__c=i));
        }
        insert pokeList;

        // Llamada al método de la clase PokeService
        List<Pokemon__c> result = PokeService.getPokemons();

        // Comprobar que el resultado contiene los registros de Pokemon__c creados
        System.assertEquals(result.size(), 50);
        for (Integer i = 1; i <= 50; i++) {
            System.assertEquals(result[i-1].Name, 'Test' + i);
        }
    }
}