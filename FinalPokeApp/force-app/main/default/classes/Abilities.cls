public with sharing class Abilities {
    
    public String Name;// Ab Name
    public Integer id;// Ab id
    
    public cls_effect_entries[] effect_entries;// Prototype Array of Effect
    //Effect Method
    public class cls_effect_entries { public String effect;public cls_language language;public String short_effect;}

    public class cls_language {public String name;public String url;}

	//Metodo parse y deserialize convierte el string json en objeto abilities		
    public static Abilities parse(String json){ 
		return (Abilities) System.JSON.deserialize(json, Abilities.class);
	}
}
