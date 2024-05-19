trigger GardeningManagerTask on CAMPX__Garden__c (after insert, after update) {
    
    List<Task> tasksToInsert = new List<Task>();

    public void createTask(List<CAMPX__Garden__c> gardens) {

        for (CAMPX__Garden__c garden : gardens) {
            if (garden.CAMPX__Manager__c != null) {
                
                Task todo = new Task();
                todo.Subject = 'Acquire Plants';
                todo.WhatId = garden.id;
                todo.OwnerId = garden.CAMPX__Manager__c;
                tasksToInsert.add(todo);
            }
        }        
    }

    // if the garden is created and the manager is assigned, a task is created
    if (Trigger.isInsert) {
        createTask(Trigger.new);
    }
    // if the garden manager is updated, a task is created
    if (trigger.isUpdate) {
        List<CAMPX__Garden__c> gardensToUpdate = new List<CAMPX__Garden__c>();
        for (CAMPX__Garden__c gardenToUpdate : Trigger.new) {
            CAMPX__Garden__c oldGarden = Trigger.oldMap.get(gardenToUpdate.Id);
            if (oldGarden.CAMPX__Manager__c == null && gardenToUpdate.CAMPX__Manager__c != null) {
                gardensToUpdate.add(gardenToUpdate);
                if (gardensToUpdate.size() >= 200) {
                    createTask(gardensToUpdate);
                    gardensToUpdate.clear();
                }
            }
        }
        if (gardensToUpdate.size() > 0) {
            createTask(gardensToUpdate);
        }
    }
    if (tasksToInsert.size() > 0) {
        insert tasksToInsert;
    }
}