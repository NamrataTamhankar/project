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
fgdb_out_name = "NDVH_Habitat_template_Tx.gdb"
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
    cursor.insertRow(["v2021.6", "T1", "25/08/2021", "Template created for T1 from T0. Changed packageVersie, Kwaliteit and HabitatType domains for T1"])
    cursor.insertRow(["v2021.2.2", "T1", "26/08/2021", "Changed versioning in TemplateVersie"])
    cursor.insertRow(["v2021.2.3", "T1", "06/10/2021", "Removed main types when sub types exists from HabitatType domain"])
    cursor.insertRow(["v2021.2.4", "T1", "10/11/2021", "Created with modified data of n2000 of Citrix"])
    cursor.insertRow(["v2021.2.5", "T1", "10/11/2021", "Created with data of n2000 of Acceptance"])
    cursor.insertRow(["v2022.2.1", "T1", "18/01/2022", "Added packageVersie attribute to TemplateVersie table"])
    cursor.insertRow(["v2022.2.2", "T1", "19/04/2022", "Changed data type of bedekkingsOppervlakteX from Long to Double"])
    cursor.insertRow(["v2022.2.3", "T1", "24/08/2022", "Imna-7599 and 7190 Created with modified data of n2000 of Citrix and Added extra domain value in Kwaliteit N.v.t."])
    cursor.insertRow(["v2022.2.4", "T1", "04/10/2022", "Imna-7861 Created with modified data of n2000 of Acc and Added extra domain value in Kwaliteit N.v.t."])
    cursor.insertRow(["v2022.2.5", "T1", "19/10/2022", "Imna-7873 Created with modified data of n2000 of Prod"])
    cursor.insertRow(["v2023.2.1", "T1", "19/07/2023", "Imna-10276 and Imna-10279  Change DomainHabitattypen value for H9999 and change the definition of Tx"])
    cursor.insertRow(["v2023.2.2", "T1", "10/08/2023", "Imna-11247 and Imna-10276 Setting the updated N2000 data and Change DomainHabitattypen value for H9999"])
    cursor.insertRow(["v2024.2.1", "Tx", "06/08/2024", "IMNA-15698 Submit T2 Habitatkartering"])
    cursor.insertRow(["v2025.2.1", "Tx", "06/08/2026", "NDVH-4349 Update Natura 2000 Tx template"])
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

PackageVersieDomein =  {"T1":"nieuwe situatie na T0 op basis van geheel of gedeeltelijk nieuwe (karterings)gegevens",
                        "T2":"nieuwe situatie na T1 op basis van geheel of gedeeltelijk nieuwe (karterings)gegevens"}

MethodiekDocumentVersieDomein = {"1":"16 september 2015",
                            "2":"20 mei 2018"}

KwaliteitDomein = {"G":"Goed",
                "M":"Matig",
                "NVT":"Niet van toepassing"}

HabitatTypeDomein = {"H7150":"Pioniervegetaties met snavelbiezen",
			"H2180A":"Duinbossen (droog)",
			"H7210":"Galigaanmoerassen",
			"H3260A":"Beken en rivieren met waterplanten (waterranonkels)",
			"H2320":"Binnenlandse kraaiheibegroeiingen",
			"H7110B":"Actieve hoogvenen (heideveentjes)",
			"H2190C":"Vochtige duinvalleien (ontkalkt)",
			"H91E0B":"Vochtige alluviale bossen (essen-iepenbossen)",
			"H1110B":"Permanent overstroomde zandbanken (Noordzee-kustzone)",
			"H6210":"Kalkgraslanden",
			"H3110":"Zeer zwakgebufferde vennen",
			"H1110A":"Permanent overstroomde zandbanken (getijdengebied)",
			"H7140A":"Overgangs- en trilvenen (trilvenen)",
			"H5130":"Jeneverbesstruwelen",
			"H7140B":"Overgangs- en trilvenen (veenmosrietlanden)",
			"H2110":"Embryonale duinen",
			"H1330A":"Schorren en zilte graslanden (buitendijks)",
			"H6230":"Heischrale graslanden",
			"H7220":"Kalktufbronnen",
			"H91E0C":"Vochtige alluviale bossen (beekbegeleidende bossen)",
			"H9190":"Oude eikenbossen",
			"H1310B":"Zilte pionierbegroeiingen (zeevetmuur)",
			"H4030":"Droge heiden",
			"H1140B":"Slik- en zandplaten (Noordzee-kustzone)",
			"H2140B":"Duinheiden met kraaihei (droog)",
			"H9130":"Asperulo-Fagetum beech forests",
			"H6510B":"Glanshaver- en vossenstaarthooilanden (grote vossenstaart)",
			"H2180C":"Duinbossen (binnenduinrand)",
			"H3130":"Zwakgebufferde vennen",
			"H6430B":"Ruigten en zomen (harig wilgenroosje)",
			"H3160":"Zure vennen",
			"H2150":"Duinheiden met struikhei",
			"H1310A":"Zilte pionierbegroeiingen (zeekraal)",
			"H1160":"Grote baaien",
			"H6430A":"Ruigten en zomen (moerasspirea)",
			"H6510A":"Glanshaver- en vossenstaarthooilanden (glanshaver)",
			"H3260B":"Beken en rivieren met waterplanten (grote fonteinkruiden)",
			"H2170":"Kruipwilgstruwelen",
			"H3270":"Slikkige rivieroevers",
			"H9160A":"Eiken-haagbeukenbossen (hogere zandgronden)",
			"H2310":"Stuifzandheiden met struikhei",
			"H2190B":"Vochtige duinvalleien (kalkrijk)",
			"H2140A":"Duinheiden met kraaihei (vochtig)",
			"H2180B":"Duinbossen (vochtig)",
			"H2190A":"Vochtige duinvalleien (open water)",
			"H9999":"Mogelijk aanwezig",
			"H9160B":"Eiken-haagbeukenbossen (heuvelland)",
			"H7120":"Herstellende hoogvenen",
			"H2130B":"Grijze duinen (kalkarm)",
			"H6110":"Pionierbegroeiingen op rotsbodem",
			"H7110A":"Actieve hoogvenen (hoogveenlandschap)",
			"H7230":"Kalkmoerassen",
			"H6130":"Zinkweiden",
			"H3150":"Meren met krabbenscheer en fonteinkruiden",
			"H1330B":"Schorren en zilte graslanden (binnendijks)",
			"H91D0":"Hoogveenbossen",
			"H2330":"Zandverstuivingen",
			"H1110C":"Permanent overstroomde zandbanken (zuidelijke Noordzee)",
			"H4010A":"Vochtige heiden (hogere zandgronden)",
			"H3140":"Kranswierwateren",
			"H91F0":"Droge hardhoutooibossen",
			"H1140A":"Slik- en zandplaten (getijdengebied)",
			"H9120":"Beuken-eikenbossen met hulst",
			"H2130A":"Grijze duinen (kalkrijk)",
			"H6430C":"Ruigten en zomen (droge bosranden)",
			"H9110":"Veldbies-beukenbossen",
			"H0000":"Afwezig",
			"H2130C":"Grijze duinen (heischraal)",
			"H4010B":"Vochtige heiden (laagveengebied)",
			"H91E0A":"Vochtige alluviale bossen (zachthoutooibossen)",
			"H2120":"Witte duinen",
			"H6410":"Blauwgraslanden",
			"H2160":"Duindoornstruwelen",
			"H6120":"Stroomdalgraslanden",
			"H1170":"Riffen van open zee",
			"H2190D":"Vochtige duinvalleien (hoge moerasplanten)",
			"H9150":"Limestone beech forests of the Cephalanthero-Fagion",
			"H1130":"Estuaria",
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
