trigger InitializeGardenFieldsUponCreation on CAMPX__Garden__c (before insert) {
    for (CAMPX__Garden__c newGarden : trigger.new) {

        if (newGarden.CAMPX__Status__c == null) {
            newGarden.CAMPX__Status__c = 'Awaiting Resources';
        }
        if (newGarden.CAMPX__Max_Plant_Count__c == null) {
            newGarden.CAMPX__Max_Plant_Count__c = 100;
        }
        if (newGarden.CAMPX__Minimum_Plant_Count__c == null) {
            newGarden.CAMPX__Minimum_Plant_Count__c = 1;            
        }
        if (newGarden.CAMPX__Total_Plant_Count__c == null) {
            newGarden.CAMPX__Total_Plant_Count__c = 0;            
        }
        if (newGarden.CAMPX__Total_Unhealthy_Plant_Count__c == null) {
            newGarden.CAMPX__Total_Unhealthy_Plant_Count__c = 0;            
        }
    }
}