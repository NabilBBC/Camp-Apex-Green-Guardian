
@isTest
private class TestInitializeGardenFieldsUponCreation {

    @isTest
    static void createNewGarden() {
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();
        CAMPX__Garden__c garden01 = new CAMPX__Garden__c();
        garden01.Name = 'Nouveau Jardin';
        jardins.add(garden01);

        insert jardins;
        jardins = [ SELECT  CAMPX__Status__c,
                            CAMPX__Max_Plant_Count__c,
                            CAMPX__Minimum_Plant_Count__c,
                            CAMPX__Total_Plant_Count__c,
                            CAMPX__Total_Unhealthy_Plant_Count__c
                    FROM    CAMPX__Garden__c];

        Assert.areEqual('Awaiting Resources', jardins.get(0).CAMPX__Status__c);
        Assert.areEqual(100, jardins.get(0).CAMPX__Max_Plant_Count__c);
        Assert.areEqual(1, jardins.get(0).CAMPX__Minimum_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Unhealthy_Plant_Count__c);
    }

    @isTest
    static void updateMaxPlantCount() {
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();
        CAMPX__Garden__c garden02 = new CAMPX__Garden__c();
        garden02.Name = 'Jardin 15 plantes';
        jardins.add(garden02);

        insert jardins;
        garden02.CAMPX__Max_Plant_Count__c = 15;
        update jardins;
        jardins = [ SELECT  CAMPX__Status__c,
                            CAMPX__Max_Plant_Count__c,
                            CAMPX__Minimum_Plant_Count__c,
                            CAMPX__Total_Plant_Count__c,
                            CAMPX__Total_Unhealthy_Plant_Count__c
                    FROM    CAMPX__Garden__c];

        Assert.areEqual('Awaiting Resources', jardins.get(0).CAMPX__Status__c);
        Assert.areEqual(15, jardins.get(0).CAMPX__Max_Plant_Count__c);
        Assert.areEqual(1, jardins.get(0).CAMPX__Minimum_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Unhealthy_Plant_Count__c);
    }

    @isTest
    static void initializeGardenExceptDefaultValues() {
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();
        CAMPX__Garden__c garden03 = new CAMPX__Garden__c();
        garden03.Name = 'Jardin max 50 plantes';
        garden03.CAMPX__Max_Plant_Count__c = 50;
        jardins.add(garden03);

        insert jardins;
        jardins = [ SELECT  CAMPX__Status__c,
                            CAMPX__Max_Plant_Count__c,
                            CAMPX__Minimum_Plant_Count__c,
                            CAMPX__Total_Plant_Count__c,
                            CAMPX__Total_Unhealthy_Plant_Count__c
                    FROM    CAMPX__Garden__c];

        Assert.areEqual('Awaiting Resources', jardins.get(0).CAMPX__Status__c);
        Assert.areEqual(50, jardins.get(0).CAMPX__Max_Plant_Count__c);
        Assert.areEqual(1, jardins.get(0).CAMPX__Minimum_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Unhealthy_Plant_Count__c);
    }
}