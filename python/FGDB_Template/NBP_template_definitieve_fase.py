# Import system modules
print ("Importing python modules...")
import arcpy, os, time
from datetime import datetime

# Current date time
now = datetime.now()

#Start script time
start_time_str = now.strftime("%d-%m-%Y_%H:%M:%S")
print("--*START*--")
print("{0}  Starting script...".format(start_time_str))

# Set local variables
# FGDB variabelen
out_folder_path = "C:/Nirmala/PythonScript/NBP"
fgdb_out_name = "NBP_template.gdb"
out_version = "10.0"
arcpy.env.overwriteOutput = True

# feature class variabelen en environment settings
DS_name = "IMNa"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
arcpy.env.XYResolution = "0.0005 Meters"
arcpy.env.XYTolerance = "0.001 Meters"
SR_name = arcpy.SpatialReference(28992)
FC_list = ["BeheerGebied", "BeheerGebiedAmbitie", "ZoekGebiedKlimaat", "ZoekGebiedAgrarisch", "ZoekGebiedWater"]
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
for fcl in FC_list:
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
arcpy.AddField_management(FCL_path, "voorzieningenbijdrage", "LONG", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "toezichtbijdrage", "LONG", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "bijdrageVaarland", "LONG", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "bijdrageMonitoring", "LONG", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "bijdrageGescheperdeSchaapskuddes", "LONG", field_is_nullable="NON_NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[0]))

# [1] BeheerGebiedAmbitie
print ("Adding attributes to feature class {0}...".format(FC_list[1]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[1]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "statusNNN", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "beheerType", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "subsidiabel", "LONG", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "indicatieveVerhoudingBeheertypen", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[1]))

# [2] ZoekGebiedKlimaat
print ("Adding attributes to feature class {0}...".format(FC_list[2]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[2]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "naam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "klimaatNatuurType", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "deelgebied", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerFuncties", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerTypen", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[2]))

# [3] ZoekGebiedAgrarisch
print ("Adding attributes to feature class {0}...".format(FC_list[3]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[3]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "agrarischNatuurType", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "naam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "deelgebied", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerFuncties", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerTypen", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[3]))

# [4] ZoekGebiedWater
print ("Adding attributes to feature class {0}...".format(FC_list[4]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[4]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "naam", "TEXT", field_length=100, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "waterNatuurType", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "deelgebied", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerFuncties", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "toegestaneBeheerTypen", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[4]))

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
arcpy.AddField_management(TBL_path, "zoekGebiedKlimaatStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "zoekGebiedAgrarischStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "zoekGebiedWaterStatus", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
print ("Added attributes to table {0}.".format(TB_list[0]))

# [1] TemplateVersie
print ("Adding attributes to table {0}...".format(TB_list[1]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[1]))
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=8, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "datumCreatie", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "releaseNotes", "TEXT", field_length=20000, field_is_nullable="NON_NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "datumCreatie", "releaseNotes"]) as cursor:
    cursor.insertRow(["2020.3.1", "20/07/2020", "Template voor het indienen van Natuurbeheerplannen voor 2021 in de definitieve fase."])
    cursor.insertRow(["2021.1.1", "22/02/2021", "IMNA-2429 - Remove SNL-a."])
    cursor.insertRow(["2021.1.2", "25/02/2021", "IMNA-2465 - Remove ZoekGebiedLandschap, IMNA-2154 - Restrict wrong statuses"])
    cursor.insertRow(["2021.1.3", "05/03/2021", "IMNA-2814 - Create new year NBP"])
    cursor.insertRow(["2021.1.4", "22/04/2021", "Value for fields status, beheerGebiedStatus, beheerGebiedAmbitieStatus, bijzonderGebiedStatus and deelGebiedStatus changed to Vastgesteld definitief"])
    cursor.insertRow(["2022.1.1", "01/02/2022", "IMNA-6029 - NBP Changes 2023"])
    cursor.insertRow(["2022.1.2", "10/02/2022", "IMNA-6063 - Updated beheertype domain"])
    cursor.insertRow(["2022.1.3", "18/02/2022", "IMNA-5960 - New provincie borders"])
    cursor.insertRow(["2022.1.4", "09/03/2022", "IMNA-6403 - Updated beheertype domain"])
    cursor.insertRow(["2022.1.5", "24/03/2022", "IMNA-6600 - Updated deelgebied domain"])
    cursor.insertRow(["2022.1.6", "01/04/2022", "IMNA-6638, IMNA-6670 - Updated deelgebied domain and status"])
    cursor.insertRow(["2022.1.7", "01/07/2022", "IMNA-6795 - Updated deelgebied domain and status"])
    cursor.insertRow(["2022.1.8", "08/08/2022", "M2208-014 - Updated deelgebied domain"])
    cursor.insertRow(["2023.1.1", "20/02/2023", "IMNA-8606 - NBP: Generate new year 2024"])
    cursor.insertRow(["2023.1.2", "04/08/2023", "GBOALB-353 - Create FGDB template NBP"])
    cursor.insertRow(["2024.1.1", "06/02/2024", "IMNA-10928,12544 - NBP: Ambitiekaart attributes: add StatusNNN,Generate new year (2025)"])
    cursor.insertRow(["2024.1.2", "19/02/2024", "IMNA-13252 SNL: update 'Bestuurlijke gebieden' as per  2024"])
    cursor.insertRow(["2024.1.3", "20/05/2024", "IMNA-14479 Standaard change 028 GBO ‘Wijzigen van NBP Ontwerp naar NBP Definitief en v.v. voor SNL'"])
    cursor.insertRow(["2024.1.4", "13/11/2024", "IMNA-6004 NBP: Remove maplayer Deelgebied"])
    cursor.insertRow(["2024.1.5", "19/11/2024", "IMNA-6685 NBP: Remove toegestane beheerpakketten"])
    cursor.insertRow(["2025.1.1", "30/01/2025", "IMNA-18113 NBP: Generate new year (2026)"])
    cursor.insertRow(["2025.1.2", "31/01/2025", "IMNA-18126 SNL: Annual update Bestuurlijke gebieden"])
    cursor.insertRow(["2025.1.3", "05/06/2025", "SNL-2947 NBP: Enable submit option for Natuurbeheerplan Definitief"])
    cursor.insertRow(["2026.1.1", "02/02/2026", "SNL-3808 NBP - Publish Template Natuurbeheerplan 2027"])
    cursor.insertRow(["2026.1.2", "19/05/2026", "SNL-3747 NBP - Enable submit option for Natuurbeheerplan Definitief"])
print ("Added attributes to table {0}.".format(TB_list[1]))

# Provinciegrenzen laag toevoegen
print("Copy feature class {0}...".format("Provinciegrenzen"))
arcpy.CreateFeatureclass_management(DS_path, "Provinciegrenzen", geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,"Provinciegrenzen")
arcpy.AddField_management(FCL_path, "NAAMOFFICIEEL", "TEXT", field_length=50)
arcpy.AddField_management(FCL_path, "NUMMER_CSV", "SHORT")
#prov_path = "C:/Naveen/PythonScript/NBP/BestuurlijkeGebieden_2026.gpkg/provinciegebied"
orig_path = "{0}/{1}/{2}".format(out_folder_path,"BestuurlijkeGebieden_2026.gpkg","provinciegebied")
with arcpy.da.SearchCursor(orig_path, ["naam", "code", "Shape@"]) as cursor1, arcpy.da.InsertCursor(FCL_path, ["NAAMOFFICIEEL", "NUMMER_CSV", "Shape@"]) as cursor2:
    for row in cursor1:
        cursor2.insertRow(row)
print("Feature class {0} has been copied.".format("Provinciegrenzen"))

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
                    "A15.01":"Bomenrij en singel",
                    "A15.02":"Struweel en ruigte",
                    "A15.03":"Watergang",
                    "A15.04":"Poel",
                    "K01.01":"Agrarisch klimaatbeheergebied",
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
                    "N00.01":"Nog om te vormen landbouwgrond naar natuur (inrichting)",
                    "N00.02":"Kwaliteitsimpuls",
                    "N01.01":"Zee en wad",
                    "N01.02":"Duin-en kwelderlandschap",
                    "N01.03":"Rivier-en moeraslandschap",
                    "N01.04":"Zand-en kalklandschap",
                    "N02.01":"Rivier",
                    "N03.01":"Beek en bron",
                    "N04.01":"Kranswierwater",
                    "N04.02":"Zoete plas",
                    "N04.03":"Brak water",
                    "N04.04":"Afgesloten zeearm",
                    "N05.01":"Moeras",
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
                    "N12.02":"Kruiden-en faunarijk grasland",
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
                    "N17.06":"Vochtig en hellinghakhout"}

## Voeg beheerTypes N00 toe aan het ambitiedomein
BeheerTypeAmbitieDomein = BeheerTypeDomein.copy()

## Verwijder beheerType agrarisch uit het ambitiedomein
for key in list(BeheerTypeAmbitieDomein):
    if key[:1] == 'A':
        del BeheerTypeAmbitieDomein[key]

NeeYaDomein = {0:"Nee",
                    1:"Ja"}

StatusNNNDomein = {"Binnen NNN":"Binnen NNN",
                  "Buiten NNN":"Buiten NNN"}

AgrarischNatuurTypeDomein = {"A11":"Open Grasland",
                            "A12":"Open Akkerland",
                            "A15":"Dooradering"}

WaterNatuurTypeDomein = {"W01":"Waterbeheergebied"}

KlimaatNatuurTypeDomein = {"K01":"Klimaatbeheergebieden"}

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

StatusPlanDomeinOntwerp = {"2":"Vastgesteld ontwerp"}

StatusPlanDomeinDefinitief = {"3":"Vastgesteld definitief"}

DeelgebiedDomein = {"DG03":"Achterhoek",
					"DG05":"Rivierenland",
					"DG06":"Rivierenland1",
					"DG07":"Rivierenland2",
					"DG08":"Veluwe",
					"DG10":"Akkerranden",
					"DG11":"Duurzaam bodembeheer",
					"DG12":"Landschap",
					"DG13":"Natuurvriendelijk beheren",
					"DG14":"Purperreiger",
					"DG16":"Soortenrijke akkers",
					"DG18":"Waterberging",
					"DG20":"Weidevogelrandzone",
					"DG21":"Zwarte Stern",
					"DG60":"Weidevogels in open grasland",
					"DG61":"Hamster in open akker", 
					"DG62":"Overwinterende akkervogels in open akker", 
					"DG63":"Broedende akkervogels in open akker", 
					"DG64":"Kraanvogel in open akker",
					"DG65":"Doelsoorten in een mozaïek in dooradering",
					"DG66":"Donker pimpernelblauwtje in dooradering",
					"DG67":"Vermindering uitspoeling naar natuurgebieden",
					"DG68":"Vermindering afstroming naar natuurgebieden",
					"DG69":"Vermindering verdroging van natuurgebieden",
					"DG70":"Vermindering uitspoeling en afstroming naar waterlopen", 
					"DG71":"Vermindering verdroging van beekdalen", 
					"DG72":"Erosiebeperking op steile hellingen",
					"DG73":"Brede klimaatdoelen",
					"DG74":"Volvelds botanisch grasland",
					"DG75":"Botanische graslandranden",
					"DG76":"Weidevogelkerngebied aanvalsplan grutto",
					"DG77":"Overig weidevogelkerngebied", 
					"DG78":"Brabantse Wal & Baronie",
					"DG79":"De Peel",
					"DG80":"Land van Altena",
					"DG81":"Maasheggen",
					"DG82":"Maaskant Oost",
					"DG83":"Maaskant West",
					"DG84":"Meijerij en Kempen",
					"DG85":"Zeekleigebied"}

# aanmaken domeinen
print("Start creating domains...")
arcpy.CreateDomain_management(input_gdb, "domBeheerType", domain_description="Valide beheertypen", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domBeheerTypeAmbitie", domain_description="Valide beheertypen ambitie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domNeeYa", domain_description="Valide waarden subsidiabel", field_type="LONG", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domStatusNNN", domain_description="Valide waarden status NNN", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domAgrarischNatuurType", domain_description="Valide waarden agrarischNatuurType", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domWaterNatuurType", domain_description="Valide waarden waterNatuurType", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domKlimaatNatuurType", domain_description="Valide waarden klimaatNatuurType", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domProvincieCode", domain_description="Valide waarden provincie", field_type="TEXT", domain_type="CODED")
# arcpy.CreateDomain_management(input_gdb, "domStatusPlan", domain_description="Valide waarden status", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domStatusPlanOntwerp", domain_description="Valide waarden status ontwerpfase", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domStatusPlanDefinitief", domain_description="Valide waarden status definitieve fase", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domDeelgebied", domain_description="Valide deelgebied", field_type="TEXT", domain_type="CODED")
print("Domains have been created")

# waardes uit dictionaries toevoegen aan domeinen
print("Adding values to domains...")
for code in BeheerTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domBeheerType", code, BeheerTypeDomein[code])
for code in sorted(list(BeheerTypeAmbitieDomein)):
    arcpy.AddCodedValueToDomain_management(input_gdb, "domBeheerTypeAmbitie", code, BeheerTypeAmbitieDomein[code])
for code in NeeYaDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domNeeYa", code, NeeYaDomein[code])
for code in StatusNNNDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusNNN", code, StatusNNNDomein[code])
for code in AgrarischNatuurTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domAgrarischNatuurType", code, AgrarischNatuurTypeDomein[code])
for code in WaterNatuurTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domWaterNatuurType", code, WaterNatuurTypeDomein[code])
for code in KlimaatNatuurTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domKlimaatNatuurType", code, KlimaatNatuurTypeDomein[code])
for code in ProvincieCodeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domProvincieCode", code, ProvincieCodeDomein[code])
# for code in StatusPlanDomein:
#     arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusPlan", code, StatusPlanDomein[code])
for code in StatusPlanDomeinOntwerp:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusPlanOntwerp", code, StatusPlanDomeinOntwerp[code])
for code in StatusPlanDomeinDefinitief:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusPlanDefinitief", code, StatusPlanDomeinDefinitief[code])
for code in DeelgebiedDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domDeelgebied", code, DeelgebiedDomein[code])
print("Values have been added to the domains")

# [0] BeheerGebied
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[0])
print("Assign domains to feature class {0}...".format(FC_list[0]))
arcpy.AssignDomainToField_management(FCL_path, "beheerType", "domBeheerType")
arcpy.AssignDomainToField_management(FCL_path, "subsidiabel", "domNeeYa")
arcpy.AssignDomainToField_management(FCL_path, "voorzieningenbijdrage", "domNeeYa")
arcpy.AssignDomainToField_management(FCL_path, "toezichtbijdrage", "domNeeYa")
arcpy.AssignDomainToField_management(FCL_path, "bijdrageVaarland", "domNeeYa")
arcpy.AssignDomainToField_management(FCL_path, "bijdrageMonitoring", "domNeeYa")
arcpy.AssignDomainToField_management(FCL_path, "bijdrageGescheperdeSchaapskuddes", "domNeeYa")
print("Domains have been added to feature class {0}".format(FC_list[0]))

# [1] BeheerGebiedAmbitie
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[1])
print("Assign domains to feature class {0}...".format(FC_list[1]))
arcpy.AssignDomainToField_management(FCL_path, "beheerType", "domBeheerTypeAmbitie")
arcpy.AssignDomainToField_management(FCL_path, "subsidiabel", "domNeeYa")
arcpy.AssignDomainToField_management(FCL_path, "statusNNN", "domStatusNNN")
print("Domains have been added to feature class {0}".format(FC_list[1]))

# [2] ZoekGebiedKlimaat
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[2])
print("Assign domains to feature class {0}...".format(FC_list[2]))
arcpy.AssignDomainToField_management(FCL_path, "deelgebied", "domDeelgebied")
arcpy.AssignDomainToField_management(FCL_path, "klimaatNatuurType", "domKlimaatNatuurType")
print("Domains have been added to feature class {0}".format(FC_list[2]))

# [3] ZoekGebiedAgrarisch
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[3])
print("Assign domains to feature class {0}...".format(FC_list[3]))
arcpy.AssignDomainToField_management(FCL_path, "deelgebied", "domDeelgebied")
arcpy.AssignDomainToField_management(FCL_path, "agrarischNatuurType", "domAgrarischNatuurType")
print("Domains have been added to feature class {0}".format(FC_list[3]))

# [4] ZoekGebiedWater
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[4])
print("Assign domains to feature class {0}...".format(FC_list[4]))
arcpy.AssignDomainToField_management(FCL_path, "deelgebied", "domDeelgebied")
arcpy.AssignDomainToField_management(FCL_path, "waterNatuurType", "domWaterNatuurType")
print("Domains have been added to feature class {0}".format(FC_list[4]))

# [0] NatuurbeheerPlan
TB_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,TB_list[0])
print("Assign domains to table {0}...".format(TB_list[0]))
arcpy.AssignDomainToField_management(TB_path, "provincie", "domProvincieCode")
arcpy.AssignDomainToField_management(TB_path, "planEigenaar", "domProvincieCode")
arcpy.AssignDomainToField_management(TB_path, "status", "domStatusPlanDefinitief")
arcpy.AssignDomainToField_management(TB_path, "beheerGebiedStatus", "domStatusPlanDefinitief")
arcpy.AssignDomainToField_management(TB_path, "beheerGebiedAmbitieStatus", "domStatusPlanDefinitief")
arcpy.AssignDomainToField_management(TB_path, "zoekGebiedKlimaatStatus", "domStatusPlanDefinitief")
arcpy.AssignDomainToField_management(TB_path, "zoekGebiedAgrarischStatus", "domStatusPlanDefinitief")
arcpy.AssignDomainToField_management(TB_path, "zoekGebiedWaterStatus", "domStatusPlanDefinitief")
print("Domains have been added to table {0}".format(TB_list[0]))

# instellen default waarden voor status velden
print("Assign default status values to table {0}...".format(TB_list[0]))
arcpy.AssignDefaultToField_management(TB_path, "subsidieJaar", 2027)
arcpy.AssignDefaultToField_management(TB_path, "status", "3")
arcpy.AssignDefaultToField_management(TB_path, "beheerGebiedStatus", "3")
arcpy.AssignDefaultToField_management(TB_path, "beheerGebiedAmbitieStatus", "3")
arcpy.AssignDefaultToField_management(TB_path, "zoekGebiedKlimaatStatus", "3")
arcpy.AssignDefaultToField_management(TB_path, "zoekGebiedAgrarischStatus", "3")
arcpy.AssignDefaultToField_management(TB_path, "zoekGebiedWaterStatus", "3")
print("Default status values have been added to table {0}...".format(TB_list[0]))

# domeinwaarden sorteren in juiste volgorde
print("Sorting domain values in ascending order...")
arcpy.SortCodedValueDomain_management(input_gdb, "domBeheerType", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domBeheerTypeAmbitie", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domNeeYa", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domStatusNNN", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domAgrarischNatuurType", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domWaterNatuurType", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domKlimaatNatuurType", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domProvincieCode", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domStatusPlanOntwerp", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domStatusPlanDefinitief", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domDeelgebied", "CODE", "ASCENDING")
print("Domain values have been sorted in ascending order")

print("All domains have been added.")

# einde script
print("--*END*--")
