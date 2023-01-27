public with sharing class Moves {   
	//Definicion de atributos correspondientes a las propiedades del JSON
    public Integer id;
    public String name;
    public Integer accuracy;
    public String effect_chance;
    public Integer power;
    public Integer pp;
    public Integer priority;
    public cls_target target;
    public cls_type type;
    public cls_effect_entries[] effect_entries;
        
    //Objetos anidadados
    public class cls_effect_entries{public String effect;public String short_effect;}
    
    public class cls_type{public cls_type[] type;public String name;}
        
    public class cls_target{ public cls_target[] target;public String name;} 
    //Método que toma un parámetro de cadena que representa el JSON 
    //y utiliza el método "deserialize" de la clase "System.JSON" para convertirlo en un objeto "Moves". 
    public static Moves parse(String json){return (Moves) System.JSON.deserialize(json, Moves.class);}  
}