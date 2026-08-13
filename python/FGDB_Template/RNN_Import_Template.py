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
out_folder_path = "C:/Users/A839431/Desktop/RNN" 
fgdb_out_name = "RNN_Import_Template.gdb"
out_version = "10.0"
arcpy.env.overwriteOutput = True

# featureclass variabelen en environment settings
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
arcpy.env.XYResolution = "0.0005 Meters"
arcpy.env.XYTolerance = "0.001 Meters"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
SR_name = arcpy.SpatialReference(28992)

FC_list = ["BeheerGebied", "BeoordelingsGebied", "WaarnemingFloraEnFauna", "WaarnemingStandplaatsFactoren"]
TB_list = ["Dossier", "ExpertOordeel", "VersieLog"]


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
    DS_path = "{0}/{1}".format(out_folder_path,fgdb_out_name)
else:
    # Aanmaken FGDB zonder timestamp
    print ("No previous versions found. Creating file geodatabase with name {0}...".format(fgdb_out_name))
    arcpy.CreateFileGDB_management(out_folder_path, fgdb_out_name, out_version)
    print("File geodatabase with name {0} has been created.".format(fgdb_out_name))
    input_gdb = "{0}/{1}".format(out_folder_path,fgdb_out_name)
    DS_path = "{0}/{1}".format(out_folder_path,fgdb_out_name)

# Featureclasses aanmaken 
arcpy.CreateFeatureclass_management(DS_path, FC_list[0], geometry_type="POLYGON")
print ("Featureclass {0} has been created.".format(FC_list[0]))
arcpy.CreateFeatureclass_management(DS_path, FC_list[1], geometry_type="POLYGON")
print ("Featureclass {0} has been created.".format(FC_list[1]))
arcpy.CreateFeatureclass_management(DS_path, FC_list[2], geometry_type="POINT")
print ("Featureclass {0} has been created.".format(FC_list[2]))
arcpy.CreateFeatureclass_management(DS_path, FC_list[3], geometry_type="POLYGON")
print ("Featureclass {0} has been created.".format(FC_list[3]))


for tbl in TB_list:
    print ("Creating table {0}...".format(tbl))
    arcpy.CreateTable_management(input_gdb, tbl)
    print ("Table {0} has been created.".format(tbl))
    
# Toevoegen van de attribuutvelden aan de featureclasses
# [0] BeheerGebied 
print ("Adding attributes to feature class {0}...".format(FC_list[0]))
FCL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(FC_list[0]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beheertype", "TEXT",  field_length=20, field_is_nullable="NON_NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[0]))

# [3] BeoordelingsGebied 
print ("Adding attributes to feature class {0}...".format(FC_list[1]))
FCL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(FC_list[1]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "gebiedsNaam", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "beschrijving", "TEXT", field_length=1000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bronhouder", "TEXT", field_length=20, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[1]))

# [5] WaarnemingFloraEnFauna 
print ("Adding attributes to feature class {0}...".format(FC_list[2]))
FCL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(FC_list[2]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "soort", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "soortGroep", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "objectBeginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "objectEindTijd", "DATE", field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[2]))

# [6] WaarnemingStandplaatsFactoren
print ("Adding attributes to feature class {0}...".format(FC_list[3]))
FCL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(FC_list[3]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "gemiddeldeVoorjaarsGrondwaterstand", "DOUBLE", field_precision=10, field_scale=3, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "gemiddeldeVoorjaarsGrondwaterstandOpmerking", "TEXT", field_length=255, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "gemiddeldeLaagsteGrondwaterstand", "DOUBLE", field_precision=10, field_scale=3, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "gemiddeldeLaagsteGrondwaterstandOpmerking", "TEXT", field_length=255, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "pH", "DOUBLE", field_precision=10, field_scale=3, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "pHOpmerking", "TEXT", field_length=255, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "trofie", "DOUBLE", field_precision=10, field_scale=3, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "trofieOpmerking", "TEXT", field_length=255, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[3]))

# Toevoegen van de attribuutvelden aan de tabellen
# [0] Dossier
print ("Adding attributes to table {0}...".format(TB_list[0]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[0]))
arcpy.AddField_management(TBL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "dossierNaam", "TEXT", field_length=255, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "beschikkingsJaar", "LONG", field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "vegetatiekarteringsJaar", "LONG", field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "beoordelaar", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "eigenaar", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "objectBeginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "objectEindTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "toelichting", "TEXT", field_length=1000, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "beoordelingsGebiedIdentificatie", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE")
print ("Added attributes to table {0}.".format(TB_list[0]))

# [3] ExpertOordeel
print ("Adding attributes to table {0}...".format(TB_list[1]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[1]))
arcpy.AddField_management(TBL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "floraEnFaunaExpertOordeel", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "floraEnFaunaOpmerking", "TEXT", field_length=200, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "standplaatsFactorExpertOordeel", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "standplaatsFactorOpmerking", "TEXT", field_length=200, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "ruimtelijkeConditieExpertOordeel", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "ruimtelijkeConditieOpmerking", "TEXT", field_length=200, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "structuurkenmerkenExpertOordeel", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "structuurkenmerkenOpmerking", "TEXT", field_length=200, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "natuurlijkheidExpertOordeel", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(TBL_path, "natuurlijkheidOpmerking", "TEXT", field_length=200, field_is_nullable="NULLABLE")
print ("Added attributes to table {0}.".format(TB_list[1]))

# [4] VersieLog
print ("Adding attributes to table {0}...".format(TB_list[2]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[2]))
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=50, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "uitgaveDatum", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "uitgaveOpmerkingen", "TEXT", field_length=50, field_is_nullable="NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "uitgaveDatum", "uitgaveOpmerkingen"]) as cursor:
     cursor.insertRow(["v2026.1", "03/06/2026", "RNN-3218 Add .fgdb as an import file"]) 
print ("Added attributes to table {0}.".format(TB_list[2]))


#All done


print("--*END*--")
