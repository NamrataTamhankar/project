# Import system modules
print ("Importing python modules...")
import arcpy, os, time
from datetime import datetime

# Current date time
start_time = time.time()
now = datetime.now()

#Start script time
start_time_str = now.strftime("%d-%m-%Y_%H:%M:%S")

print("--*START*--")
print("{0}  Starting script...".format(start_time_str))

# Set local variables
# FGDB variabelen
out_folder_path ="C:/Naveen/PythonScript/BES" 
fgdb_out_name = "Beschikkingen_RVO_template.gdb"
out_version = "10.0"
arcpy.env.overwriteOutput = True

# featureclass variabelen en environment settings
DS_name = "IMNa"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
arcpy.env.XYResolution = "0.0005 Meters"
arcpy.env.XYTolerance = "0.001 Meters"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
SR_name = arcpy.SpatialReference(28992)

FC_list = ["Beschikking"]
TB_list = ["BeschikkingenRapportage", "TemplateVersie"]

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

# Dataset aanmaken
# IMNa dataset
out_sr = arcpy.CreateSpatialReference_management(SR_name)
print ("Creating dataset with name {0}...".format(DS_name))
arcpy.CreateFeatureDataset_management(input_gdb, DS_name, out_sr)
print ("Dataset with name {0} has been created.".format(DS_name))

# Featureclasses aanmaken
for fcl in FC_list:
    print ("Creating featureclass {0}...".format(fcl))
    arcpy.CreateFeatureclass_management(DS_path, fcl, geometry_type="POLYGON")
    print ("Featureclass {0} has been created.".format(fcl))

for tbl in TB_list:
    print ("Creating table {0}...".format(tbl))
    arcpy.CreateTable_management(input_gdb, tbl)
    print ("Table {0} has been created.".format(tbl))

# Toevoegen van de attribuutvelden aan de featureclasses
# [0] Beschikking
print ("Adding attributes to feature class {0}...".format(FC_list[0]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[0]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "contractNummer", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "datumBeschikking", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "typeRegeling", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(FCL_path, "beheerType", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "statusAanvraagSubsidie", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "provincie", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[0]))

# Toevoegen van de attribuutvelden aan de tabellen
# [0] BeschikkingenRapportage
print ("Adding attributes to table {0}...".format(TB_list[0]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[0]))
arcpy.AddField_management(TBL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "provincie", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "beheerJaar", "SHORT", field_is_nullable="NON_NULLABLE")
print ("Added attributes to table {0}.".format(TB_list[0]))

# [1] TemplateVersie
print ("Adding attributes to table {0}...".format(TB_list[1]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[1]))
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=8, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "datumCreatie", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "releaseNotes", "TEXT", field_length=20000, field_is_nullable="NON_NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "datumCreatie", "releaseNotes"]) as cursor:
    cursor.insertRow(["v2023.1", "07/02/2023", "IMNA-8608: Template for year 2023"])
    cursor.insertRow(["v2024.1", "02/02/2024", "IMNA-12026: errors in template BES 2023"])
    cursor.insertRow(["v2024.2", "19/02/2024", "IMNA-13252: SNL: update 'Bestuurlijke gebieden' as per  2024"])
    cursor.insertRow(["v2025.1", "31/01/2025", "IMNA-18126 SNL: Annual update Bestuurlijke gebieden"])
    cursor.insertRow(["v2026.1", "03/02/2026", "SNL-3888 BES - Publish Template Beschikkingen 2026"])
print ("Added attributes to table {0}.".format(TB_list[1]))

# Provinciegrenzen laag toevoegen
print("Copy feature class {0}...".format("Provinciegrenzen"))
arcpy.CreateFeatureclass_management(DS_path, "Provinciegrenzen", geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,"Provinciegrenzen")
arcpy.AddField_management(FCL_path, "NAAMOFFICIEEL", "TEXT", field_length=50)
arcpy.AddField_management(FCL_path, "NUMMER_CSV", "SHORT")
#prov_path = "C:/Naveen/PythonScript/BES/BestuurlijkeGebieden_2026.gpkg/provinciegebied"
orig_path = "{0}/{1}/{2}".format(out_folder_path,"BestuurlijkeGebieden_2026.gpkg","provinciegebied")
with arcpy.da.SearchCursor(orig_path, ["naam", "code", "Shape@"]) as cursor1, arcpy.da.InsertCursor(FCL_path, ["NAAMOFFICIEEL", "NUMMER_CSV", "Shape@"]) as cursor2:
    for row in cursor1:
        cursor2.insertRow(row)
print("Feature class {0} has been copied.".format("Provinciegrenzen"))

# Domeinen instellen
# maak dictionaries met waarden en omschrijvingen
input_gdb = "{0}/{1}".format(out_folder_path, fgdb_out_name)

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
                      "31":"Limburg",
                      "55":"Rijksdienst voor Ondernemend Nederland"}

StatusAanvraagSubsidieDomein =  {"2":"Beschikt"}

TypeRegelingDomein = {"1":"SVNL-N 2016",
                      "2":"SNL-N",
                      "4":"SKNL",
                      "5":"TRPN",
                      "6":"GroenBlauwe Diensten",
                      "7":"Regeling Experimenten",
                      "10":"SN/PSN",
                      "11":"Versneld natuurherstel Natura2000"}

BeheerTypeDomein = {"L01.01":"Poel en klein historisch water",
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
          "N17.06":"Vochtig en hellinghakhout",
          "L01.04":"Bossingel en bosje",
          "L01.10":"Struweelrand",
          "L01.11":"Hakhoutbosje",
          "L01.12":"Griendje",
          "L01.13":"Bomenrij en solitaire boom",
          "L01.14":"Rietzoom en klein rietperceel",
          "L01.15":"Natuurvriendelijke oever",
          "L04.01":"Wandelpad over boerenland",
          "N16.01":"Droog bos met productie (hout op stam)",
          "N16.02":"Vochtig bos met productie (hout op stam)",
          "N17.01":"Vochtig hakhout en middenbos"}

## aanmaken domeinen
print("Start creating domains...")
arcpy.CreateDomain_management(input_gdb, "domProvincieCode", domain_description="Valide waarden provincie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domStatusAanvraagSubsidie", domain_description="Valide waarden statusAanvraagSubsidie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domTypeRegeling", domain_description="Valide waarden typeRegeling", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domBeheerType", domain_description="Valide waarden beheerType", field_type="TEXT", domain_type="CODED")
print("Domains have been created")

# waardes toevoegen aan domeinen
print("Adding values to domains...")
for code in ProvincieCodeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domProvincieCode", code, ProvincieCodeDomein[code])
for code in StatusAanvraagSubsidieDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusAanvraagSubsidie", code, StatusAanvraagSubsidieDomein[code])
for code in TypeRegelingDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domTypeRegeling", code, TypeRegelingDomein[code])
for code in BeheerTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domBeheerType", code, BeheerTypeDomein[code])
print("Values have been added to the domains")

# domeinen toekennen aan de juiste attributen
# [0] Beschikking
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[0])
print("Assign domains to feature class {0}...".format(FC_list[0]))
arcpy.AssignDomainToField_management(FCL_path, "statusAanvraagSubsidie", "domStatusAanvraagSubsidie")
arcpy.AssignDomainToField_management(FCL_path, "typeRegeling", "domTypeRegeling")
arcpy.AssignDomainToField_management(FCL_path, "beheerType", "domBeheerType")
arcpy.AssignDefaultToField_management(FCL_path, "statusAanvraagSubsidie", "2")
arcpy.AssignDomainToField_management(FCL_path, "provincie", "domProvincieCode")
print("Domains have been added to feature class {0}".format(FC_list[0]))

# [0] BeschikkingenRapportage
TB_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,TB_list[0])
print("Assign domains to table {0}...".format(TB_list[0]))
arcpy.AssignDomainToField_management(TB_path, "provincie", "domProvincieCode")
print("Domains have been added to table {0}".format(TB_list[0]))

# domeinwaarden sorteren in juiste volgorde
print("Sorting domain values in ascending order...")
arcpy.SortCodedValueDomain_management(input_gdb, "domStatusAanvraagSubsidie", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domTypeRegeling", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domProvincieCode", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domBeheerType", "CODE", "ASCENDING")
print("Domain values have been sorted in ascending order")

print("All domains have been added.")

print("--*END*--")
