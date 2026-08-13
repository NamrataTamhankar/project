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
out_folder_path = "C:/Arun/PythonScript/NDVH" 
fgdb_out_name = "NDVH_Habitat_template.gdb"
out_version = "10.0"
arcpy.env.overwriteOutput = True

# pad naar dataset provinciegrenzen
n2000_path = "C:/Arun/PythonScript/NDVH/N2000.gdb/Natura2000"
n2000Gebieden_path = "C:/Arun/PythonScript/NDVH/N2000.gdb/Natura2000Gebieden"
n2000Doelstellingen_path = "C:/Arun/PythonScript/NDVH/N2000.gdb/Natura2000Doelstellingen"

# featureclass variabelen en environment settings
DS_name = "IMNa"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
arcpy.env.XYResolution = "0.0005 Meters"
arcpy.env.XYTolerance = "0.001 Meters"
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
SR_name = arcpy.SpatialReference(28992)

FC_list = ["HabitatPackage", "Habitat", "Natura2000Gebieden"]
TB_list = ["TemplateVersie", "Natura2000", "Natura2000Doelstellingen"]

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
for fcl in FC_list:
    print ("Creating featureclass {0}...".format(fcl))
    arcpy.CreateFeatureclass_management(DS_path, fcl, geometry_type="POLYGON")
    print ("Featureclass {0} has been created.".format(fcl))

for tbl in TB_list:
    print ("Creating table {0}...".format(tbl))
    arcpy.CreateTable_management(input_gdb, tbl)
    print ("Table {0} has been created.".format(tbl))

# Toevoegen van de attribuutvelden aan de featureclasses
# [0] HabitatPackage
print ("Adding attributes to feature class {0}...".format(FC_list[0]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[0]))
arcpy.AddField_management(FCL_path, "beginTijd", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "eindTijd", "DATE", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "gebiedNummer", "SHORT", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "packageBronhouder", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(FCL_path, "packageInwinner", "TEXT", field_length=255, field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(FCL_path, "packageNaam", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(FCL_path, "packageToelichting", "TEXT", field_length=20000, field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "packageVersie", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(FCL_path, "methodiekDocumentVersie", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[0]))

# [1] Habitat
print ("Adding attributes to feature class {0}...".format(FC_list[1]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[1]))
arcpy.AddField_management(FCL_path, "identificatie", "TEXT", field_length=100, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "bron", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "veldSituatieDatum", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "opmerkingen", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType1", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit1", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte1", "LONG", field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage1", "SHORT", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking1", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType2", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit2", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte2", "LONG", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage2", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking2", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType3", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit3", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte3", "LONG", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage3", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking3", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType4", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit4", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte4", "LONG", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage4", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking4", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType5", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit5", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte5", "LONG", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage5", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking5", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType6", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit6", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte6", "LONG", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage6", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking6", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[1]))

# Toevoegen van de attribuutvelden aan de tabellen
# [0] TemplateVersie
print ("Adding attributes to table {0}...".format(TB_list[0]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[0]))
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=10, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "datumCreatie", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "releaseNotes", "TEXT", field_length=20000, field_is_nullable="NON_NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "datumCreatie", "releaseNotes"]) as cursor:
    cursor.insertRow(["v2021.1.1", "13/04/2021", "Template created for submission of Habitat data"])
    cursor.insertRow(["v2021.1.2", "30/06/2021", "Fixed issue with script"])
    cursor.insertRow(["v2021.1.3", "09/07/2021", "Changed domain bronhouder from text to integer"])
    cursor.insertRow(["v2021.1.4", "03/08/2021", "Removed domains with variants"])
    cursor.insertRow(["v2021.1.5", "09/08/2021", "Removed packageVersie T1 and T2"])
    cursor.insertRow(["v2021.2.1", "25/08/2021", "Changed packageVersie, Kwaliteit and HabitatType domains for T1"])
    cursor.insertRow(["v2021.2.2", "26/08/2021", "Changed versioning in TemplateVersie"])
print ("Added attributes to table {0}.".format(TB_list[0]))

# kopiëren van de Natura2000 uit de oude template
# [2] Natura2000Gebieden
print("Copy feature class {0} from template...".format(FC_list[2]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[2]))
arcpy.CopyFeatures_management(n2000Gebieden_path, FCL_path)
print("Feature class {0} copied from template.".format(FC_list[2]))

# [1] Natura2000
print("Copy attribute class {0} from template...".format(TB_list[1]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[1]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(TB_list[1]))
arcpy.Copy_management(n2000_path, TBL_path)
print("Attribute class {0} copied from  template.".format(TB_list[1]))

# [2] Natura2000Doelstellingen
print("Copy attribute class {0} from template...".format(TB_list[2]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[2]))
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,(TB_list[2]))
arcpy.Copy_management(n2000Doelstellingen_path, TBL_path)
print("Attribute class {0} copied from  template.".format(TB_list[2]))

# Domeinen instellen
PackageBronhouderDomein = {"21":"provincie Fryslân",
                        "22":"provincie Drenthe",
                        "24":"provincie Flevoland",
                        "25":"provincie Gelderland",
                        "20":"provincie Groningen",
                        "31":"provincie Limburg",
                        "30":"provincie Noord-Brabant",
                        "27":"provincie Noord-Holland",
                        "23":"provincie Overijssel",
                        "26":"provincie Utrecht",
                        "29":"provincie Zeeland",
                        "28":"provincie Zuid-Holland",
                        "51":"ministerie van Defensie",
                        "52":"ministerie van Infrastructuur en Waterstaat",
                        "53":"ministerie van Landbouw, Natuur en Voedselkwaliteit"}

PackageVersieDomein =  {"T1":"12 jaar na aanwijzing"}

MethodiekDocumentVersieDomein = {"1":"16 september 2015",
                            "2":"20 mei 2018"}

KwaliteitDomein = {"G":"Goed",
                "M":"Matig"}

HabitatTypeDomein = {"H1330A":"Schorren en zilte graslanden (buitendijks)",
				"H6120":"Stroomdalgraslanden",
				"H1110B":"Permanent overstroomde zandbanken (Noordzee-kustzone)",
				"H2160":"Duindoornstruwelen",
				"H2190B":"Vochtige duinvalleien (kalkrijk)",
				"H2320":"Binnenlandse kraaiheibegroeiingen",
				"H2190C":"Vochtige duinvalleien (ontkalkt)",
				"H1140B":"Slik- en zandplaten (Noordzee-kustzone)",
				"H91D0":"Hoogveenbossen",
				"H7110":"Actieve hoogvenen",
				"H91F0":"Droge hardhoutooibossen",
				"H2140":"Duinheiden met kraaihei",
				"H7110B":"Actieve hoogvenen (heideveentjes)",
				"H6110":"Pionierbegroeiingen op rotsbodem",
				"H91E0A":"Vochtige alluviale bossen (zachthoutooibossen)",
				"H6130":"Zinkweiden",
				"H1310":"Zilte pionierbegroeiingen",
				"H6510":"Glanshaver- en vossenstaarthooilanden",
				"H2310":"Stuifzandheiden met struikhei",
				"H9160":"Eiken-haagbeukenbossen",
				"H2180":"Duinbossen",
				"H7210":"Galigaanmoerassen",
				"H7110A":"Actieve hoogvenen (hoogveenlandschap)",
				"H1160":"Grote baaien",
				"H6230":"Heischrale graslanden",
				"H91E0C":"Vochtige alluviale bossen (beekbegeleidende bossen)",
				"H1110":"Permanent overstroomde zandbanken",
				"H2180A":"Duinbossen (droog)",
				"H2190A":"Vochtige duinvalleien (open water)",
				"H2140B":"Duinheiden met kraaihei (droog)",
				"H2140A":"Duinheiden met kraaihei (vochtig)",
				"H6430A":"Ruigten en zomen (moerasspirea)",
				"H2130A":"Grijze duinen (kalkrijk)",
				"H2170":"Kruipwilgstruwelen",
				"H1110A":"Permanent overstroomde zandbanken (getijdengebied)",
				"H3130":"Zwakgebufferde vennen",
				"H2120":"Witte duinen",
				"H1330":"Schorren en zilte graslanden",
				"H9190":"Oude eikenbossen",
				"H7150":"Pioniervegetaties met snavelbiezen",
				"H2330":"Zandverstuivingen",
				"H6210":"Kalkgraslanden",
				"H1140":"Slik- en zandplaten",
				"H7220":"Kalktufbronnen",
				"H1130":"Estuaria",
				"H9160A":"Eiken-haagbeukenbossen (hogere zandgronden)",
				"H6430":"Ruigten en zomen",
				"H3270":"Slikkige rivieroevers",
				"H2150":"Duinheiden met struikhei",
				"H3260B":"Beken en rivieren met waterplanten (grote fonteinkruiden)",
				"H6410":"Blauwgraslanden",
				"H2130B":"Grijze duinen (kalkarm)",
				"H5130":"Jeneverbesstruwelen",
				"H6430C":"Ruigten en zomen (droge bosranden)",
				"H9120":"Beuken-eikenbossen met hulst",
				"H91E0B":"Vochtige alluviale bossen (essen-iepenbossen)",
				"H0000":"Afwezig",
				"H6430B":"Ruigten en zomen (harig wilgenroosje)",
				"H2180B":"Duinbossen (vochtig)",
				"H4010":"Vochtige heiden",
				"H6510B":"Glanshaver- en vossenstaarthooilanden (grote vossenstaart)",
				"H1140A":"Slik- en zandplaten (getijdengebied)",
				"H2180C":"Duinbossen (binnenduinrand)",
				"H3140":"Kranswierwateren",
				"H1310B":"Zilte pionierbegroeiingen (zeevetmuur)",
				"H1330B":"Schorren en zilte graslanden (binnendijks)",
				"H2110":"Embryonale duinen",
				"H4030":"Droge heiden",
				"H9999":"Aanwezig",
				"H2190":"Vochtige duinvalleien",
				"H4010A":"Vochtige heiden (hogere zandgronden)",
				"H2190D":"Vochtige duinvalleien (hoge moerasplanten)",
				"H9110":"Veldbies-beukenbossen",
				"H91E0":"Vochtige alluviale bossen",
				"H1170":"Riffen van open zee",
				"H2130":"Grijze duinen (heischraal)",
				"H9130":"Asperulo-Fagetum beech forests",
				"H3150":"Meren met krabbenscheer en fonteinkruiden",
				"H7140B":"Overgangs- en trilvenen (veenmosrietlanden)",
				"H9150":"Limestone beech forests of the Cephalanthero-Fagion",
				"H7120":"Herstellende hoogvenen",
				"H6510A":"Glanshaver- en vossenstaarthooilanden (glanshaver)",
				"H3260A":"Beken en rivieren met waterplanten (waterranonkels)",
				"H1110C":"Permanent overstroomde zandbanken (zuidelijke Noordzee)",
				"H7140A":"Overgangs- en trilvenen (trilvenen)",
				"H3160":"Zure vennen",
				"H3260":"Beken en rivieren met waterplanten",
				"H2130C":"Grijze duinen (heischraal)",
				"H7140":"Overgangs- en trilvenen",
				"H1310A":"Zilte pionierbegroeiingen (zeekraal)",
				"H3110":"Zeer zwakgebufferde vennen",
				"H9160B":"Eiken-haagbeukenbossen (heuvelland)",
				"H7230":"Kalkmoerassen",
				"H4010B":"Vochtige heiden (laagveengebied)",
				"H1320":"Slijkgrasvelden"}
          
## aanmaken domeinen
print("Start creating domains...")
arcpy.CreateDomain_management(input_gdb, "domPackageBronhouder", domain_description="Valide waarden packageBronhouder", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domPackageVersie", domain_description="Valide waarden packageVersie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domMethodiekDocumentVersie", domain_description="Valide waarden methodiekDocumentVersie", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domHabitatType", domain_description="Valide waarden habitatType", field_type="TEXT", domain_type="CODED")
arcpy.CreateDomain_management(input_gdb, "domKwaliteit", domain_description="Valide waarden kwaliteit", field_type="TEXT", domain_type="CODED")
print("Domains have been created")

# waardes toevoegen aan domeinen
print("Adding values to domains...")
for code in PackageBronhouderDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domPackageBronhouder", code, PackageBronhouderDomein[code])
for code in PackageVersieDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domPackageVersie", code, PackageVersieDomein[code])
for code in MethodiekDocumentVersieDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domMethodiekDocumentVersie", code, MethodiekDocumentVersieDomein[code])
for code in HabitatTypeDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domHabitatType", code, HabitatTypeDomein[code])
for code in KwaliteitDomein:
    arcpy.AddCodedValueToDomain_management(input_gdb, "domKwaliteit", code, KwaliteitDomein[code])
print("Values have been added to the domains")

# domeinen toekennen aan de juiste attributen
# [0] HabitatPackage
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[0])
print("Assign domains to feature class {0}...".format(FC_list[0]))
arcpy.AssignDomainToField_management(FCL_path, "packageBronhouder", "domPackageBronhouder")
arcpy.AssignDomainToField_management(FCL_path, "packageVersie", "domPackageVersie")
arcpy.AssignDomainToField_management(FCL_path, "methodiekDocumentVersie", "domMethodiekDocumentVersie")
print("Domains have been added to feature class {0}".format(FC_list[0]))

# [1] Habitat
FCL_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,FC_list[1])
print("Assign domains to feature class {0}...".format(FC_list[1]))
arcpy.AssignDomainToField_management(FCL_path, "habitatType1", "domHabitatType")
arcpy.AssignDomainToField_management(FCL_path, "kwaliteit1", "domKwaliteit")
arcpy.AssignDomainToField_management(FCL_path, "habitatType2", "domHabitatType")
arcpy.AssignDomainToField_management(FCL_path, "kwaliteit2", "domKwaliteit")
arcpy.AssignDomainToField_management(FCL_path, "habitatType3", "domHabitatType")
arcpy.AssignDomainToField_management(FCL_path, "kwaliteit3", "domKwaliteit")
arcpy.AssignDomainToField_management(FCL_path, "habitatType4", "domHabitatType")
arcpy.AssignDomainToField_management(FCL_path, "kwaliteit4", "domKwaliteit")
arcpy.AssignDomainToField_management(FCL_path, "habitatType5", "domHabitatType")
arcpy.AssignDomainToField_management(FCL_path, "kwaliteit5", "domKwaliteit")
arcpy.AssignDomainToField_management(FCL_path, "habitatType6", "domHabitatType")
arcpy.AssignDomainToField_management(FCL_path, "kwaliteit6", "domKwaliteit")
print("Domains have been added to feature class {0}".format(FC_list[1]))

# domeinwaarden sorteren in juiste volgorde
print("Sorting domain values in ascending order...")
arcpy.SortCodedValueDomain_management(input_gdb, "domPackageBronhouder", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domPackageVersie", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domMethodiekDocumentVersie", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domHabitatType", "CODE", "ASCENDING")
arcpy.SortCodedValueDomain_management(input_gdb, "domKwaliteit", "CODE", "ASCENDING")
print("Domain values have been sorted in ascending order")

print("All domains have been added.")

print("--*END*--")
