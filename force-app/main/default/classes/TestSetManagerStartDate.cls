@isTest
private class TestSetManagerStartDate {

    
    @isTest
    static void createNewGardenWithManager() {
        // Create a new garden
        List<User> managers = [SELECT Id FROM User WHERE Name = 'Willie Groundkeeper'];
        CAMPX__Garden__c garden = new CAMPX__Garden__c();
        garden.Name = 'Test Garden';
        garden.CAMPX__Manager__c = managers.get(0).Id;
        insert garden;

        // Check that the garden was created
        Date today = Date.today();
        CAMPX__Garden__c newGarden = [SELECT Id, Name, CAMPX__Manager__c, CAMPX__Manager_Start_Date__c FROM CAMPX__Garden__c WHERE Id = :garden.Id];

        Assert.areEqual('Test Garden', newGarden.Name);
        Assert.areEqual(managers.get(0).Id, newGarden.CAMPX__Manager__c);
        Assert.areEqual(today, newGarden.CAMPX__Manager_Start_Date__c);
        System.debug('start date: ' + newGarden.CAMPX__Manager_Start_Date__c);
    }

    @isTest
    static void updateGardenWithoutManager() {
        List<User> managers = [SELECT Id FROM User WHERE Name = 'Willie Groundkeeper'];
        CAMPX__Garden__c garden = new CAMPX__Garden__c();
        garden.Name = 'Test Garden';
        garden.CAMPX__Manager__c = managers.get(0).Id;
        insert garden;

        garden.CAMPX__Manager__c = null;
        update garden;


        // Check that the garden was created
        Date today = Date.today();
        CAMPX__Garden__c newGarden = [SELECT Id, Name, CAMPX__Manager__c, CAMPX__Manager_Start_Date__c FROM CAMPX__Garden__c WHERE Id = :garden.Id];

        Assert.areEqual('Test Garden', newGarden.Name);
        Assert.areEqual(null, newGarden.CAMPX__Manager__c);
        Assert.areEqual(null, newGarden.CAMPX__Manager_Start_Date__c);
        System.debug('start date: ' + newGarden.CAMPX__Manager_Start_Date__c);

    }
}