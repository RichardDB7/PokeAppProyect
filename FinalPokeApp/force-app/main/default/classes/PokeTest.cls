@isTest
public with sharing class PokeTest {
    @isTest
    public static void PokeTest() {
        
        String poks = '{"height":8,"id":135,"name":"jolteon","order":218,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png"},"types":[{"type":{"name":"electric"}},{"type":{"name":"fire"}}],"weight":245}';
        
        Pokemons Pokes = new Pokemons();
        Pokes=Pokemons.parse(poks);
        
        System.assertEquals(x.height,8);  
    }
}
