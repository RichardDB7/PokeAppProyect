@isTest
public class AbilitiesTest {
	
      @isTest
    public static void AbilitiesTest() {
        
        String abtys = '{"Name":"Adaptability","id":91,"effect_entries":[{"effect":"This Pokémon moves are powered up a little by same-type attack bonuses.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"STAB moves have 1.2x power."}]}';
        
        Abilities ab =  new Abilities();
        ab=Abilities.parse(abtys);
         
        System.assertEquals(ab.id,1);
		//System.assertEquals(ab.Name,8);
        //System.assertEquals(ab.Effect__c,8);
    }
}
