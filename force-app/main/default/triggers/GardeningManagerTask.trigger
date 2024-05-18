trigger GardeningManagerTask on CAMPX__Garden__c (after insert) {

    List<Task> tasksToInsert = new List<Task>();

    for (CAMPX__Garden__c garden : Trigger.new) {
        if (garden.CAMPX__Manager__c != null) {
            
            Task todo = new Task();
            todo.Subject = 'Acquire Plants';
            todo.WhatId = garden.id;
            todo.OwnerId = garden.CAMPX__Manager__c;
            tasksToInsert.add(todo);
        }
    }
        if (tasksToInsert.size() > 0) {
            insert tasksToInsert;
    }
}