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
out_folder_path = "C:/Projecten/IPO_FGDB/VRN" 
fgdb_ref_name = "VRN_referentiedata.gdb"
out_version = "10.0"
arcpy.env.overwriteOutput = True

# featureclass variabelen en environment settings
DS_ref_name = "Referentielagen"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
arcpy.env.XYResolution = "0.0005 Meters"
arcpy.env.XYTolerance = "0.001 Meters"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
SR_name = arcpy.SpatialReference(28992)

# Start werkproces
# FGDB aanmaken
fgdb_ref_path = "{0}/{1}".format(out_folder_path, fgdb_ref_name)
print ("Creating file geodatabase with name {0}...".format(fgdb_ref_name))
arcpy.CreateFileGDB_management(out_folder_path, fgdb_ref_name, out_version)
print ("File geodatabase with name {0} has been created.".format(fgdb_ref_name))
DS_ref_path = "{0}/{1}".format(fgdb_ref_path, DS_ref_name)

# referentie dataset
out_sr = arcpy.CreateSpatialReference_management(SR_name)
print ("Creating dataset with name {0}...".format(DS_ref_name))
arcpy.CreateFeatureDataset_management(fgdb_ref_path,DS_ref_name,out_sr)
print ("Dataset with name {0} has been created.".format(DS_ref_name))

# BeheerGebied Agrarisch
print("Copy features BeheerGebied Agrarisch...")
arcpy.CreateFeatureclass_management(DS_ref_path, "BeheergebiedAgrarisch", geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_ref_name,DS_ref_name,"BeheergebiedAgrarisch")
arcpy.AddField_management(FCL_path, "provincie", "TEXT", field_length=200)
arcpy.AddField_management(FCL_path, "beheerType", "TEXT", field_length=200)
orig_path = "{0}/{1}/{2}/{3}".format(out_folder_path,"IMNA_NBP_2019_2019_04_18.gdb","IMNa","BeheerGebied")
with arcpy.da.SearchCursor(orig_path, ["Provincie", "BeheerType", "Shape@"]) as cursor1, arcpy.da.InsertCursor(FCL_path, ["provincie", "beheerType", "Shape@"]) as cursor2:
    for row in cursor1:
        if row[1][:1] == 'A':
            cursor2.insertRow(row)
print("Features BeheerGebied Agrarisch have been copied")

# BasisregistratieGewaspercelen
print("Copy feature class BasisregistratieGewaspercelen...")
arcpy.CreateFeatureclass_management(DS_ref_path, "BasisregistratieGewaspercelen", geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_ref_name,DS_ref_name,"BasisregistratieGewaspercelen")
arcpy.AddField_management(FCL_path, "CAT_GEWASCATEGORIE", "TEXT", field_length=60)
arcpy.AddField_management(FCL_path, "GWS_GEWASCODE", "TEXT", field_length=10)
arcpy.AddField_management(FCL_path, "GWS_GEWAS", "TEXT", field_length=255)
orig_path = "{0}/{1}/{2}".format(out_folder_path,"BRP_Gewaspercelen_2019_concept.gdb","BRP_gewaspercelen_2019_concept")
with arcpy.da.SearchCursor(orig_path, ["CAT_GEWASCATEGORIE", "GWS_GEWASCODE", "GWS_GEWAS", "Shape@"]) as cursor1, arcpy.da.InsertCursor(FCL_path, ["CAT_GEWASCATEGORIE", "GWS_GEWASCODE", "GWS_GEWAS", "Shape@"]) as cursor2:
    for row in cursor1:
        if row[1] not in ["332", "335"]:
            cursor2.insertRow(row)
print("Feature class BasisregistratieGewaspercelen has been copied.")

# NadereUitwerkingRivierengebied
print("Copy feature class NadereUitwerkingRivierengebied...")
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_ref_name,DS_ref_name,"NadereUitwerkingRivierengebied")
orig_path = "{0}/{1}/{2}".format(out_folder_path,"NURG_rapportage1jan2019.gdb","NURGbronbestand1jan2019")
arcpy.CopyFeatures_management(orig_path, FCL_path)
print("Feature class NadereUitwerkingRivierengebied has been copied.")

# WaterstaatwerkWaterdeel
print("Copy feature class WaterstaatwerkWaterdeel...")
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_ref_name,DS_ref_name,"WaterstaatwerkWaterdeel")
orig_path = "{0}/{1}/{2}".format(out_folder_path,"20170501_Rijkswateren_VRN.gdb","waterstaatswerk_waterdeel")
arcpy.CopyFeatures_management(orig_path, FCL_path)
print("Feature class WaterstaatwerkWaterdeel has been copied.")

# TemplateVersie
print ("Create table {0}...".format("TemplateVersie"))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_ref_name,("TemplateVersie"))
arcpy.CreateTable_management(fgdb_ref_path, "TemplateVersie")
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=5, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "datumCreatie", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "releaseNotes", "TEXT", field_length=20000, field_is_nullable="NON_NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "datumCreatie", "releaseNotes"]) as cursor:
    cursor.insertRow(["4", "17/03/2020", "Template version edit"])
print ("Added attributes to table {0}.".format("TemplateVersie"))

print("--*END*--")