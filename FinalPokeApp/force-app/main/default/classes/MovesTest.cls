@isTest
public class MovesTest {
	
      @isTest
    public static void MovesTest() {
        
        String mov = '{"Name":"Adaptability","id":91,"effect_entries":[{"effect":"This Pokémon moves are powered up a little by same-type attack bonuses.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"STAB moves have 1.2x power."}]}';
        
        Moves Move =  new Moves();
        Move = Moves.parse(mov);
        System.assertEquals(Move.id,135);
    }
}
