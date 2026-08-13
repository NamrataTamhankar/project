import arcpy
import sys, os, time
from datetime import datetime

# Current date time
now = datetime.now()

#Start script time
start_time_str = now.strftime("%d-%m-%Y_%H:%M:%S")
print("--*START*--")
print("{0}  Starting script...".format(start_time_str))

# Set local variables
# FGDB variabelen
out_folder_path = "C:/Projecten/IPO_FGDB/Data"
fgdb_out_name = "NBP_template.gdb"
out_version = "10.0"
arcpy.env.overwriteOutput = True

# pad naar dataset provinciegrenzen
prov_path = "C:/Projecten/IPO_FGDB/Data/IMNAGeodatabase_jan2019.gdb/IMNa/provinciegrenzen"

# feature class variabelen en environment settings
DS_name = "IMNa"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
arcpy.env.XYResolution = "0.0005 Meters"
arcpy.env.XYTolerance = "0.001 Meters"
SR_name = arcpy.SpatialReference(28992)
FC_list = ["BeheerGebied", "BeheerGebiedAmbitie", "BijzonderGebied", "DeelGebied", "ZoekGebiedAgrarisch", "ZoekGebiedLandschap", "ZoekGebiedWater", "Provinciegrenzen"]
TB_list = ["NatuurbeheerPlan", "TemplateVersie"]

# Start werkproces

# FGDB aanmaken
# Check of FGDB al bestaat
print ("Checking for previous versions of the file geodatabase in folder {0}...".format(out_folder_path))
input_gdb = "{0}/{1}".format(out_folder_path,fgdb_out_name)
if arcpy.Exists(input_gdb) == True:
    print ("File geodatabase already exists in the indicated folder!")
    print ("New FGDB with timestamp will be created.")
    date_time = now.strftime("%Y%m%d%H%M%S")
    fgdb_out_name = fgdb_out_name[:-4] + "_" + date_time + ".gdb"
    # FGDB aanmaken met timestamp
    print ("Creating file geodatabase with name {0}...".format(fgdb_out_name))
    arcpy.CreateFileGDB_management(out_folder_path, fgdb_out_name, out_version)
    print("File geodatabase with name {0} has been created.".format(fgdb_out_name))
    input_gdb = "{0}/{1}".format(out_folder_path,fgdb_out_name)
    DS_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,DS_name)
else:
    # Aanmaken FGDB zonder timestamp
    print ("No previous versions found. Creating file geodatabase with name {0}...".format(fgdb_out_name))
    arcpy.CreateFileGDB_management(out_folder_path, fgdb_out_name, out_version)
    print("File geodatabase with name {0} has been created.".format(fgdb_out_name))
    input_gdb = "{0}/{1}".format(out_folder_path,fgdb_out_name)
    DS_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,DS_name)

# Feature Dataset aanmaken
out_sr = arcpy.CreateSpatialReference_management(SR_name)
print ("Creating dataset with name {0}...".format(DS_name))
arcpy.CreateFeatureDataset_management(input_gdb, DS_name, out_sr)
print ("Dataset with name {0} has been created.".format(DS_name))

# Feature classes aanmaken (behalve provinciegrenzen)
for fcl in FC_list[:-1]:
    print ("Creating featureclass {0}...".format(fcl))
    arcpy.CreateFeatureclass_management(DS_path, fcl, geometry_type="POLYGON")
    print ("Featureclass {0} has been created.".format(fcl))

# tabellen aanmaken
for tbl in TB_list:
    print ("Creating table {0}...".format(tbl))
    arcpy.CreateTable_management(input_gdb, tbl)
    print ("Table {0} has been created.".format(tbl))

# Toevoegen van de attribuutvelden aan de feature classes
# [0] BeheerGebied
print ("Adding attributes to feature class {0}...".format(FC_list[0]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[0]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "beheerType", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "subsidiabel", "LONG", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "indicatieveVerhoudingBeheertypen", "TEXT", field_length=255, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerpakketten", "TEXT", field_length=255, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "nietSubsidiabeleBeheerpakketten", "TEXT", field_length=255, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "openstellingsBijdrageType", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[0]))

# [1] BeheerGebiedAmbitie
print ("Adding attributes to feature class {0}...".format(FC_list[1]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[1]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "statusEHS", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "beheerType", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "subsidiabel", "LONG", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "indicatieveVerhoudingBeheertypen", "TEXT", field_length=255, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerpakketten", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[1]))

# [2] BijzonderGebied
print ("Adding attributes to feature class {0}...".format(FC_list[2]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[2]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "gebiedsCode", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "gebiedsNaam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[2]))

# [3] DeelGebied
print ("Adding attributes to feature class {0}...".format(FC_list[3]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[3]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "gebiedsNaam", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beschrijving", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[3]))

# [4] ZoekGebiedAgrarisch
print ("Adding attributes to feature class {0}...".format(FC_list[4]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[4]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "agrarischNatuurType", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "naam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "deelgebiedNaam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerFuncties", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerTypen", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[4]))

# [5] ZoekGebiedLandschap
print ("Adding attributes to feature class {0}...".format(FC_list[5]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[5]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "naam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerTypen", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "nietSubsidiabeleBeheerpakketten", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[5]))

# [6] ZoekGebiedWater
print ("Adding attributes to feature class {0}...".format(FC_list[6]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[6]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "naam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "waterNatuurType", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "deelgebiedNaam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerFuncties", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerTypen", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[6]))

# Toevoegen van de attribuutvelden aan de tabellen
# [0] NatuurbeheerPlan
print ("Adding attributes to table {0}...".format(TB_list[0]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[0]))
arcpy.AddField_management(TBL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "datumVaststelling", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "provincie", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "planEigenaar", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "planNaam", "TEXT", field_length=256, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "planVerwijzing", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "status", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "subsidieJaar", "SHORT", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "beheerGebiedStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "beheerGebiedAmbitieStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "bijzonderGebiedStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "deelGebiedStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "zoekGebiedAgrarischStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "zoekGebiedLandschapStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "zoekGebiedWaterStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
print ("Added attributes to table {0}.".format(TB_list[0]))

# [1] TemplateVersie
print ("Adding attributes to table {0}...".format(TB_list[1]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[1]))
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=8, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "datumCreatie", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "releaseNotes", "TEXT", field_length=20000, field_is_nullable="NON_NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "datumCreatie", "releaseNotes"]) as cursor:
    cursor.insertRow(["2020.2.0", "05/03/2019", "Template voor het indienen van Natuurbeheerplannen voor 2021 in de ontwerpfase."])
print ("Added attributes to table {0}.".format(TB_list[1]))

# kopiëren van de provinciegrenzen uit de oude template
# [7] Provinciegrenzen
print("Copy feature class {0} from old template...".format(FC_list[7]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[7]))
arcpy.CopyFeatures_management(prov_path, FCL_path)
print("Feature class {0} copied from old template.".format(FC_list[7]))

# Domeinen instellen
# maak dictionaries met waarden en omschrijvingen
BeheerTypeDomein = {"A01.01":"Weidevogelgebied",
          "A01.02":"Akkerfaunagebied",
          "A01.03":"Ganzenfoerageergebied",
          "A01.04":"Insectenrijke graslanden",
          "A01.05":"Foerageerrand bever",
          "A02.01":"Botanisch waardevol grasland",
          "A02.02":"Botanisch waardevol akkerland",
          "A11.01":"Weidevogelgrasland in open landschap",
          "A11.02":"Weidevogelland met riet of opgaande begroeiing",
          "A11.03":"Open grasland voor overwinterende vogels",
          "A12.01":"Open akkerland voor broedende akkervogels",
          "A12.02":"Open akkerland voor overwinterende akkervogels",
          "A12.03":"Akkerland met hamsters",
          "A13.01":"Bomenrij en singel",
          "A13.02":"Struweel en ruigte",
          "A14.01":"Watergang",
          "A14.02":"Poel",
          "L01.01":"Poel en klein historisch water",
          "L01.02":"Houtwal en houtsingel",
          "L01.03":"Elzensingel",
          "L01.05":"Knip-of scheerheg",
          "L01.06":"Struweelhaag",
          "L01.07":"Laan",
          "L01.08":"Knotboom",
          "L01.09":"Hoogstamboomgaard",
          "L01.16":"Bossingel",
          "L02.01":"Fortterrein",
          "L02.02":"Historisch bouwwerk en erf",
          "L02.03":"Historische tuin",
          "L03.01":"Aardwerk en groeve",
          "N01.01":"Zee en wad",
          "N01.02":"Duin-en kwelderlandschap",
          "N01.03":"Rivier-en moeraslandschap",
          "N01.04":"Zand-en kalklandschap",
          "N02.01":"Rivier-en moeraslandschap",
          "N03.01":"Beek en bron",
          "N04.01":"Kranswierwater",
          "N04.02":"Zoete plas",
          "N04.03":"Brak water",
          "N04.04":"Afgesloten zeearm",
          "N05.01":"Moeras ",
          "N05.02":"Gemaaid rietland",
          "N05.03":"Veenmoeras",
          "N05.04":"Dynamisch Moeras",
          "N06.01":"Veenmosrietland en moerasheide",
          "N06.02":"Trilveen",
          "N06.03":"Hoogveen",
          "N06.04":"Vochtige heide",
          "N06.05":"Zwakgebufferd ven",
          "N06.06":"Zuur ven of hoogveenven",
          "N07.01":"Droge heide",
          "N07.02":"Zandverstuiving",
          "N08.01":"Strand en embryonaal duin",
          "N08.02":"Open duin",
          "N08.03":"Vochtige duinvallei",
          "N08.04":"Duinheide",
          "N09.01":"Schor of kwelder",
          "N10.01":"Nat schraalland",
          "N10.02":"Vochtig hooiland",
          "N11.01":"Droog schraalland",
          "N12.01":"Bloemdijk",
          "N12.02":"Kruiden- en faunarijk grasland",
          "N12.03":"Glanshaverhooiland",
          "N12.04":"Zilt-en overstromingsgrasland",
          "N12.05":"Kruiden-en faunarijke akker",
          "N12.06":"Ruigteveld",
          "N13.01":"Vochtig weidevogelgrasland",
          "N13.02":"Wintergastenweide",
          "N14.01":"Rivier-en beekbegeleidend bos",
          "N14.02":"Hoog-en laagveenbos",
          "N14.03":"Haagbeuken-en essenbos",
          "N15.01":"Duinbos",
          "N15.02":"Dennen-, eiken-, en beukenbos",
          "N16.03":"Droog bos met productie",
          "N16.04":"Vochtig bos met productie",
          "N17.02":"Droog hakhout",
          "N17.03":"Park-en stinzenbos",
          "N17.04":"Eendenkooi",
          "N17.05":"Wilgengriend",
          "N17.06":"Vochtig en hellinghakhout",
          "W01.01":"Agrarisch waterbeheergebied"}

## Voeg beheerTypes N00 toe aan het ambitiedomein
BeheerTypeAmbitieDomein = BeheerTypeDomein.copy()
BeheerTypeAmbitieDomein.update({"N00.01":"Nog om te vormen landbouwgrond naar natuur (inrichting)",
                              "N00.02":"Kwaliteitsimpuls"})

## Verwijder beheerType agrarisch uit het ambitiedomein
for key in list(BeheerTypeAmbitieDomein):
    if key[:1] == 'A':
        del BeheerTypeAmbitieDomein[key]

SubsidiabelDomein = {0:"Nee",
                    1:"Ja"}

StatusEHSDomein = {"1":"EHS Planologisch beschermd",
                  "2":"EHS Planologisch beschermd Grote wateren"}

BijzonderGebiedCodeDomein = {"B1":"Probleemgebiedenvergoeding",
                            "B2":"Vaarland",
                            "B3":"Gescheperde Schaapskuddes"}

AgrarischNatuurTypeDomein = {"A11":"Open Grasland",
                            "A12":"Open Akkerland",
                            "A13":"Droge dooradering",
                            "A14":"Natte dooradering"}

WaterNatuurTypeDomein = {"W01":"Waterbeheergebied"}

ProvincieCodeDomein = {"20":"Groningen",
                      "21":"Friesland",
                      "22":"Drenthe",
                      "23":"Overijssel",
                      "24":"Flevoland",
                      "25":"Gelderland",
                      "26":"Utrecht",
                      "27":"Noord-Holland",
                      "28":"Zuid-Holland",
                      "29":"Zeeland",
                      "30":"Noord-Brabant",
                      "31":"Limburg"}

StatusPlanDomein = {"1":"Concept",
                    "2":"Vastgesteld ontwerp",
                    "3":"Vastgesteld definitief"}

OpenstellingsBijdrageTypeDomein =  {"0":"Geen openstellingsbijdrage",
                                    "1":"Voorzieningenbijdrage",
                                    "2":"Toezichtbijdrage",
                                    "3":"Voorzieningenbijdrage + Toezichtbijdrage"}

StatusPlanDomeinOntwerp = dict(StatusPlanDomein)
del(StatusPlanDomeinOntwerp["1"])

StatusPlanDomeinDefinitief = dict(StatusPlanDomeinOntwerp)
del(StatusPlanDomeinDefinitief["2"])

# aanmaken domeinen
print("Start creating domains...")
arcpy.CreateDomain_management(input_gdb, "domBeheerType", domain_description="Valide beheertypen", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domBeheerTypeAmbitie", domain_description="Valide beheertypen ambitie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domSubsidiabel", domain_description="Valide waarden subsidiabel", field_type="LONG", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domStatusEHS", domain_description="Valide waarden status EHS", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domBijzonderGebiedCode", domain_description="Valide waarden gebiedsCode", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domAgrarischNatuurType", domain_description="Valide waarden agrarischNatuurType", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domWaterNatuurType", domain_description="Valide waarden waterNatuurType", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domProvincieCode", domain_description="Valide waarden provincie", field_type="TEXT", domain_type="CODED")
# arcpy.CreateDomain_management(input_gdb, "domStatusPlan", domain_description="Valide waarden status", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domStatusPlanOntwerp", domain_description="Valide waarden status ontwerpfase", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domStatusPlanDefinitief", domain_description="Valide waarden status definitieve fase", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domOpenstellingsBijdrageType", domain_description="Valide waarden openstellingsBijdrageType", field_type="TEXT", domain_type="CODED")
print("Domains have been created")

# waardes uit dictionaries toevoegen aan domeinen
print("Adding values to domains...")
for code in BeheerTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domBeheerType", code, BeheerTypeDomein[code])
for code in sorted(list(BeheerTypeAmbitieDomein)):
    arcpy.AddCodedValueToDomain_management(input_gdb, "domBeheerTypeAmbitie", code, BeheerTypeAmbitieDomein[code])
for code in SubsidiabelDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domSubsidiabel", code, SubsidiabelDomein[code])
for code in StatusEHSDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusEHS", code, StatusEHSDomein[code])
for code in BijzonderGebiedCodeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domBijzonderGebiedCode", code, BijzonderGebiedCodeDomein[code])
for code in AgrarischNatuurTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domAgrarischNatuurType", code, AgrarischNatuurTypeDomein[code])
for code in WaterNatuurTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domWaterNatuurType", code, WaterNatuurTypeDomein[code])
for code in ProvincieCodeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domProvincieCode", code, ProvincieCodeDomein[code])
# for code in StatusPlanDomein:
#     arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusPlan", code, StatusPlanDomein[code])
for code in StatusPlanDomeinOntwerp:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusPlanOntwerp", code, StatusPlanDomeinOntwerp[code])
for code in StatusPlanDomeinDefinitief:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusPlanDefinitief", code, StatusPlanDomeinDefinitief[code])
for code in OpenstellingsBijdrageTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domOpenstellingsBijdrageType", code, OpenstellingsBijdrageTypeDomein[code])
print("Values have been added to the domains")

# [0] BeheerGebied
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[0])
print("Assign domains to feature class {0}...".format(FC_list[0]))
arcpy.AssignDomainToField_management(FCL_path, "beheerType", "domBeheerType")
arcpy.AssignDomainToField_management(FCL_path, "subsidiabel", "domSubsidiabel")
arcpy.AssignDomainToField_management(FCL_path, "openstellingsBijdrageType", "domOpenstellingsBijdrageType")
print("Domains have been added to feature class {0}".format(FC_list[0]))

# [1] BeheerGebiedAmbitie
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[1])
print("Assign domains to feature class {0}...".format(FC_list[1]))
arcpy.AssignDomainToField_management(FCL_path, "beheerType", "domBeheerTypeAmbitie")
arcpy.AssignDomainToField_management(FCL_path, "subsidiabel", "domSubsidiabel")
arcpy.AssignDomainToField_management(FCL_path, "statusEHS", "domStatusEHS")
print("Domains have been added to feature class {0}".format(FC_list[1]))

# [2] BijzonderGebied
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[2])
print("Assign domains to feature class {0}...".format(FC_list[2]))
arcpy.AssignDomainToField_management(FCL_path, "gebiedsCode", "domBijzonderGebiedCode")
print("Domains have been added to feature class {0}".format(FC_list[2]))

# [4] ZoekGebiedAgrarisch
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[4])
print("Assign domains to feature class {0}...".format(FC_list[4]))
arcpy.AssignDomainToField_management(FCL_path, "agrarischNatuurType", "domAgrarischNatuurType")
print("Domains have been added to feature class {0}".format(FC_list[4]))

# [6] ZoekGebiedWater
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[6])
print("Assign domains to feature class {0}...".format(FC_list[6]))
arcpy.AssignDomainToField_management(FCL_path, "waterNatuurType", "domWaterNatuurType")
print("Domains have been added to feature class {0}".format(FC_list[6]))

# [0] NatuurbeheerPlan
TB_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,TB_list[0])
print("Assign domains to table {0}...".format(TB_list[0]))
arcpy.AssignDomainToField_management(TB_path, "provincie", "domProvincieCode")
arcpy.AssignDomainToField_management(TB_path, "planEigenaar", "domProvincieCode")
arcpy.AssignDomainToField_management(TB_path, "status", "domStatusPlanOntwerp")
arcpy.AssignDomainToField_management(TB_path, "beheerGebiedStatus", "domStatusPlanOntwerp")
arcpy.AssignDomainToField_management(TB_path, "beheerGebiedAmbitieStatus", "domStatusPlanOntwerp")
arcpy.AssignDomainToField_management(TB_path, "bijzonderGebiedStatus", "domStatusPlanOntwerp")
arcpy.AssignDomainToField_management(TB_path, "deelGebiedStatus", "domStatusPlanOntwerp")
arcpy.AssignDomainToField_management(TB_path, "zoekGebiedAgrarischStatus", "domStatusPlanDefinitief")
arcpy.AssignDomainToField_management(TB_path, "zoekGebiedLandschapStatus", "domStatusPlanOntwerp")
arcpy.AssignDomainToField_management(TB_path, "zoekGebiedWaterStatus", "domStatusPlanDefinitief")
print("Domains have been added to table {0}".format(TB_list[0]))

# instellen default waarden voor status velden
print("Assign default status values to table {0}...".format(TB_list[0]))
arcpy.AssignDefaultToField_management(TB_path, "subsidieJaar", 2021)
arcpy.AssignDefaultToField_management(TB_path, "status", "2")
arcpy.AssignDefaultToField_management(TB_path, "beheerGebiedStatus", "2")
arcpy.AssignDefaultToField_management(TB_path, "beheerGebiedAmbitieStatus", "2")
arcpy.AssignDefaultToField_management(TB_path, "bijzonderGebiedStatus", "2")
arcpy.AssignDefaultToField_management(TB_path, "deelGebiedStatus", "2")
arcpy.AssignDefaultToField_management(TB_path, "zoekGebiedAgrarischStatus", "3")
arcpy.AssignDefaultToField_management(TB_path, "zoekGebiedLandschapStatus", "2")
arcpy.AssignDefaultToField_management(TB_path, "zoekGebiedWaterStatus", "3")
print("Default status values have been added to table {0}...".format(TB_list[0]))

# domeinwaarden sorteren in juiste volgorde
print("Sorting domain values in ascending order...")
arcpy.SortCodedValueDomain_management(input_gdb, "domBeheerType", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domBeheerTypeAmbitie", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domSubsidiabel", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domStatusEHS", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domBijzonderGebiedCode", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domAgrarischNatuurType", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domWaterNatuurType", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domProvincieCode", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domStatusPlanOntwerp", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domStatusPlanDefinitief", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domOpenstellingsBijdrageType", "CODE", "ASCENDING")
print("Domain values have been sorted in ascending order")
print("All domains have been added.")

# einde script
print("--*END*--")