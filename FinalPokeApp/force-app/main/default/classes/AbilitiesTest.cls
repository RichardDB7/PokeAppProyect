@isTest
public class AbilitiesTest {
	
      @isTest
    public static void AbilitiesTest() {
        
        String abtys = '{"id":1,"name":"Test","Effect":"Has no effect in battle."}';
        
        Abilities ab =  new Abilities();
        ab=Abilities.parse(abtys);
         
        System.assertEquals(ab.id,1);
		//System.assertEquals(ab.Name,8);
        //System.assertEquals(ab.Effect__c,8);
    }
}