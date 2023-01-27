@isTest
public class MovesTest {
	
      @isTest
    public static void MovesTest() {
        
        String mv = '{"height":8,"id":135,"name":"Test","order":218,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png"},"types":[{"type":{"name":"electric"}},{"type":{"name":"fire"}}],"weight":245}';
        
        Moves Move =  new Moves();
        Move = Moves.parse(mv);
        System.assertEquals(Move.id,135);
    }
}