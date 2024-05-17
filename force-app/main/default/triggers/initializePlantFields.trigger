trigger initializePlantFields on CAMPX__Plant__c (before insert) {
    String sunExposure = 'Partial Sun';
    List<CAMPX__Garden__c> gardenList = [SELECT id, CAMPX__Sun_Exposure__c FROM CAMPX__Garden__c];
    for (CAMPX__Plant__c newPlant : trigger.new) {
        if (newPlant.CAMPX__Soil_Type__c == null) {
            newPlant.CAMPX__Soil_Type__c = 'All Purpose Potting Soil';
        }
        if (newPlant.CAMPX__Water__c == null) {
            newPlant.CAMPX__Water__c = 'Once Weekly';
        }
        // If the plant does not have a sun exposure, set the plant's sun exposure to the garden unit's sun exposure
        if (newPlant.CAMPX__Sunlight__c == null) {
            for (CAMPX__Garden__c gardenUnit : gardenList) {
                // If the garden unit has a sun exposure, set the plant's sun exposure to the garden unit's sun exposure
                if (gardenUnit.id == newPlant.CAMPX__Garden__c) {
                    if (gardenUnit.CAMPX__Sun_Exposure__c != null){
                        sunExposure = gardenUnit.CAMPX__Sun_Exposure__c;
                        newplant.CAMPX__Sunlight__c = sunExposure;
                    }
                }

                if (gardenUnit.CAMPX__Sun_Exposure__c == null) {
                    newplant.CAMPX__Sunlight__c = sunExposure;
                }
            }
        }
    }
}