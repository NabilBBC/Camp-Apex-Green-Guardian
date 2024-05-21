trigger SetManagerStartDate on CAMPX__Garden__c (before insert, before update) {

    List<CAMPX__Garden__c> gardensToUpdate = new List<CAMPX__Garden__c>();

    if (trigger.isInsert) {
        for (CAMPX__Garden__c garden : trigger.new) {
            if (garden.CAMPX__Manager__c != null) {
                garden.CAMPX__Manager_Start_Date__c = date.today();                    
            }
        }
    }

    if (trigger.isUpdate) {
        for (CAMPX__Garden__c garden : trigger.new) {
            CAMPX__Garden__c oldGarden = trigger.oldMap.get(garden.id);
            System.debug('old Garden : '+ oldGarden);

            if (oldGarden.id != garden.CAMPX__Manager__c) {
                //vérifie si le manager est null et qu'il existait une start Date
                if (garden.CAMPX__Manager__c == null && garden.CAMPX__Manager_Start_Date__c != null) {
                    garden.CAMPX__Manager_Start_Date__c = null;
                }
                //Si le manager n'est pas null
                if (garden.CAMPX__Manager__c != null) {
                    garden.CAMPX__Manager_Start_Date__c = date.today();
                }         
            }
        }
    }

}