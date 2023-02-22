				    //Proceso de lotes Asincrono //llamada a servicio ext //Mantenimiento de estado de ejecuciones	
public class AbilityBatch implements Database.Batchable<Integer>,Database.AllowsCallouts, Database.Stateful {

    List<Integer> abilityList;

    public AbilityBatch(List<Integer> abilityList){this.abilityList = abilityList;}
	
    //Llamada al proceso de lotes y devuelvo la lista de enteros	
    public Iterable<Integer> start(Database.BatchableContext bc){return this.abilityList;}
	
    //Proceso cada entero de la lista y llamada al metodo getAbility e inserto el registro
    public void execute(Database.BatchableContext bc, List<Integer> records) {
        
        Integer abilityId = Integer.valueOf(records[0]);
        Ability__c abilityToInsert = AbilityHttpCallout.getAbility(abilityId);
		
        if(abilityToInsert != null){insert abilityToInsert;}
        else{System.debug('Error inserting ability');}}
	
     //Finalizacion y ejejución en cadena del proximo batch
    public void finish(Database.BatchableContext bc) {
    list<integer> Moves = new list<integer>();
	for (integer i = 1 ; i <= 826 ; i++){Moves.add(i);}
	MovesBatch batch = new MovesBatch(Moves);database.executeBatch(batch, 1);

    }
}
