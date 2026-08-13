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
out_folder_path = "C:/Naveen/PythonScript/VRN" 
fgdb_out_name = "VRN_aggregate_template.gdb"
out_version = "10.0"
arcpy.env.overwriteOutput = True

# featureclass variabelen en environment settings
DS_name = "IMNa"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
arcpy.env.XYResolution = "0.0005 Meters"
arcpy.env.XYTolerance = "0.001 Meters"
SR_name = arcpy.SpatialReference(28992)
FC_list = ["GebiedNatuur", "GebiedInrichting", "GebiedVerwerving", "NatuurNetwerkNederland"]
TB_list = ["VoortgangsRapportage", "ResterendeInrichtingsAmbitie", "TemplateVersie"]

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
    print ("File geodatabase with name {0} has been created.".format(fgdb_out_name))
    input_gdb = "{0}/{1}".format(out_folder_path,fgdb_out_name)
    DS_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,DS_name)
else:
    # Aanmaken FGDB zonder timestamp
    print ("No previous versions found. Creating file geodatabase with name {0}...".format(fgdb_out_name))
    arcpy.CreateFileGDB_management(out_folder_path, fgdb_out_name, out_version)
    print ("File geodatabase with name {0} has been created.".format(fgdb_out_name))
    input_gdb = "{0}/{1}".format(out_folder_path,fgdb_out_name)
    DS_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,DS_name)

# Dataset aanmaken
# IMNa dataset
out_sr = arcpy.CreateSpatialReference_management(SR_name)
print ("Creating dataset with name {0}...".format(DS_name))
arcpy.CreateFeatureDataset_management(input_gdb,DS_name,out_sr)
print ("Dataset with name {0} has been created.".format(DS_name))

# Featureclasses aanmaken
for fcl in FC_list:
    print ("Creating featureclass {0}...".format(fcl))
    arcpy.CreateFeatureclass_management(DS_path, fcl, geometry_type="POLYGON")
    print ("Featureclass {0} has been created.".format(fcl))

# tabellen aanmaken
for tbl in TB_list:
    print ("Creating table {0}...".format(tbl))
    arcpy.CreateTable_management(input_gdb, tbl)
    print ("Table {0} has been created.".format(tbl))

# Toevoegen van de attribuutvelden aan de featureclasses
# [0] GebiedNatuur
print ("Adding attributes to feature class {0}...".format(FC_list[0]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[0]))
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE")
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "statusNatuur", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "provincie", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[0]))

# [1] GebiedInrichting
print ("Adding attributes to feature class {0}...".format(FC_list[1]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[1]))
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE")
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "provincie", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[1]))

# [2] GebiedVerwerving
print ("Adding attributes to feature class {0}...".format(FC_list[2]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[2]))
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE")
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "provincie", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[2]))

# [3] NatuurNetwerkNederland
print ("Adding attributes to feature class {0}...".format(FC_list[3]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[3]))
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE")
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "provincie", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[3]))

# Toevoegen van de attribuutvelden aan de tabellen
# [0] VoortgangsRapportage
print ("Adding attributes to table {0}...".format(TB_list[0]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[0]))
arcpy.AddField_management(TBL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "bronHouder", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "rapportageJaar", "SHORT", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "opmerkingen", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
print ("Added attributes to table {0}.".format(TB_list[0]))

# [1] ResterendeInrichtingsAmbitie
print ("Adding attributes to table {0}...".format(TB_list[1]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[1]))
arcpy.AddField_management(TBL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "resterendeInrichtingsAmbitie", "LONG", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "provincie", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to table {0}.".format(TB_list[1]))

# [2] TemplateVersie
print ("Adding attributes to table {0}...".format(TB_list[2]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[2]))
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=8, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "datumCreatie", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "releaseNotes", "TEXT", field_length=20000, field_is_nullable="NON_NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "datumCreatie", "releaseNotes"]) as cursor:
    cursor.insertRow(["1", "22/03/2021", "FGDB Template for aggregated VRN"])
    cursor.insertRow(["2022.1.1", "15/03/2022", "IMNA-5792 - Template for year 2021 and added domain values"])
    cursor.insertRow(["2023.1.1", "07/02/2023", "IMNA-8607 - Template for year 2022"])
    cursor.insertRow(["2024.1.1", "07/02/2024", "IMNA-12545 -  VRN: Generate new year (2023)"])
    cursor.insertRow(["2024.1.2", "20/02/2024", "IMNA-13252 - SNL: update 'Bestuurlijke gebieden' as per  2024"])
    cursor.insertRow(["2025.1.1", "31/01/2025", "IMNA-18126 SNL: Annual update Bestuurlijke gebieden"])
    cursor.insertRow(["2026.1.1", "27/01/2026", "SNL-3893 VRN - Publish Template Voortgangsrapportage natuur 2025"])
print ("Added attributes to table {0}.".format(TB_list[2]))

# Provinciegrenzen laag toevoegen
print("Copy feature class {0}...".format("Provinciegrenzen"))
arcpy.CreateFeatureclass_management(DS_path, "Provinciegrenzen", geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,"Provinciegrenzen")
arcpy.AddField_management(FCL_path, "NAAMOFFICIEEL", "TEXT", field_length=50)
arcpy.AddField_management(FCL_path, "NUMMER_CSV", "SHORT")
#prov_path = "C:/Naveen/PythonScript/VRN/BestuurlijkeGebieden_2025.gpkg/provinciegebied"
orig_path = "{0}/{1}/{2}".format(out_folder_path,"BestuurlijkeGebieden_2025.gpkg","provinciegebied")
with arcpy.da.SearchCursor(orig_path, ["naam", "code", "Shape@"]) as cursor1, arcpy.da.InsertCursor(FCL_path, ["NAAMOFFICIEEL", "NUMMER_CSV", "Shape@"]) as cursor2:
    for row in cursor1:
        cursor2.insertRow(row)
print("Feature class {0} has been copied.".format("Provinciegrenzen"))

# Domeinen instellen
# aanmaken dictionaries met waarde en omschrijving
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

StatusNatuurDomein = {"1":"Natuur met SNL-subsidie (of voorlopers hiervan)",
                    "2":"Natuur zonder SNL-subsidie"}

## aanmaken domeinen
print("Start creating domains...")
arcpy.CreateDomain_management(input_gdb, "domProvincieCode", domain_description="Valide waarden provincie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domStatusNatuur", domain_description="Valide Status Natuur", field_type="TEXT", domain_type="CODED")
print("Domains have been created")

# waarden uit dictionaries toevoegen aan domeinen
print("Adding values to domains...")
for code in ProvincieCodeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domProvincieCode", code, ProvincieCodeDomein[code])
for code in StatusNatuurDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domStatusNatuur", code, StatusNatuurDomein[code])
print("Values have been added to the domains")

# domeinen toekennen aan de juiste attribuutvelden
# [0] GebiedNatuur
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[0])
print("Assign domains to feature class {0}...".format(FC_list[0]))
arcpy.AssignDomainToField_management(FCL_path, "statusNatuur", "domStatusNatuur")
arcpy.AssignDomainToField_management(FCL_path, "provincie", "domProvincieCode")
print("Domains have been added to feature class {0}".format(FC_list[0]))

# [1] GebiedInrichting
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[1])
print("Assign domains to feature class {0}...".format(FC_list[1]))
arcpy.AssignDomainToField_management(FCL_path, "provincie", "domProvincieCode")
print("Domains have been added to feature class {0}".format(FC_list[1]))

# [2] GebiedVerwerving
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[2])
print("Assign domains to feature class {0}...".format(FC_list[2]))
arcpy.AssignDomainToField_management(FCL_path, "provincie", "domProvincieCode")
print("Domains have been added to feature class {0}".format(FC_list[2]))

# [3] NatuurNetwerkNederland
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[3])
print("Assign domains to feature class {0}...".format(FC_list[3]))
arcpy.AssignDomainToField_management(FCL_path, "provincie", "domProvincieCode")
print("Domains have been added to feature class {0}".format(FC_list[3]))

# [0] VoortgangsRapportage
TB_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,TB_list[0])
print("Assign domains to table {0}...".format(TB_list[0]))
arcpy.AssignDomainToField_management(TB_path, "bronHouder", "domProvincieCode")
print("Domains have been added to table {0}".format(TB_list[0]))

# [1] ResterendeInrichtingsAmbitie
TB_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,TB_list[1])
print("Assign domains to table {0}...".format(TB_list[1]))
arcpy.AssignDomainToField_management(TB_path, "provincie", "domProvincieCode")
print("Domains have been added to table {0}".format(TB_list[1]))

print("All domains have been added.")

print("--*END*--")
