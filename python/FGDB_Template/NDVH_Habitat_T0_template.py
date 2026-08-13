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
out_folder_path = "C:/Naveen/PythonScript/NDVH" 
fgdb_out_name = "NDVH_Habitat_template_T0.gdb"
out_version = "10.0"
arcpy.env.overwriteOutput = True

# pad naar dataset provinciegrenzen
n2000_path = "C:/Naveen/PythonScript/NDVH/N2000_Test.gdb/Natura2000"
n2000Gebieden_path = "C:/Naveen/PythonScript/NDVH/N2000_Test.gdb/Natura2000Gebieden"
n2000Doelstellingen_path = "C:/Naveen/PythonScript/NDVH/N2000_Test.gdb/Natura2000Doelstellingen"

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
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte1", "DOUBLE", field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage1", "SHORT", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking1", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType2", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit2", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte2", "DOUBLE", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage2", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking2", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType3", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit3", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte3", "DOUBLE", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage3", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking3", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType4", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit4", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte4", "DOUBLE", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage4", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking4", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType5", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit5", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte5", "DOUBLE", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage5", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking5", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "habitatType6", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "kwaliteit6", "TEXT", field_length=20, field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "bedekkingsOppervlakte6", "DOUBLE", field_is_nullable="NULLABLE") 
arcpy.AddField_management(FCL_path, "bedekkingsPercentage6", "SHORT", field_is_nullable="NULLABLE")
arcpy.AddField_management(FCL_path, "opmerking6", "TEXT", field_length=20000, field_is_nullable="NULLABLE")
print ("Added attributes to feature class {0}.".format(FC_list[1]))

# Toevoegen van de attribuutvelden aan de tabellen
# [0] TemplateVersie
print ("Adding attributes to table {0}...".format(TB_list[0]))
TBL_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,(TB_list[0]))
arcpy.AddField_management(TBL_path, "versie", "TEXT", field_length=10, field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "packageVersie", "TEXT", field_length=20, field_is_nullable="NON_NULLABLE") 
arcpy.AddField_management(TBL_path, "datumCreatie", "DATE", field_is_nullable="NON_NULLABLE")
arcpy.AddField_management(TBL_path, "releaseNotes", "TEXT", field_length=20000, field_is_nullable="NON_NULLABLE")
with arcpy.da.InsertCursor(TBL_path, ["versie", "packageVersie", "datumCreatie", "releaseNotes"]) as cursor:
    cursor.insertRow(["v2021.1", "T0", "13/04/2021", "Template created for submission of Habitat data"])
    cursor.insertRow(["v2021.2", "T0", "30/06/2021", "Fixed issue with script"])
    cursor.insertRow(["v2021.3", "T0", "09/07/2021", "Changed domain bronhouder from text to integer"])
    cursor.insertRow(["v2021.4", "T0", "03/08/2021", "Removed domains with variants"])
    cursor.insertRow(["v2021.5", "T0", "09/08/2021", "Removed packageVersie T1 and T2"])
    cursor.insertRow(["v2021.1.6", "T0", "06/10/2021", "Removed main types when sub types exists from HabitatType domain"])
    cursor.insertRow(["v2021.1.7", "T0", "10/11/2021", "Created with modified data of n2000 of Citrix"])
    cursor.insertRow(["v2021.1.8", "T0", "10/11/2021", "Created with data of n2000 of Acceptance"])
    cursor.insertRow(["v2022.1.1", "T0", "18/01/2022", "Added packageVersie attribute to TemplateVersie table"])
    cursor.insertRow(["v2022.1.2", "T0", "19/04/2022", "Changed data type of bedekkingsOppervlakteX from Long to Double"])
    cursor.insertRow(["v2022.1.3", "T0", "24/08/2022", "Imna-7599 Created with modified data of n2000 of Citrix"])
    cursor.insertRow(["v2022.1.4", "T0", "04/10/2022", "Imna-7861 Created with modified data of n2000 of Acc"])
    cursor.insertRow(["v2022.1.5", "T0", "19/10/2022", "Imna-7873 Created with modified data of n2000 of Prod"])
    cursor.insertRow(["v2023.1.1", "T0", "19/07/2023", "Imna-10276 and Imna-10279  Change DomainHabitattypen value for H9999 and change the definition of T0"])
    cursor.insertRow(["v2023.1.2", "T0", "10/08/2023", "Imna-11247 and Imna-10276  Setting the updated N2000 data and Change DomainHabitattypen value for H9999"])
    cursor.insertRow(["v2023.1.3", "T0", "06/09/2023", "Imna-10402 and Imna-10270  Add quality label NVT for T0 maps and Change the description value for DomainHabitattypen if the corresponding code starts with ZGH"])

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

PackageVersieDomein =  {"T0":"situatie rond het aanwijzingsbesluit"}

MethodiekDocumentVersieDomein = {"1":"16 september 2015",
                            "2":"20 mei 2018"}

KwaliteitDomein = {"G":"Goed",
                "M":"Matig",
                "NB":"Onbekend",
                "NVT":"Niet van toepassing"}

HabitatTypeDomein = {"ZGH3160":"[Zoekgebied] Zure vennen",
                "H2190A":"Vochtige duinvalleien (open water)",
                "H6430B":"Ruigten en zomen (harig wilgenroosje)",
                "H91E0B":"Vochtige alluviale bossen (essen-iepenbossen)",
                "H2330":"Zandverstuivingen",
                "ZGH6210":"[Zoekgebied] Kalkgraslanden",
                "ZGH7140":"[Zoekgebied] Overgangs- en trilvenen",
                "ZGH2130C":"[Zoekgebied] Grijze duinen (heischraal)",
                "ZGH1310":"[Zoekgebied] Zilte pionierbegroeiingen",
                "H1310B":"Zilte pionierbegroeiingen (zeevetmuur)",
                "ZGH7120":"[Zoekgebied] Herstellende hoogvenen",
                "H7110A":"Actieve hoogvenen (hoogveenlandschap)",
                "H9160A":"Eiken-haagbeukenbossen (hogere zandgronden)",
                "ZGH9130":"[Zoekgebied] Asperulo-Fagetum beech forests",
                "ZGH6430B":"[Zoekgebied] Ruigten en zomen (harig wilgenroosje)",
                "H1140A":"Slik- en zandplaten (getijdengebied)",
                "H2130B":"Grijze duinen (kalkarm)",
                "ZGH2110":"[Zoekgebied] Embryonale duinen",
                "ZGH2130A":"[Zoekgebied] Grijze duinen (kalkrijk)",
				"ZGH9160A":"[Zoekgebied] Eiken-haagbeukenbossen (hogere zandgronden)",
				"ZGH4010":"[Zoekgebied] Vochtige heiden",
				"H9150":"Limestone beech forests of the Cephalanthero-Fagion",
				"ZGH7140B":"[Zoekgebied] Overgangs- en trilvenen (veenmosrietlanden)",
				"H2130A":"Grijze duinen (kalkrijk)",
				"H3260B":"Beken en rivieren met waterplanten (grote fonteinkruiden)",
				"ZGH2140A":"[Zoekgebied] Duinheiden met kraaihei (vochtig)",
				"ZGH1110C":"[Zoekgebied] Permanent overstroomde zandbanken (zuidelijke Noordzee)",
				"H5130":"Jeneverbesstruwelen",
				"H7150":"Pioniervegetaties met snavelbiezen",
				"ZGH2130":"[Zoekgebied] Grijze duinen (heischraal)",
				"ZGH7150":"[Zoekgebied] Pioniervegetaties met snavelbiezen",
				"ZGH1140":"[Zoekgebied] Slik- en zandplaten",
				"H6230":"Heischrale graslanden",
				"ZGH2170":"[Zoekgebied] Kruipwilgstruwelen",
				"ZGH3110":"[Zoekgebied] Zeer zwakgebufferde vennen",
				"H7120":"Herstellende hoogvenen",
				"H6430C":"Ruigten en zomen (droge bosranden)",
				"H1110B":"Permanent overstroomde zandbanken (Noordzee-kustzone)",
				"ZGH2330":"[Zoekgebied] Zandverstuivingen",
				"H7110B":"Actieve hoogvenen (heideveentjes)",
				"ZGH91D0":"[Zoekgebied] Hoogveenbossen",
				"H1170":"Riffen van open zee",
				"H6130":"Zinkweiden",
				"H2320":"Binnenlandse kraaiheibegroeiingen",
				"ZGH6510B":"[Zoekgebied] Glanshaver- en vossenstaarthooilanden (grote vossenstaart)",
				"ZGH91F0":"[Zoekgebied] Droge hardhoutooibossen",
				"ZGH2190D":"[Zoekgebied] Vochtige duinvalleien (hoge moerasplanten)",
				"H9110":"Veldbies-beukenbossen",
				"ZGH2180C":"[Zoekgebied] Duinbossen (binnenduinrand)",
				"ZGH3260A":"[Zoekgebied] Beken en rivieren met waterplanten (waterranonkels)",
				"H9130":"Asperulo-Fagetum beech forests",
				"ZGH9110":"[Zoekgebied] Veldbies-beukenbossen",
				"H7220":"Kalktufbronnen",
				"ZGH4010A":"[Zoekgebied] Vochtige heiden (hogere zandgronden)",
				"H4010B":"Vochtige heiden (laagveengebied)",
				"H2130C":"Grijze duinen (heischraal)",
				"H6110":"Pionierbegroeiingen op rotsbodem",
				"ZGH2190B":"[Zoekgebied] Vochtige duinvalleien (kalkrijk)",
				"H7230":"Kalkmoerassen",
				"ZGH9120":"[Zoekgebied] Beuken-eikenbossen met hulst",
				"H2150":"Duinheiden met struikhei",
				"ZGH2140":"[Zoekgebied] Duinheiden met kraaihei",
				"ZGH3260B":"[Zoekgebied] Beken en rivieren met waterplanten (grote fonteinkruiden)",
				"H7140B":"Overgangs- en trilvenen (veenmosrietlanden)",
				"H6510B":"Glanshaver- en vossenstaarthooilanden (grote vossenstaart)",
				"H2180A":"Duinbossen (droog)",
				"ZGH7110B":"[Zoekgebied] Actieve hoogvenen (heideveentjes)",
				"H1130":"Estuaria",
				"ZGH9160":"[Zoekgebied] Eiken-haagbeukenbossen",
				"H1330A":"Schorren en zilte graslanden (buitendijks)",
				"ZGH1320":"[Zoekgebied] Slijkgrasvelden",
				"ZGH6120":"[Zoekgebied] Stroomdalgraslanden",
				"ZGH7110A":"[Zoekgebied] Actieve hoogvenen (hoogveenlandschap)",
				"H2310":"Stuifzandheiden met struikhei",
				"H91D0":"Hoogveenbossen",
				"H1110C":"Permanent overstroomde zandbanken (zuidelijke Noordzee)",
				"ZGH2310":"[Zoekgebied] Stuifzandheiden met struikhei",
				"H3160":"Zure vennen",
				"H2120":"Witte duinen",
				"ZGH1110A":"[Zoekgebied] Permanent overstroomde zandbanken (getijdengebied)",
				"ZGH1310B":"[Zoekgebied] Zilte pionierbegroeiingen (zeevetmuur)",
				"ZGH1330B":"[Zoekgebied] Schorren en zilte graslanden (binnendijks)",
				"H3130":"Zwakgebufferde vennen",
				"ZGH3270":"[Zoekgebied] Slikkige rivieroevers",
				"ZGH1310A":"[Zoekgebied] Zilte pionierbegroeiingen (zeekraal)",
				"ZGH2150":"[Zoekgebied] Duinheiden met struikhei",
				"H2190D":"Vochtige duinvalleien (hoge moerasplanten)",
				"ZGH1140B":"[Zoekgebied] Slik- en zandplaten (Noordzee-kustzone)",
				"ZGH5130":"[Zoekgebied] Jeneverbesstruwelen",
				"ZGH1160":"[Zoekgebied] Grote baaien",
				"ZGH91E0B":"[Zoekgebied] Vochtige alluviale bossen (essen-iepenbossen)",
				"H2140A":"Duinheiden met kraaihei (vochtig)",
				"ZGH7220":"[Zoekgebied] Kalktufbronnen",
				"ZGH3140":"[Zoekgebied] Kranswierwateren",
				"H3270":"Slikkige rivieroevers",
				"H2190C":"Vochtige duinvalleien (ontkalkt)",
				"H1330B":"Schorren en zilte graslanden (binnendijks)",
				"H4010A":"Vochtige heiden (hogere zandgronden)",
				"ZGH1110":"[Zoekgebied] Permanent overstroomde zandbanken",
				"ZGH2190":"[Zoekgebied] Vochtige duinvalleien",
				"H91E0C":"Vochtige alluviale bossen (beekbegeleidende bossen)",
				"H2110":"Embryonale duinen",
				"ZGH91E0":"[Zoekgebied] Vochtige alluviale bossen",
				"H9160B":"Eiken-haagbeukenbossen (heuvelland)",
				"ZGH2130B":"[Zoekgebied] Grijze duinen (kalkarm)",
				"H6410":"Blauwgraslanden",
				"H6120":"Stroomdalgraslanden",
				"H7210":"Galigaanmoerassen",
				"H9120":"Beuken-eikenbossen met hulst",
				"ZGH4010B":"[Zoekgebied] Vochtige heiden (laagveengebied)",
				"H2190B":"Vochtige duinvalleien (kalkrijk)",
				"ZGH1110B":"[Zoekgebied] Permanent overstroomde zandbanken (Noordzee-kustzone)",
				"H3140":"Kranswierwateren",
				"ZGH6510":"[Zoekgebied] Glanshaver- en vossenstaarthooilanden",
				"ZGH2180B":"[Zoekgebied] Duinbossen (vochtig)",
				"H2160":"Duindoornstruwelen",
				"H1110A":"Permanent overstroomde zandbanken (getijdengebied)",
				"ZGH6110":"[Zoekgebied] Pionierbegroeiingen op rotsbodem",
				"H2180B":"Duinbossen (vochtig)",
				"ZGH91E0A":"[Zoekgebied] Vochtige alluviale bossen (zachthoutooibossen)",
				"H91E0A":"Vochtige alluviale bossen (zachthoutooibossen)",
				"ZGH1130":"[Zoekgebied] Estuaria",
				"ZGH3260":"[Zoekgebied] Beken en rivieren met waterplanten",
				"ZGH9150":"[Zoekgebied] Limestone beech forests of the Cephalanthero-Fagion",
				"ZGH7230":"[Zoekgebied] Kalkmoerassen",
				"ZGH1330":"[Zoekgebied] Schorren en zilte graslanden",
				"ZGH1140A":"[Zoekgebied] Slik- en zandplaten (getijdengebied)",
				"H7140A":"Overgangs- en trilvenen (trilvenen)",
				"H1160":"Grote baaien",
				"ZGH7210":"[Zoekgebied] Galigaanmoerassen",
				"H3150":"Meren met krabbenscheer en fonteinkruiden",
				"ZGH7140A":"[Zoekgebied] Overgangs- en trilvenen (trilvenen)",
				"ZGH2180A":"[Zoekgebied] Duinbossen (droog)",
				"ZGH6430A":"[Zoekgebied] Ruigten en zomen (moerasspirea)",
				"H3260A":"Beken en rivieren met waterplanten (waterranonkels)",
				"ZGH4030":"[Zoekgebied] Droge heiden",
				"H3110":"Zeer zwakgebufferde vennen",
				"ZGH6130":"[Zoekgebied] Zinkweiden",
				"H4030":"Droge heiden",
				"ZGH9160B":"[Zoekgebied] Eiken-haagbeukenbossen (heuvelland)",
				"ZGH2320":"[Zoekgebied] Binnenlandse kraaiheibegroeiingen",
				"H2180C":"Duinbossen (binnenduinrand)",
				"H1140B":"Slik- en zandplaten (Noordzee-kustzone)",
				"H1320":"Slijkgrasvelden",
				"ZGH6410":"[Zoekgebied] Blauwgraslanden",
				"H6210":"Kalkgraslanden",
				"ZGH2120":"[Zoekgebied] Witte duinen",
				"ZGH3150":"[Zoekgebied] Meren met krabbenscheer en fonteinkruiden",
				"ZGH2180":"[Zoekgebied] Duinbossen",
				"ZGH7110":"[Zoekgebied] Actieve hoogvenen",
				"ZGH1330A":"[Zoekgebied] Schorren en zilte graslanden (buitendijks)",
				"H9190":"Oude eikenbossen",
				"H0000":"Afwezig",
				"H9999":"Mogelijk aanwezig",
				"H6510A":"Glanshaver- en vossenstaarthooilanden (glanshaver)",
				"ZGH6510A":"[Zoekgebied] Glanshaver- en vossenstaarthooilanden (glanshaver)",
				"ZGH91E0C":"[Zoekgebied] Vochtige alluviale bossen (beekbegeleidende bossen)",
				"H2140B":"Duinheiden met kraaihei (droog)",
				"ZGH6430C":"[Zoekgebied] Ruigten en zomen (droge bosranden)",
				"ZGH2190C":"[Zoekgebied] Vochtige duinvalleien (ontkalkt)",
				"H6430A":"Ruigten en zomen (moerasspirea)",
				"ZGH2140B":"[Zoekgebied] Duinheiden met kraaihei (droog)",
				"ZGH9190":"[Zoekgebied] Oude eikenbossen",
				"H91F0":"Droge hardhoutooibossen",
				"ZGH2190A":"[Zoekgebied] Vochtige duinvalleien (open water)",
				"ZGH6230":"[Zoekgebied] Heischrale graslanden",
				"H1310A":"Zilte pionierbegroeiingen (zeekraal)",
				"ZGH2160":"[Zoekgebied] Duindoornstruwelen",
				"ZGH3130":"[Zoekgebied] Zwakgebufferde vennen",
				"ZGH1170":"[Zoekgebied] Riffen van open zee",
				"H2170":"Kruipwilgstruwelen",
				"ZGH6430":"[Zoekgebied] Ruigten en zomen"}
          
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
