public class AbilityBatch implements Database.Batchable<Integer>,Database.AllowsCallouts, Database.Stateful {

    List<Integer> abilityList;

    public AbilityBatch(List<Integer> abilityList) {
        this.abilityList = abilityList;
    }

    public Iterable<Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return this.abilityList;
    }
    
    public void execute(Database.BatchableContext bc, List<Integer> records) {
        // process each batch of records
        Integer abilityId = Integer.valueOf(records[0]);
        Ability__c abilityToInsert = AbilityHttpCallout.getAbility(abilityId);
		
        if(abilityToInsert != null){insert abilityToInsert;}
        else{System.debug('Error inserting ability');}
       
    }
    public void finish(Database.BatchableContext bc) {
    list<integer> Moves = new list<integer>();
	for (integer i = 1 ; i <= 826 ; i++){Moves.add(i);}
	MovesBatch batch = new MovesBatch(Moves);database.executeBatch(batch, 1);

    }
}