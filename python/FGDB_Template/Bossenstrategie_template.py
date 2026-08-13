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
out_folder_path = "C:/Naveen/PythonScript/BOS" 
fgdb_out_name = "Bossenstrategie_template.gdb"
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

FC_list = ["VoortgangProvincialeOpgaveBossenstrategie", "Provinciegrenzen"]
TB_list = ["BossenstrategieRapportage", "TemplateVersie"]

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

# Featureclasses aanmaken (behalve provinciegrenzen)
for fcl in FC_list[:-1]:
    print ("Creating featureclass {0}...".format(fcl))
    arcpy.CreateFeatureclass_management(DS_path, fcl, geometry_type="POLYGON")
    print ("Featureclass {0} has been created.".format(fcl))

for tbl in TB_list:
    print ("Creating table {0}...".format(tbl))
    arcpy.CreateTable_management(input_gdb, tbl)
    print ("Table {0} has been created.".format(tbl))

# Toevoegen van de attribuutvelden aan de featureclasses
# [0] VoortgangProvincialeOpgaveBossenstrategie
print ("Adding attributes to feature class {0}...".format(FC_list[0]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[0]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "typeBos", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "typeCompensatie", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(FCL_path, "typeOmvorming", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "redenEinde", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "wijzeCompensatie", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[0]))

# Toevoegen van de attribuutvelden aan de tabellen
# [0] BossenstrategieRapportage
print ("Adding attributes to table {0}...".format(TB_list[0]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[0]))
arcpy.AddField_management(TBL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "bronhouder", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "rapportagejaar", "SHORT", field_is_nullable="NON_NULLABLE")
print ("Added attributes to table {0}.".format(TB_list[0]))

# [1] TemplateVersie
print ("Adding attributes to table {0}...".format(TB_list[1]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[1]))
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=5, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "datumCreatie", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "releaseNotes", "TEXT", field_length=255, field_is_nullable="NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "datumCreatie", "releaseNotes"]) as cursor:
    cursor.insertRow(["v2024", "23/04/2024", "IMNa-13995 Build FGDB template Monitor Landelijke Bossenstrategie"])
    cursor.insertRow(["v2024", "24/04/2024", "IMNa-14503 Bossenstrategie: FGDB template doesn't contain default current year 2024"])
print ("Added attributes to table {0}.".format(TB_list[1]))

# Provinciegrenzen laag toevoegen
print("Copy feature class {0}...".format("Provinciegrenzen"))
arcpy.CreateFeatureclass_management(DS_path, "Provinciegrenzen", geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,"Provinciegrenzen")
arcpy.AddField_management(FCL_path, "NAAMOFFICIEEL", "TEXT", field_length=50)
arcpy.AddField_management(FCL_path, "NUMMER_CSV", "SHORT")
orig_path = "{0}/{1}/{2}".format(out_folder_path,"BestuurlijkeGebieden_2024.gpkg","provinciegebied")
with arcpy.da.SearchCursor(orig_path, ["naam", "code", "Shape@"]) as cursor1, arcpy.da.InsertCursor(FCL_path, ["NAAMOFFICIEEL", "NUMMER_CSV", "Shape@"]) as cursor2:
    for row in cursor1:
        cursor2.insertRow(row)
print("Feature class {0} has been copied.".format("Provinciegrenzen"))

# Domeinen instellen
# maak dictionaries met waarden en omschrijvingen
input_gdb = "{0}/{1}".format(out_folder_path, fgdb_out_name)

typeBosDomein = {"N14":"Vochtige bossen",
                    "N15":"Droge bossen",
                    "N16":"Bossen met productiefunctie",
                    "N17":"Cultuurhistorische bossen",
                    "ND":"Bossen zonder gedefinieerd natuurtype"}

typeCompensatieDomein = {"C1":"Geen compensatie",
                    "C2":"Compensatie ontbossing door natuuromvorming N2000 met terugwerkende kracht vanaf 2017",
                    "C3":"Compensatie overige ontbossing door natuuromvorming N2000",
                    "C4":"Wettelijke compensatie"}
                    
typeOmvormingDomein = {"O1":"Geen omvorming",
                    "O2":"Omvorming van bestaand bos (was al bos vóór 1-1-2021)",
                    "O3":"Omvorming van nieuw gerealiseerd bos (gerealiseerd na 1-1-2021 en vervolgens omgevormd)"}

redenEindeDomein = {"OmvormingBos":"Omvorming naar ander type bos",
                    "Natuurontwikkeling":"Omvorming naar ander type natuur",
                    "Overig":"Overig"}

wijzeCompensatieDomein = {"C1":"Geen compensatie",
                    "C2":"Compensatie ontbossing door natuuromvorming N2000 met terugwerkende kracht vanaf 2017",
                    "C3":"Compensatie overige ontbossing door natuuromvorming N2000",
                    "C4":"Wettelijke compensatie"}
                    
BronhouderDomein = {"20":"Groningen",
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

## aanmaken domeinen
print("Start creating domains...")
arcpy.CreateDomain_management(input_gdb, "domTypeBos", domain_description="Valide waarden provincie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domTypeCompensatie", domain_description="Valide waarden typeRegeling", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domTypeOmvorming", domain_description="Valide waarden provincie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domRedenEinde", domain_description="Valide waarden provincie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domWijzeCompensatie", domain_description="Valide waarden provincie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domBronhouder", domain_description="Valide waarden statusAanvraagSubsidie", field_type="TEXT", domain_type="CODED")
print("Domains have been created")

# waardes toevoegen aan domeinen
print("Adding values to domains...")
for code in typeBosDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domTypeBos", code, typeBosDomein[code])
for code in typeCompensatieDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domTypeCompensatie", code, typeCompensatieDomein[code])
for code in typeOmvormingDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domTypeOmvorming", code, typeOmvormingDomein[code])
for code in redenEindeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domRedenEinde", code, redenEindeDomein[code])
for code in wijzeCompensatieDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domWijzeCompensatie", code, wijzeCompensatieDomein[code])
for code in BronhouderDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domBronhouder", code, BronhouderDomein[code])
print("Values have been added to the domains")

# domeinen toekennen aan de juiste attributen
# [0] VoortgangProvincialeOpgaveBossenstrategie
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[0])
print("Assign domains to feature class {0}...".format(FC_list[0]))
arcpy.AssignDomainToField_management(FCL_path, "typeBos", "domTypeBos")
arcpy.AssignDomainToField_management(FCL_path, "typeCompensatie", "domTypeCompensatie")
arcpy.AssignDomainToField_management(FCL_path, "typeOmvorming", "domTypeOmvorming")
arcpy.AssignDomainToField_management(FCL_path, "redenEinde", "domRedenEinde")
arcpy.AssignDomainToField_management(FCL_path, "wijzeCompensatie", "domWijzeCompensatie")
print("Domains have been added to feature class {0}".format(FC_list[0]))

# [0] BossenstrategieRapportage
TB_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,TB_list[0])
print("Assign domains to table {0}...".format(TB_list[0]))
arcpy.AssignDomainToField_management(TB_path, "bronhouder", "domBronhouder")
print("Domains have been added to table {0}".format(TB_list[0]))

# instellen default waarden 
print("Assign default status values to table {0}...".format(TB_list[0]))
arcpy.AssignDefaultToField_management(TB_path, "rapportageJaar", 2024)
print("Default status values have been added to table {0}...".format(TB_list[0]))

# domeinwaarden sorteren in juiste volgorde
print("Sorting domain values in ascending order...")
arcpy.SortCodedValueDomain_management(input_gdb, "domTypeBos", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domTypeCompensatie", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domTypeOmvorming", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domRedenEinde", "DESCRIPTION", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domWijzeCompensatie", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domBronhouder", "CODE", "ASCENDING")
print("Domain values have been sorted in ascending order")

print("All domains have been added.")

print("--*END*--")
