@isTest
private class TestInitializePlantFields {

    @isTest
    static void createGardenWithoutDefault() {
        List<CAMPX__Plant__c> plantes = new List<CAMPX__Plant__c>();
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();
        CAMPX__Garden__c garden04 = new CAMPX__Garden__c();
        garden04.Name = 'Jardin basique';
        jardins.add(garden04);

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

        CAMPX__Plant__c plant01 = new CAMPX__Plant__c();
        plant01.Name = 'Tomato';
        plantes.add(plant01);
        insert plantes;

        plantes = [ SELECT  CAMPX__Soil_Type__c,
                            CAMPX__Water__c,
                            CAMPX__Sunlight__c
                    FROM    CAMPX__Plant__c];

        Assert.areEqual('All Purpose Potting Soil', plantes.get(0).CAMPX__Soil_Type__c);
        Assert.areEqual('Once Weekly', plantes.get(0).CAMPX__Water__c);
        Assert.areEqual('Partial Sun', plantes.get(0).CAMPX__Sunlight__c);
    }

    @isTest
    static void createGardenWithDefault() {
        List<CAMPX__Plant__c> plantes = new List<CAMPX__Plant__c>();
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();
        CAMPX__Garden__c garden05 = new CAMPX__Garden__c();
        garden05.Name = 'Jardin basique';
        garden05.CAMPX__Sun_Exposure__c = 'Full Shade';

        jardins.add(garden05);

        insert jardins;
        jardins = [ SELECT  CAMPX__Status__c,
                            CAMPX__Max_Plant_Count__c,
                            CAMPX__Minimum_Plant_Count__c,
                            CAMPX__Total_Plant_Count__c,
                            CAMPX__Total_Unhealthy_Plant_Count__c,
                            CAMPX__Sun_Exposure__c
                    FROM    CAMPX__Garden__c];

        Assert.areEqual('Awaiting Resources', jardins.get(0).CAMPX__Status__c);
        Assert.areEqual(100, jardins.get(0).CAMPX__Max_Plant_Count__c);
        Assert.areEqual(1, jardins.get(0).CAMPX__Minimum_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Unhealthy_Plant_Count__c);
        Assert.areEqual('Full Shade', jardins.get(0).CAMPX__Sun_Exposure__c);

        CAMPX__Plant__c plant01 = new CAMPX__Plant__c();
        plant01.Name = 'Tomato';
        plant01.CAMPX__Soil_Type__c = 'Sand';
        plant01.CAMPX__Water__c = 'Daily';
        plant01.CAMPX__Garden__c = jardins.get(0).Id;
        plantes.add(plant01);
        insert plantes;

        plantes = [ SELECT  CAMPX__Soil_Type__c,
                            CAMPX__Water__c,
                            CAMPX__Sunlight__c
                    FROM    CAMPX__Plant__c];

        Assert.areEqual('Sand', plantes.get(0).CAMPX__Soil_Type__c);
        Assert.areEqual('Daily', plantes.get(0).CAMPX__Water__c);
        Assert.areEqual('Full Shade', plantes.get(0).CAMPX__Sunlight__c);
        Assert.areEqual(jardins.get(0).Id, plant01.CAMPX__Garden__c);
    }

    @isTest
    static void createGardenWithoutSunExposure() {
        List<CAMPX__Plant__c> plantes = new List<CAMPX__Plant__c>();
        List<CAMPX__Garden__c> jardins = new List<CAMPX__Garden__c>();
        CAMPX__Garden__c garden05 = new CAMPX__Garden__c();
        garden05.Name = 'Jardin basique';

        jardins.add(garden05);

        insert jardins;
        jardins = [ SELECT  CAMPX__Status__c,
                            CAMPX__Max_Plant_Count__c,
                            CAMPX__Minimum_Plant_Count__c,
                            CAMPX__Total_Plant_Count__c,
                            CAMPX__Total_Unhealthy_Plant_Count__c,
                            CAMPX__Sun_Exposure__c
                    FROM    CAMPX__Garden__c];

        Assert.areEqual('Awaiting Resources', jardins.get(0).CAMPX__Status__c);
        Assert.areEqual(100, jardins.get(0).CAMPX__Max_Plant_Count__c);
        Assert.areEqual(1, jardins.get(0).CAMPX__Minimum_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Plant_Count__c);
        Assert.areEqual(0, jardins.get(0).CAMPX__Total_Unhealthy_Plant_Count__c);

        CAMPX__Plant__c plant01 = new CAMPX__Plant__c();
        plant01.Name = 'Tomato';
        plant01.CAMPX__Soil_Type__c = 'Sand';
        plant01.CAMPX__Water__c = 'Daily';
        plant01.CAMPX__Garden__c = jardins.get(0).Id;
        plantes.add(plant01);
        insert plantes;

        plantes = [ SELECT  CAMPX__Soil_Type__c,
                            CAMPX__Water__c,
                            CAMPX__Sunlight__c
                    FROM    CAMPX__Plant__c];

        Assert.areEqual('Sand', plantes.get(0).CAMPX__Soil_Type__c);
        Assert.areEqual('Daily', plantes.get(0).CAMPX__Water__c);
        Assert.areEqual('Partial Sun', plantes.get(0).CAMPX__Sunlight__c);
        Assert.areEqual(jardins.get(0).Id, plant01.CAMPX__Garden__c);
    }

    
}