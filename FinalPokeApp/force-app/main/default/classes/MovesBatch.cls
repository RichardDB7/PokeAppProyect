public class MovesBatch implements Database.Batchable<Integer>, 
Database.AllowsCallouts, Database.Stateful {
    
    List<Integer> MoveList;//Lista de enteros inicializada pasada al constructor 
    public MovesBatch(List<Integer> MoveList) {this.MoveList = MoveList;}
	//Devolucion y proceso por lotes
    public Iterable<Integer> start(Database.BatchableContext bc){return this.MoveList;}
	//Ejecucion de registros
    public void execute(Database.BatchableContext bc, List<Integer> records) {  
        Integer movementId = Integer.valueOf(records[0]);
        Movement__c movementToInsert = MovementsHttpCallout.getMove(movementId);
        
            if(movementToInsert != null) {insert movementToInsert;}
   			else {System.debug('Error inserting Movement!');}
    }
	//Finalizo el batch y ejecuto el siguiente
    public void finish(Database.BatchableContext bc) {
        list<integer> Pokes = new list<integer>();
        for (integer i = 1 ; i <= 898 ; i++)Pokes.add(i);
		PokeBatch batch = new PokeBatch(Pokes);database.executeBatch(batch, 1);
    }
}