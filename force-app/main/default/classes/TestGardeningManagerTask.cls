@isTest
private class TestGardeningManagerTask {

    @isTest
    static void createGardenWithManager() {
        User manager = [SELECT id FROM User where FirstName = 'Nabil'];
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();

        CAMPX__Garden__c edenGarden = new CAMPX__Garden__c();
        edenGarden.Name = 'Jardin d\'Eden';
        edenGarden.CAMPX__Manager__c = manager.id;
        jardins.add(edenGarden);

        insert jardins;
        jardins = [ SELECT  id,
                            CAMPX__Manager__c
                    FROM    CAMPX__Garden__c WHERE id = :edenGarden.id];

        System.debug('edenGarden.CAMPX__Manager__c: ' + edenGarden.CAMPX__Manager__c);


        List<Task> existingTasks = [    SELECT id, Subject
                                        FROM Task
                                        WHERE whatid = :edenGarden.id];
        System.debug('existingTasks: ' + existingTasks);

        Assert.areEqual(manager.Id, jardins.get(0).CAMPX__Manager__c);
        Assert.areEqual('Acquire Plants', existingTasks.get(0).Subject);
    }

    @isTest
    static void createGardenWithoutManager() {
        User manager = [SELECT id FROM User where FirstName = 'Nabil'];
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();
        List<Task> toDos = new List<Task>();
        CAMPX__Garden__c edenGarden = new CAMPX__Garden__c();
        edenGarden.Name = 'Jardin d\'Eden 2';
        jardins.add(edenGarden);

        insert jardins;
        jardins = [ SELECT  id,
                            CAMPX__Manager__c
                    FROM    CAMPX__Garden__c WHERE id = :edenGarden.id];

        List<Task> existingTasks = [    SELECT id
                                        FROM Task
                                        WHERE whatid = :edenGarden.id];

        Assert.areNotEqual(manager.Id, jardins.get(0).CAMPX__Manager__c);
        Assert.areEqual(0, existingTasks.size());
    }

    @isTest
    static void createGardenWithoutManagerThenUpdateManager() {
        User manager = [SELECT id FROM User where FirstName = 'Nabil'];
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();
        List<Task> toDos = new List<Task>();

        CAMPX__Garden__c edenGarden = new CAMPX__Garden__c();
        edenGarden.Name = 'Jardin d\'Eden 3';
        jardins.add(edenGarden);

        insert jardins;
        jardins = [ SELECT  id,
                            CAMPX__Manager__c
                    FROM    CAMPX__Garden__c WHERE id = :edenGarden.id];
        List<Task> existingTasks = [    SELECT id
                                        FROM Task
                                        WHERE whatid = :edenGarden.id];

        Assert.areNotEqual(manager.Id, jardins.get(0).CAMPX__Manager__c);
        Assert.areEqual(0, existingTasks.size());
        
        edenGarden.CAMPX__Manager__c = manager.id;
        update edenGarden;
        jardins = [ SELECT  id, CAMPX__Manager__c
                    FROM CAMPX__Garden__c
                    WHERE id = :edenGarden.id];

        existingTasks = [   SELECT id
                            FROM Task
                            WHERE whatid = :edenGarden.id];

        Assert.areEqual(manager.Id, jardins.get(0).CAMPX__Manager__c);
        Assert.areEqual(1, existingTasks.size());
    }
}