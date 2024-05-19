trigger ReassignTasks on CAMPX__Garden__c (after update) {

    for (CAMPX__Garden__c gardenToUpdate : trigger.new) {
        CAMPX__Garden__c oldGarden = trigger.oldMap.get(gardenToUpdate.Id);
        if (gardenToUpdate.CAMPX__Manager__c != oldGarden.CAMPX__Manager__c) {

            List<Task> tasksToUpdate = [SELECT Id, OwnerId, Status
                                        FROM Task
                                        WHERE WhatId = :gardenToUpdate.Id
                                        AND Status != 'Completed'
                                        AND Subject = 'Acquire Plants'];

            for (Task task : tasksToUpdate) {
                if (gardenToUpdate.CAMPX__Manager__c != null) {
                    task.OwnerId = gardenToUpdate.CAMPX__Manager__c;
                }
            }
            update tasksToUpdate;
        }

        if (oldGarden.CAMPX__Manager__c != null && gardenToUpdate.CAMPX__Manager__c == null) {
            List<Task> tasksToDelete = [SELECT Id
                                        FROM Task
                                        WHERE WhatId = :gardenToUpdate.Id
                                        AND Status != 'Completed'
                                        AND Subject = 'Acquire Plants'];
           Delete tasksToDelete;
        } 
    }
}