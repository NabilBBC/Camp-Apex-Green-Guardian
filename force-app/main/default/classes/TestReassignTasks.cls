@isTest
private class TestReassignTasks {

    @isTest
    static void createAndUpdateGardenManager() {

        List<User> Managers = new List<User>();
        User leavingManager = [SELECT id FROM User where Name = 'Willie Groundkeeper'];
        User arrivingManager = [SELECT id FROM User where Name = 'Nabil Belbachir'];
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();

        CAMPX__Garden__c EvergreenGardens = new CAMPX__Garden__c();
        EvergreenGardens.Name = 'Evergreen Gardens';
        EvergreenGardens.CAMPX__Manager__c = leavingManager.id;
        jardins.add(EvergreenGardens);

        insert jardins;

        EvergreenGardens.CAMPX__Manager__c = arrivingManager.id;
        update EvergreenGardens;
        
        jardins = [ SELECT  id,
                            CAMPX__Manager__c
                    FROM    CAMPX__Garden__c WHERE id = :EvergreenGardens.id];

        System.debug('EvergreenGardens.CAMPX__Manager__c: ' + EvergreenGardens.CAMPX__Manager__c);


        List<Task> existingTasks = [    SELECT id, Subject, OwnerId
                                        FROM Task
                                        WHERE whatid = :EvergreenGardens.id];
        System.debug('existingTasks: ' + existingTasks);

        for (Task existingTask : existingTasks) {
            Assert.areEqual(existingTask.OwnerId, arrivingManager.Id);
        }
    }

    @isTest
    static void RemoveGardenManager() {

        User leavingManager = [SELECT id FROM User where Name = 'Willie Groundkeeper'];
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();

        CAMPX__Garden__c EvergreenGardens = new CAMPX__Garden__c();
        EvergreenGardens.Name = 'Evergreen Gardens';
        EvergreenGardens.CAMPX__Manager__c = leavingManager.id;
        jardins.add(EvergreenGardens);

        insert jardins;

        EvergreenGardens.CAMPX__Manager__c = null;
        update EvergreenGardens;
        
        jardins = [ SELECT  id,
                            CAMPX__Manager__c
                    FROM    CAMPX__Garden__c WHERE id = :EvergreenGardens.id];

        System.debug('EvergreenGardens.CAMPX__Manager__c: ' + EvergreenGardens.CAMPX__Manager__c);


        List<Task> existingTasks = [    SELECT id, Subject, OwnerId
                                        FROM Task
                                        WHERE whatid = :EvergreenGardens.id];
        System.debug('existingTasks related to the EvergreenGardens : ' + existingTasks);

        Assert.isTrue(existingTasks.isEmpty());
    }
}