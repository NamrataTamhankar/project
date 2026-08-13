import arcpy
import sys, os, time
from datetime import datetime

class Toolbox(object):
    def __init__(self):
        """Define the toolbox (the name of the toolbox is the name of the
        .pyt file)."""
        self.label = "IMNa_tools"
        self.alias = ""
        self.tools = [NBP_Validatie, BES_Validatie, VRN_Validatie]

class NBP_Validatie(object):
    def __init__(self):
        """Define the tool (tool name is the name of the class)."""
        self.label = "NBP Validatie"
        self.description = "Deze tool is bedoeld om de natuurbeheerdata te valideren ten opzichte van de regels gedefinieerd in IMNa. " + \
        "De tool werkt alleen indien gebruik wordt gemaakt van de hiervoor bestemde file geodatabase template. " + \
        "De resultaten worden weggeschreven in een aparte feature dataset: IMNa_validatie. Correcties moeten echter in de originele feature dataset (IMNa) doorgevoerd worden! " + \
        "De dataset IMNa_validatie wordt elke keer overschreven wanneer de tool wordt uitgevoerd. Voordat de plannen worden ingediend in het portaal, dient deze dataset verwijderd te worden. " + \
        "Meer informatie over het gebruik van deze tool is te vinden in de meegeleverde handleiding. "
        self.canRunInBackground = False

    def getParameterInfo(self):
        """Define parameter definitions"""
        in_fgdb = arcpy.Parameter(
            displayName="Input File Geodatabase",
            name="Input_File_Geodatabase",
            datatype="DEWorkspace",
            parameterType="Required",
            direction="Input")
        dup_val = arcpy.Parameter(
            displayName="Validatie unieke waarden",
            name="Duplicaten_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        domein_val = arcpy.Parameter(
            displayName="Validatie domeinen en verplichte waarden",
            name="Domein_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        klein_val = arcpy.Parameter(
            displayName="Validatie features kleiner dan 1 vierkante meter",
            name="klein_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        multipart_val = arcpy.Parameter(
            displayName="Validatie multiparts",
            name="multipart_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        gaten_val = arcpy.Parameter(
            displayName="Validatie gaten kleiner dan 1 vierkante meter (Advanced licentie vereist!)",
            name="gaten_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        topology_val = arcpy.Parameter(
            displayName="Validatie topologie (Standard of Advanced licentie vereist!)",
            name="Topologie_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        dup_val.values = True
        domein_val.values = True
        klein_val.values = True
        multipart_val.values = True
        topology_val.values = True
        gaten_val.values = True
        parameters = [in_fgdb, dup_val, domein_val, klein_val, multipart_val, gaten_val, topology_val]
        return parameters

    def isLicensed(self):
        """Set whether tool is licensed to execute."""
        return True

    def updateParameters(self, parameters):
        """Modify the values and properties of parameters before internal
        validation is performed.  This method is called whenever a parameter
        has been changed."""
        return

    def updateMessages(self, parameters):
        """Modify the messages created by internal validation for each tool
        parameter.  This method is called after internal validation."""
        return

    def execute(self, parameters, messages):
        """The source code of the tool."""
        arcpy.AddMessage("Imported python modules.")

        # Current date time
        start_time = time.time()
        now = datetime.now()

        #Start script time
        start_time_str = now.strftime("%d-%m-%Y_%H:%M:%S")
        arcpy.AddMessage("--*START*--")
        arcpy.AddMessage("{0}  Starting script...".format(start_time_str))

        # Variabelen die bepalen welke validaties uitgevoerd moeten worden
        validate_duplicates = parameters[1].value
        validate_domain = parameters[2].value
        validate_small = parameters[3].value
        validate_multiparts = parameters[4].value
        validate_holes = parameters[5].value
        validate_topology = parameters[6].value

        # Controleer welke licentie er beschikbaar is
        arcpy.AddMessage("Checking license...")
        if arcpy.CheckProduct("ArcInfo") == "Available" or arcpy.CheckProduct("ArcInfo") == "AlreadyInitialized":
            licensed_topology = True
            licensed_holes = True
        elif arcpy.CheckProduct("ArcEditor") == "Available" or arcpy.CheckProduct("ArcEditor") == "AlreadyInitialized":
            licensed_topology = True
            licensed_holes = False
        else:
            licensed_topology = False
            licensed_holes = False
        
        # controleer of er een Advanced licentie beschikbaar is voor de gatencontrole
        if validate_holes and not licensed_holes:
            arcpy.AddWarning("WARNING: No Advanced license available! Small holes cannot be validated!!!")

        # Controleer of er een Standard of Advanced licentie beschikbaar is voor de topologie
        if validate_topology and not licensed_topology:
            arcpy.AddWarning("WARNING: No Standard or Advanced license is available. Topology cannot be validated!!!")

        # Set local variables
        fgdb_path = parameters[0].valueAsText
        out_folder_path = os.path.dirname(os.path.abspath(fgdb_path)).replace('\\', '/')
        fgdb_out_name = os.path.basename(fgdb_path)

        # featureclass en tabel variabelen
        DS_input = "IMNa"
        DS_name = "IMNa_validatie"
        DS_path = "{0}/{1}/{2}".format(out_folder_path, fgdb_out_name, DS_name)
        SR_name = arcpy.SpatialReference(28992)
        FC_list = ["BeheerGebied", "BeheerGebiedAmbitie", "DeelGebied", "ZoekGebiedKlimaat", "ZoekGebiedAgrarisch", "ZoekGebiedWater", "Provinciegrenzen"]
        TB_list = ["NatuurbeheerPlan"]
        TP_name = "IMNa_Topologie"

        # Set environment settings
        arcpy.env.workspace = fgdb_path
        arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
        arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
        arcpy.env.XYResolution = "0.0005 Meters"
        arcpy.env.XYTolerance = "0.001 Meters"
        arcpy.env.overwriteOutput = True

        # print break 
        arcpy.AddMessage("--*Check existance*--")

        # Dataset aanmaken
        arcpy.AddMessage("Checking for previous versions of the validation dataset {0}...".format(DS_name))
        input_DS = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name, DS_name)
        if arcpy.Exists(input_DS):
            arcpy.AddMessage("Validation dataset present; dataset will be recreated for a new validation set.")
            try:
                arcpy.Delete_management(input_DS)
            except:
                pass
            out_sr = arcpy.CreateSpatialReference_management(SR_name)
            arcpy.AddMessage("Recreating dataset with name {0}...".format(DS_name))
            arcpy.CreateFeatureDataset_management(fgdb_path,DS_name,out_sr)
            arcpy.AddMessage("Dataset with name {0} has been recreated.".format(DS_name))
        else:
            arcpy.AddMessage("No validation dataset present.")
            out_sr = arcpy.CreateSpatialReference_management(SR_name)
            arcpy.AddMessage("Creating dataset with name {0}...".format(DS_name))
            arcpy.CreateFeatureDataset_management(fgdb_path,DS_name,out_sr)
            arcpy.AddMessage("Dataset with name {0} has been created.".format(DS_name))

        # print break 
        arcpy.AddMessage("--*Adding featureclasses to validation dataset*--")

        # Kopie van de originele featureclasses toevoegen aan de validatie dataset
        for fcl in FC_list:
            arcpy.AddMessage("Adding featureclass {0} to the validation dataset...".format(fcl))
            FCL_input = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_input,fcl)
            FCL_output = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,fcl)
            arcpy.Copy_management(FCL_input, FCL_output)

        # print break 
        arcpy.AddMessage("--*Creating subtypes*--")

        # Toewijzen van subtypes
        SubtypeDict = {"1": "Natuur","2":"Grootschalige natuur","3":"Agrarisch","4":"Landschap","5":"Water", "6":"Om te vormen natuur"} 
        for fcl in ["BeheerGebied", "BeheerGebiedAmbitie"]:
            FCL_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,fcl)
            arcpy.AddField_management(FCL_path, "gebiedsType", "LONG")
            arcpy.SetSubtypeField_management(FCL_path, "gebiedsType")
            for code in SubtypeDict:
                arcpy.AddSubtype_management(FCL_path, code, SubtypeDict[code])
                arcpy.AddMessage("Subtype {0} has been created for feature class {1}...".format(SubtypeDict[code], fcl))
            ## default subtype instellen
            arcpy.SetDefaultSubtype_management(FCL_path, "1")
            ## Waarden in veld vullen op basis van beheerType
            ### subtypes {"1": "Natuur","2":"Grootschalige natuur","3":"Agrarisch","4":"Landschap","5":"Water", "6":"Om te vormen natuur"}
            fieldName = "gebiedsType"
            expression = "ifBlock(!beheerType!)"
            codeblock = """def ifBlock(beheerType):
            if beheerType[:3] in ['N02', 'N03', 'N04', 'N05', 'N06', 'N07', 'N08', 'N09', 'N10', 'N11', 'N12', 'N13', 'N14', 'N15', 'N16', 'N17']:
                return 1
            elif beheerType[:3]== 'N01':
                return 2
            elif beheerType[:1]== 'A':
                return 3
            elif beheerType[:1]== 'L':
                return 4
            elif beheerType[:1]== 'W':
                return 5
            elif beheerType[:3]== 'N00':
                return 6
            """
            arcpy.CalculateField_management(FCL_path, fieldName, expression, "PYTHON_9.3", codeblock)

        # print break 
        arcpy.AddMessage("--*Validating Natuurbeheerplan record*--")

        # controleer of natuurbeheerplan exact 1 record bevat
        arcpy.AddMessage("Checking the number of records in table {0}...".format(TB_list[0]))
        TB_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,TB_list[0])
        TB_out_name = "ERRORMESSAGE_{0}".format(TB_list[0])
        TB_out_path = "{0}/{1}".format(fgdb_path, TB_out_name)
        if arcpy.Exists(TB_out_path):
            arcpy.Delete_management(TB_out_path)
        cnt = arcpy.management.GetCount(TB_path)[0]
        if cnt != "1":
            arcpy.CreateTable_management(fgdb_path, TB_out_name)
            arcpy.AddField_management(TB_out_path, "Message", "TEXT")
            with arcpy.da.InsertCursor(TB_out_path, ["Message"]) as cursor:
                message = "Tabel {0} bevat {1} rijen, maar dient exact 1 rij te bevatten.".format(TB_list[0], cnt)
                cursor.insertRow([message])
            arcpy.AddMessage("Table {0} must contain exactly 1 record! Message is added to table {1}".format(TB_list[0], TB_out_name))

        if validate_duplicates:
            # print break 
            arcpy.AddMessage("--*Validating duplicates*--")
  
            ## controleer of er dubbele identificaties voorkomen
            # functie aanmaken
            def duplicates_validation(fcl, fcl_name, ds):
                FCL_out_name = "DUPLICATES_{0}".format(fcl_name)
                FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=SR_name)
                arcpy.AddField_management(FCL_out_path, "identificatie", "TEXT")
                arcpy.AddField_management(FCL_out_path, "OriginID", "TEXT")
                with arcpy.da.SearchCursor(FCL_path, ["identificatie","OBJECTID", "SHAPE@"]) as cursor1:
                    identifications = []
                    dup = []
                    for row in cursor1:
                        if row[0] in identifications:
                            identifications += [row[0]]
                            dup += [row[0]]
                        else:
                            identifications += [row[0]]
                with arcpy.da.SearchCursor(fcl, ["identificatie", "OBJECTID","SHAPE@"]) as cursor2, arcpy.da.InsertCursor(FCL_out_path, ["identificatie", "OriginID","SHAPE@"]) as cursor3:  
                    for row in cursor2:
                        if row[0] in dup and row[0] is not None and row[0].strip() != '':
                            cursor3.insertRow(row)
                            arcpy.AddMessage("Duplicate value '{0}' found! Record with ID {1} has been added to feature class DUPLICATES_{2}".format(row[0], str(row[1]), fcl_name))
                if arcpy.management.GetCount(FCL_out_path)[0] == "0":
                    arcpy.Delete_management(FCL_out_path)
                return
            
            # functie aanroepen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking for duplicate values in the field 'identificatie' in feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                duplicates_validation(FCL_path, fcl, DS_path)

        if validate_domain:
            # print break 
            arcpy.AddMessage("--*Validating domains*--")
  
            # Domeinen ophalen
            domains = arcpy.da.ListDomains(fgdb_path)
  
            ## Functies aanmaken voor de domein controle
            # functie voor feature classes
            def fcl_domain_validation(fgdb, fcl, fcl_name, ds, domainslist):
                FCL_out_name = "DOMAINERROR_{0}".format(fcl_name)
                FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)           
                fields = arcpy.ListFields(fcl) 
                fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape' ]
                fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                fieldlist += ['Shape@'] 
                fieldlist2 = fieldlist[:]
                fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'            
                arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                for fieldname in fieldlist2[:-1]:
                    arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")           
                with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                    for row in cursor1:
                        row_list = list(row)
                        has_errors = False
                        for i, value in enumerate(row_list):
                            fieldname = fieldlist[i]
                            for field in fields:
                                if field.name == fieldname:
                                    field_domain = field.domain
                                    field_nullable = field.isNullable
                            if field_domain != '':
                                for domain in domainslist:
                                    if domain.name == field_domain:
                                        domainvalues = domain.codedValues
                                if value not in domainvalues:
                                    if value is not None and str(value).strip() != '':
                                        row_list[i] = str(row_list[i]) + " (FOUT)"
                                        arcpy.AddMessage("{0} value '{1}' is not in the domain list! Record with ID {2} is added to feature class {3}".format(fieldlist[i], str(value), str(row_list[-2]), FCL_out_name))
                                        has_errors = True
                            if not field_nullable:
                                if value is None or str(value).strip() == '':
                                    row_list[i] = "(ONTBREEKT)"
                                    arcpy.AddMessage("Mandatory value for field {0} is missing! Record with ID {1} is added to feature class {2}".format(fieldlist[i], str(row_list[-2]), FCL_out_name))
                                    has_errors = True
                        if has_errors:
                            cursor2.insertRow(row_list)
                    if arcpy.management.GetCount(FCL_out_path)[0] == "0":
                        arcpy.Delete_management(FCL_out_path)
                return

            # functie aanroepen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking if values are inside the domain for feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                fcl_domain_validation(fgdb_path, FCL_path, fcl, DS_path, domains)

            # functie voor tabel Natuurbeheerplan
            def table_domain_validation(fgdb, tbl, tbl_name, domainslist):
                TBL_out_name = "DOMAINERROR_{0}".format(tbl_name)
                TBL_out_path = "{0}/{1}".format(fgdb, TBL_out_name)
                fields = arcpy.ListFields(tbl)
                fieldlist = [ field.name for field in fields ]
                fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                fieldlist2 = fieldlist[:]
                fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'
                arcpy.CreateTable_management(fgdb, TBL_out_name)
                for fieldname in fieldlist2:
                    arcpy.AddField_management(TBL_out_path, fieldname, "TEXT")
                with arcpy.da.SearchCursor(tbl, fieldlist) as cursor1, arcpy.da.InsertCursor(TBL_out_path, fieldlist2) as cursor2:
                    for row in cursor1:
                        row_list = list(row)
                        has_errors = False
                        for i, value in enumerate(row_list):
                            fieldname = fieldlist[i]
                            for field in fields:
                                if field.name == fieldname:
                                    field_domain = field.domain
                                    field_nullable = field.isNullable
                            if field_domain != '':
                                for domain in domainslist:
                                    if domain.name == field_domain:
                                        domainvalues = domain.codedValues
                                if value not in domainvalues:
                                    if value is not None and str(value).strip() != '':
                                        row_list[i] = str(row_list[i]) + " (FOUT)"
                                        arcpy.AddMessage("{0} value '{1}' is not in the domain list! Record with ID {2} is added to table {3}".format(fieldlist[i], str(value), str(row_list[-1]), TBL_out_name))
                                        has_errors = True
                            if not field_nullable:
                                if value is None or str(value).strip() == '':
                                    row_list[i] = "(ONTBREEKT)"
                                    arcpy.AddMessage("Mandatory value for field {0} is missing! Record with ID {1} is added to table {2}".format(fieldlist[i], str(row_list[-1]), TBL_out_name))
                                    has_errors = True
                        if has_errors:
                            cursor2.insertRow(row_list)
                    if arcpy.management.GetCount(TBL_out_path)[0] == "0":
                        arcpy.Delete_management(TBL_out_path)
                return
  
            # aanroep voor tabel NatuurBeheerPlan
            arcpy.AddMessage("Checking if values are inside the domain for table {0}...".format(TB_list[0]))
            TB_path = "{0}/{1}/{2}".format(out_folder_path,fgdb_out_name,TB_list[0])
            table_domain_validation(fgdb_path, TB_path, TB_list[0], domains)

        if validate_small:
            # print break 
            arcpy.AddMessage("--*Validating feature size*--")

            # functie maken
            def small_area_validation(fcl, fcl_name, ds):
                FCL_out_name = "SMALLFEATURES_{0}".format(fcl_name)
                FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                fields = arcpy.ListFields(fcl)
                fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape' ]
                fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                fieldlist += ['Shape@', 'SHAPE@AREA']
                fieldlist2 = fieldlist[:-1]
                fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'
                arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                for fieldname in fieldlist2[:-1]:
                    arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")
                with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                    for row in cursor1:
                        if row[-1] < 1.0:
                            arcpy.AddMessage("Feature with an area < 1 square meter found! Feature with id {0} is added to feature class {1}".format(row[-3], FCL_out_name))
                            cursor2.insertRow(row[:-1])
                    if arcpy.management.GetCount(FCL_out_path)[0] == "0":
                        arcpy.Delete_management(FCL_out_path)
                return
            
            # functie aanroepen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking for areas smaller than 1 square meter in feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                small_area_validation(FCL_path, fcl, DS_path)

        if validate_multiparts:
            # print break 
            arcpy.AddMessage("--*Validating multiparts*--")
  
            # functie aanmaken voor controle op multiparts
            def multipart_validation (fgdb, fcl, fcl_name, ds):
                multi_name = "MultiToSingle_{0}".format(fcl_name)
                multi_path = "{0}/{1}".format("in_memory", multi_name)
                arcpy.AddField_management(fcl, "tmpUID", "long")
                OIDFieldName = arcpy.Describe(fcl).OIDFieldName
                arcpy.CalculateField_management(fcl, "tmpUID","!" + OIDFieldName + "!", "PYTHON")
                arcpy.MultipartToSinglepart_management(fcl, multi_path)
                inCount = int(arcpy.GetCount_management(fcl).getOutput(0))
                outCount = int(arcpy.GetCount_management(multi_path).getOutput(0))
                if inCount != outCount:
                    id_values = [ row[0] for row in arcpy.da.SearchCursor(multi_path, "tmpUID") ]
                    multi_rows = [ id for id in id_values if id_values.count(id) > 1 ]
                    FCL_out_name = "MULTIPART_{0}".format(fcl_name)
                    FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                    fields = arcpy.ListFields(fcl)
                    fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape' and field.name != 'OBJECTID']
                    fieldlist += ['Shape@']
                    fieldlist2 = fieldlist[:]
                    fieldlist2[fieldlist2.index('tmpUID')] = 'OriginID'
                    arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                    for fieldname in fieldlist2[:-1]:
                        arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")
                    with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                        for row in cursor1:
                            if row[-2] in multi_rows:
                                cursor2.insertRow(row)
                                arcpy.AddMessage("Multipart polygon found! Record with id {0} is added to feature class {1}".format(row[-2], FCL_out_name))
                arcpy.DeleteField_management(fcl, ["tmpUID"])
                return
          
            # aanroep voor alle kaartlagen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking for multipart polygons in feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                multipart_validation(fgdb_path, FCL_path, fcl, DS_path)                

        if validate_holes and licensed_holes:
            arcpy.AddMessage("--*Validating hole size*--")

            def small_holes_validation(folder, fcl, fcl_name, ds):
                fill = "{0}/{1}_filled".format("in_memory", fcl_name)
                arcpy.EliminatePolygonPart_management(fcl, fill, condition="AREA", part_area=1, part_option="CONTAINED_ONLY")
                date_time = now.strftime("%Y%m%d%H%M%S")
                compfile = "{0}/compare_{1}.csv".format(folder, date_time)
                arcpy.FeatureCompare_management(fcl, fill, "identificatie", compare_type="GEOMETRY_ONLY", ignore_options = ["IGNORE_SUBTYPES"], continue_compare="CONTINUE_COMPARE", out_compare_file=compfile)
                diff_rows = []
                with arcpy.da.SearchCursor(compfile, ["Has_error", "Identifier", "Message"]) as cursor:
                    for row in cursor:
                        if row[0].strip() == "true" and row[1].strip() == "FeatureClass":
                            diff_rows += [ int(value) for value in row[2].split() if value.isnumeric() ]
                if len(diff_rows) > 0:
                    FCL_out_name = "SMALLHOLES_{}".format(fcl_name)
                    FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                    arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                    fields = arcpy.ListFields(fcl)
                    fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape']
                    fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                    fieldlist += ['Shape@'] 
                    fieldlist2 = fieldlist[:]
                    fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'
                    for fieldname in fieldlist2[:-1]:
                        arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")
                    with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                        for row in cursor1:
                            if row[-2] in diff_rows:
                                cursor2.insertRow(row)
                                arcpy.AddMessage("Polygon with one or more holes < 1 square meter found! Record with id {0} is added to feature class {1}".format(row[-2], FCL_out_name))
                arcpy.Delete_management(compfile)
                return
            
            # Controleren of er gaten kleiner dan 1 m2 voorkomen in de feature classes
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking for holes < 1 square meter in feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path, fgdb_out_name, DS_name, fcl)
                small_holes_validation(out_folder_path, FCL_path, fcl, DS_path)

        if licensed_topology and validate_topology:
            # print break 
            arcpy.AddMessage("--*Validating topology*--")
  
            #### Aanmaken topology class
            arcpy.AddMessage("Creating topology class with name {0}...".format(TP_name))
            arcpy.CreateTopology_management(DS_path, TP_name)
            TP_path = "{0}/{1}/{2}/{3}".format(out_folder_path,fgdb_out_name,DS_name,TP_name)
            arcpy.AddMessage("Topology class {0} has been created.".format(TP_name))
  
            # Toevoegen featureclasses aan topology class, in een loop
            for fcl in FC_list:
                arcpy.AddMessage("Adding featureclass {0} to the validation topology class...".format(fcl))
                FCL_input = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,fcl)
                arcpy.AddFeatureClassToTopology_management(TP_path, FCL_input, 1, 1)
                arcpy.AddMessage("Featureclass {0} has been added to the validation dataset and topology class.".format(fcl))
  
            # Toevoegen topology rules
            # regels voor featureclass [0] BeheerGebied
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[0]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[0]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap (Area)", FCL_path, subtype='Natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap (Area)", FCL_path, subtype='Grootschalige natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap (Area)", FCL_path, subtype='Landschap')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Natuur', in_featureclass2=FCL_path, subtype2='Grootschalige natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Natuur', in_featureclass2=FCL_path, subtype2='Landschap')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Grootschalige natuur', in_featureclass2=FCL_path, subtype2='Landschap')
            ## overlap met een andere featureclass
            ### mag niet overlappen met [3] ZoekGebiedKlimaat
            FCL_2_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[3]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Natuur', in_featureclass2=FCL_2_path)
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Grootschalige natuur', in_featureclass2=FCL_2_path)
            ### mag niet overlappen met [4] ZoekGebiedAgrarisch
            FCL_2_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[4]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Natuur', in_featureclass2=FCL_2_path)
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Grootschalige natuur', in_featureclass2=FCL_2_path)
            ### mag niet overlappen met [5] ZoekgebiedWater
            FCL_2_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[5]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Natuur', in_featureclass2=FCL_2_path)
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Grootschalige natuur', in_featureclass2=FCL_2_path)
            ### moet overlappen met [6] Provinciegrenzen
            FCL_4_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[6]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", FCL_path, in_featureclass2=FCL_4_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[0]))
  
            # regels voor featureclass [1] BeheerGebiedAmbitie
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[1]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[1]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap (Area)", FCL_path, subtype='Natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap (Area)", FCL_path, subtype='Grootschalige natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap (Area)", FCL_path, subtype='Landschap')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap (Area)", FCL_path, subtype='Om te vormen natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Natuur', in_featureclass2=FCL_path, subtype2='Grootschalige natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Natuur', in_featureclass2=FCL_path, subtype2='Landschap')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Natuur', in_featureclass2=FCL_path, subtype2='Om te vormen natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Grootschalige natuur', in_featureclass2=FCL_path, subtype2='Landschap')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Om te vormen natuur', in_featureclass2=FCL_path, subtype2='Grootschalige natuur')
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap With (Area-Area)", FCL_path, subtype='Om te vormen natuur', in_featureclass2=FCL_path, subtype2='Landschap')
            ## overlap met een andere featureclass
            ### moet overlappen met [6] Provinciegrenzen
            FCL_2_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[6]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", FCL_path, in_featureclass2=FCL_2_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[1]))
    
            # regels voor featureclass [2] Deelgebied
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[2]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[2]))
            FCL_2_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[6]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", FCL_path, in_featureclass2=FCL_2_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[2]))
  
            # regels voor featureclass [3] ZoekGebiedKlimaat
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[3]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[3]))
            FCL_2_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[6]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", FCL_path, in_featureclass2=FCL_2_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[3]))

            # regels voor featureclass [4] ZoekgebiedAgrarisch
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[4]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[4]))
            FCL_2_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[6]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", FCL_path, in_featureclass2=FCL_2_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[4]))
  
            # regels voor featureclass [5] ZoekgebiedWater
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[5]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[5]))
            FCL_2_path = "{0}/{1}/{2}/{3}_val".format(out_folder_path,fgdb_out_name,DS_name,(FC_list[6]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", FCL_path, in_featureclass2=FCL_2_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[5]))
        
        ## valideer de data tegen de topologie regels
        if licensed_topology and validate_topology:
            arcpy.AddMessage("Validate the data against the topology rules...")
            try:
                arcpy.ValidateTopology_management(TP_path)
            except Exception as e:
                arcpy.AddError("ERROR: Topology validation is not possible, subtype 'gebiedsType' could not be derived from field 'beheerType' for some records in BeheerGebied and/or BeheerGebiedAmbitie!")
                arcpy.AddError(e)
                pass
        elif validate_topology:
            arcpy.AddWarning("Topology validation has been skipped because no Standard or Advanced license is available!!!")

        # Looptijd van het script als afsluiter laten zien
        end_time = time.time()
        hours, rem = divmod(end_time - start_time, 3600)
        minutes, seconds = divmod(rem, 60)
        arcpy.AddMessage("Script succeeded. Execution took {:0>2}:{:0>2}:{:05.2f}.".format(int(hours),int(minutes),seconds))
        arcpy.AddMessage("--*END*--")
        return

class BES_Validatie(object):
    def __init__(self):
        """Define the tool (tool name is the name of the class)."""
        self.label = "Beschikkingen Validatie"
        self.description = "Deze tool is bedoeld om de beschikkingen te valideren ten opzichte van de regels gedefinieerd in IMNa. " + \
        "De tool werkt alleen indien gebruik wordt gemaakt van de hiervoor bestemde file geodatabase template. " + \
        "De resultaten worden weggeschreven in een aparte feature dataset: IMNa_validatie. Correcties moeten echter in de originele feature dataset (IMNa) doorgevoerd worden! " + \
        "De dataset IMNa_validatie wordt elke keer overschreven wanneer de tool wordt uitgevoerd. Voordat de plannen worden ingediend in het portaal, dient deze dataset verwijderd te worden. " + \
        "Meer informatie over het gebruik van deze tool is te vinden in de meegeleverde handleiding. "
        self.canRunInBackground = False

    def getParameterInfo(self):
        """Define parameter definitions"""
        in_fgdb = arcpy.Parameter(
            displayName="Input File Geodatabase",
            name="Input_File_Geodatabase",
            datatype="DEWorkspace",
            parameterType="Required",
            direction="Input")
        dup_val = arcpy.Parameter(
            displayName="Validatie unieke waarden",
            name="Duplicaten_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        domein_val = arcpy.Parameter(
            displayName="Validatie domeinen en verplichte waarden",
            name="Domein_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        klein_val = arcpy.Parameter(
            displayName="Validatie features kleiner dan 1 vierkante meter",
            name="klein_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        multipart_val = arcpy.Parameter(
            displayName="Validatie multiparts",
            name="multipart_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        gaten_val = arcpy.Parameter(
            displayName="Validatie gaten kleiner dan 1 vierkante meter (Advanced licentie vereist!)",
            name="gaten_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        topology_val = arcpy.Parameter(
            displayName="Validatie topologie: zelf overlap (Standard of Advanced licentie vereist!)",
            name="Topologie_validatie",
            datatype="GPBoolean",
            parameterType="Optional",
            direction="Input")
        prov = arcpy.Parameter(
            displayName="Provincie",
            name="Provincie",
            datatype="GPString",
            parameterType="Optional",
            direction="Input")
        dup_val.values = True
        domein_val.values = True
        multipart_val.values = True
        klein_val.values = True
        gaten_val.values = True
        prov.filter.type = "ValueList"
        prov.filter.list = ["Groningen","Friesland","Drenthe","Overijssel","Flevoland","Gelderland","Utrecht","Noord-Holland","Zuid-Holland","Zeeland","Noord-Brabant","Limburg"]
        parameters = [in_fgdb, dup_val, domein_val, klein_val, multipart_val, gaten_val, topology_val, prov]
        parameters[7].enabled = False
        return parameters

    def isLicensed(self):
        """Set whether tool is licensed to execute."""
        return True

    def updateParameters(self, parameters):
        """Modify the values and properties of parameters before internal
        validation is performed.  This method is called whenever a parameter
        has been changed."""
        if parameters[6].value:
            parameters[7].enabled = True
        else:
            parameters[7].enabled = False
        return

    def updateMessages(self, parameters):
        """Modify the messages created by internal validation for each tool
        parameter.  This method is called after internal validation."""
        return

    def execute(self, parameters, messages):
        """The source code of the tool."""
        arcpy.AddMessage("Imported python modules.")

        # Current date time
        start_time = time.time()
        now = datetime.now()
        
        #Start script time
        start_time_str = now.strftime("%d-%m-%Y_%H:%M:%S")
        arcpy.AddMessage("--*START*--")
        arcpy.AddMessage("{0}  Starting script...".format(start_time_str))

        # Variabelen die bepalen welke validaties uitgevoerd moeten worden
        validate_duplicates = parameters[1].value
        validate_domain = parameters[2].value
        validate_small = parameters[3].value
        validate_multiparts = parameters[4].value
        validate_holes = parameters[5].value
        validate_topology = parameters[6].value

        # Controleer welke licentie er beschikbaar is
        arcpy.AddMessage("Checking license...")
        if arcpy.CheckProduct("ArcInfo") == "Available" or arcpy.CheckProduct("ArcInfo") == "AlreadyInitialized":
            licensed_topology = True
            licensed_holes = True
        elif arcpy.CheckProduct("ArcEditor") == "Available" or arcpy.CheckProduct("ArcEditor") == "AlreadyInitialized":
            licensed_topology = True
            licensed_holes = False
        else:
            licensed_topology = False
            licensed_holes = False
        
        # controleer of er een Advanced licentie beschikbaar is voor de gatencontrole
        if validate_holes and not licensed_holes:
            arcpy.AddWarning("WARNING: No Advanced license available! Small holes cannot be validated!!!")

        # Controleer of er een Standard of Advanced licentie beschikbaar is voor de topologie
        if validate_topology and not licensed_topology:
            arcpy.AddWarning("WARNING: No Standard or Advanced license is available. Topology cannot be validated!!!")

        # Controleer of de parameters voor de Provincie ingevuld zijn als validatie topologie is aangevinkt
        exit_execution = False
        if validate_topology and not parameters[7].value:
            arcpy.AddError("Parameter 'Provincie' is required when 'Validatie topologie' is checked!")
            exit_execution = True
        if exit_execution:
            sys.exit()

        # FGDB variabelen
        input_fgdb_path = parameters[0].valueAsText
        folder_path = os.path.dirname(os.path.abspath(input_fgdb_path)).replace('\\', '/')
        input_fgdb_name = os.path.basename(input_fgdb_path)

        # featureclass en tabel variabelen
        DS_input = "IMNa"
        DS_name = "IMNa_validatie"
        TP_name = "IMNa_topologie"
        DS_path = "{0}/{1}/{2}".format(folder_path,input_fgdb_name,DS_name)
        SR_name = arcpy.SpatialReference(28992)
        FC_list = ["Beschikking", "Provinciegrenzen"]
        TB_list = ["BeschikkingenRapportage"]

        # environment settings
        arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
        arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
        arcpy.env.XYResolution = "0.0005 Meters"
        arcpy.env.XYTolerance = "0.001 Meters"
        arcpy.env.overwriteOutput = True

        # print break
        arcpy.AddMessage("--*Check existance*--")

        # Dataset aanmaken
        arcpy.AddMessage("Checking for previous versions of the validation dataset {0}...".format(DS_name))
        input_DS = "{0}/{1}/{2}".format(folder_path,input_fgdb_name, DS_name)
        if arcpy.Exists(input_DS):
            arcpy.AddMessage("Validation dataset present; dataset will be recreated for a new validation set.")
            try:
                arcpy.Delete_management(input_DS)
            except:
                pass
            out_sr = arcpy.CreateSpatialReference_management(SR_name)
            arcpy.AddMessage("Recreating dataset with name {0}...".format(DS_name))
            arcpy.CreateFeatureDataset_management(input_fgdb_path,DS_name,out_sr)
            arcpy.AddMessage("Dataset with name {0} has been recreated.".format(DS_name))
        else:
            arcpy.AddMessage("No validation dataset present.")
            out_sr = arcpy.CreateSpatialReference_management(SR_name)
            arcpy.AddMessage("Creating dataset with name {0}...".format(DS_name))
            arcpy.CreateFeatureDataset_management(input_fgdb_path,DS_name,out_sr)
            arcpy.AddMessage("Dataset with name {0} has been created.".format(DS_name))

        # print break
        arcpy.AddMessage("--*Adding featureclasses to validation dataset*--")

        # Kopie van de originele featureclasses toevoegen aan de validatie dataset
        for fcl in FC_list[:-1]:
            arcpy.AddMessage("Adding featureclass {0} to the validation dataset...".format(fcl))
            FCL_input = "{0}/{1}/{2}/{3}".format(folder_path,input_fgdb_name,DS_input,fcl)
            FCL_output = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,fcl)
            arcpy.Copy_management(FCL_input, FCL_output)

        # print break in between sections
        arcpy.AddMessage("--*Validating BeschikkingenRapportage record*--")

        # controleer of BeschikkingenRapportage exact 1 record bevat
        arcpy.AddMessage("Checking the number of records in table {0}...".format(TB_list[0]))
        TB_path = "{0}/{1}/{2}".format(folder_path,input_fgdb_name,TB_list[0])
        TB_out_name = "ERRORMESSAGE_{0}".format(TB_list[0])
        TB_out_path = "{0}/{1}".format(input_fgdb_path, TB_out_name)
        if arcpy.Exists(TB_out_path):
            arcpy.Delete_management(TB_out_path)
        cnt = arcpy.management.GetCount(TB_path)[0]
        if cnt != "1":
            arcpy.CreateTable_management(input_fgdb_path, TB_out_name)
            arcpy.AddField_management(TB_out_path, "Message", "TEXT")
            with arcpy.da.InsertCursor(TB_out_path, ["Message"]) as cursor:
                message = "Tabel {0} bevat {1} rijen, maar dient exact 1 rij te bevatten.".format(TB_list[0], cnt)
                cursor.insertRow([message])
            arcpy.AddMessage("Table {0} must contain exactly 1 record! Message is added to table {1}".format(TB_list[0], TB_out_name))

        if validate_duplicates:
            # print break
            arcpy.AddMessage("--*Validating duplicates*--")

            ## controleer of er dubbele identificaties voorkomen
            # functie aanmaken
            def duplicates_validation(fcl, fcl_name, ds):
                FCL_out_name = "DUPLICATES_{0}".format(fcl_name)
                FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=SR_name)
                arcpy.AddField_management(FCL_out_path, "identificatie", "TEXT")
                arcpy.AddField_management(FCL_out_path, "OriginID", "TEXT")
                with arcpy.da.SearchCursor(FCL_path, ["identificatie", "OBJECTID", "SHAPE@"]) as cursor1:
                    identifications = []
                    dup_id = []
                    for row in cursor1:
                        if row[0] in identifications:
                            dup_id += [row[0]]
                        identifications += [row[0]]
                with arcpy.da.SearchCursor(fcl, ["identificatie", "OBJECTID","SHAPE@"]) as cursor2, arcpy.da.InsertCursor(FCL_out_path, ["identificatie", "OriginID","SHAPE@"]) as cursor3:  
                    for row in cursor2:
                        row_list = list(row)
                        has_errors = False
                        if row[0] in dup_id and row[0] is not None and row[0].strip() != '':
                            row_list[0] += " (NIET UNIEK)"
                            has_errors = True
                            arcpy.AddMessage("Duplicate value '{0}' in field 'identificatie' found! Record with ID {1} has been added to feature class DUPLICATES_{2}".format(row[0], str(row[-2]), fcl_name))
                        if has_errors:
                            cursor3.insertRow(row_list)
                if arcpy.management.GetCount(FCL_out_path)[0] == "0":
                    arcpy.Delete_management(FCL_out_path)
                return
            
            # functie aanroepen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking for duplicate values in the fields 'identificatie' in feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                duplicates_validation(FCL_path, fcl, DS_path)

        if validate_domain:
            # print break
            arcpy.AddMessage("--*Validating domains*--")

            ## Functies aanmaken voor de domein controle
            # functie voor feature classes
            def fcl_domain_validation(fgdb, fcl, fcl_name, ds, domainslist):
                FCL_out_name = "DOMAINERROR_{0}".format(fcl_name)
                FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)           
                fields = arcpy.ListFields(fcl) 
                fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape' ]
                fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                fieldlist += ['Shape@'] 
                fieldlist2 = fieldlist[:]
                fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'            
                arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                for fieldname in fieldlist2[:-1]:
                    arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")           
                with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                    for row in cursor1:
                        row_list = list(row)
                        has_errors = False
                        for i, value in enumerate(row_list):
                            fieldname = fieldlist[i]
                            for field in fields:
                                if field.name == fieldname:
                                    field_domain = field.domain
                                    field_nullable = field.isNullable
                            if field_domain != '':
                                for domain in domainslist:
                                    if domain.name == field_domain:
                                        domainvalues = domain.codedValues
                                if value not in domainvalues:
                                    if value is not None and str(value).strip() != '':
                                        row_list[i] = str(row_list[i]) + " (FOUT)"
                                        arcpy.AddMessage("{0} value '{1}' is not in the domain list! Record with ID {2} is added to feature class {3}".format(fieldlist[i], str(value), str(row_list[-2]), FCL_out_name))
                                        has_errors = True
                            if not field_nullable:
                                if value is None or str(value).strip() == '':
                                    row_list[i] = "(ONTBREEKT)"
                                    arcpy.AddMessage("Mandatory value for field {0} is missing! Record with ID {1} is added to feature class {2}".format(fieldlist[i], str(row_list[-2]), FCL_out_name))
                                    has_errors = True
                        if has_errors:
                            cursor2.insertRow(row_list)
                    if arcpy.management.GetCount(FCL_out_path)[0] == "0":
                        arcpy.Delete_management(FCL_out_path)
                return

            # functie voor tabel VoortgangsRapportage
            def table_domain_validation(fgdb, tbl, tbl_name, domainslist):
                TBL_out_name = "DOMAINERROR_{0}".format(tbl_name)
                TBL_out_path = "{0}/{1}".format(fgdb, TBL_out_name)
                fields = arcpy.ListFields(tbl)
                fieldlist = [ field.name for field in fields ]
                fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                fieldlist2 = fieldlist[:]
                fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'
                arcpy.CreateTable_management(fgdb, TBL_out_name)
                for fieldname in fieldlist2:
                    arcpy.AddField_management(TBL_out_path, fieldname, "TEXT")
                with arcpy.da.SearchCursor(tbl, fieldlist) as cursor1, arcpy.da.InsertCursor(TBL_out_path, fieldlist2) as cursor2:
                    for row in cursor1:
                        row_list = list(row)
                        has_errors = False
                        for i, value in enumerate(row_list):
                            fieldname = fieldlist[i]
                            for field in fields:
                                if field.name == fieldname:
                                    field_domain = field.domain
                                    field_nullable = field.isNullable
                            if field_domain != '':
                                for domain in domainslist:
                                    if domain.name == field_domain:
                                        domainvalues = domain.codedValues
                                if value not in domainvalues:
                                    if value is not None and str(value).strip() != '':
                                        row_list[i] = str(row_list[i]) + " (FOUT)"
                                        arcpy.AddMessage("{0} value '{1}' is not in the domain list! Record with ID {2} is added to table {3}".format(fieldlist[i], str(value), str(row_list[-1]), TBL_out_name))
                                        has_errors = True
                            if not field_nullable:
                                if value is None or str(value).strip() == '':
                                    row_list[i] = "(ONTBREEKT)"
                                    arcpy.AddMessage("Mandatory value for field {0} is missing! Record with ID {1} is added to table {2}".format(fieldlist[i], str(row_list[-1]), TBL_out_name))
                                    has_errors = True
                            if has_errors:
                                cursor2.insertRow(row_list)
                    if arcpy.management.GetCount(TBL_out_path)[0] == "0":
                        arcpy.Delete_management(TBL_out_path)
                return

            # domeinen ophalen
            domains = arcpy.da.ListDomains(input_fgdb_path)

            # [0] Beschikking
            arcpy.AddMessage("Checking if values are inside the domain for feature class {0}...".format(FC_list[0]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,FC_list[0])
            fcl_domain_validation(input_fgdb_path, FCL_path, FC_list[0], DS_path, domains)

            # [0] BeschikkingenRapportage
            arcpy.AddMessage("Checking if values are inside the domain for table {0}...".format(TB_list[0]))
            TB_path = "{0}/{1}/{2}".format(folder_path,input_fgdb_name,TB_list[0])
            table_domain_validation(input_fgdb_path, TB_path, TB_list[0], domains)

        if validate_small:
            # print break
            arcpy.AddMessage("--*Validating feature size*--")

            # functie maken
            def small_area_validation(fcl, fcl_name, ds):
                FCL_out_name = "SMALLFEATURES_{0}".format(fcl_name)
                FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                fields = arcpy.ListFields(fcl)
                fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape' ]
                fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                fieldlist += ['Shape@', 'SHAPE@AREA']
                fieldlist2 = fieldlist[:-1]
                fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'
                arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                for fieldname in fieldlist2[:-1]:
                    arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")
                with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                    for row in cursor1:
                        if row[-1] < 1.0:
                            arcpy.AddMessage("Feature with an area < 1 square meter found! Feature with id {0} is added to feature class {1}".format(row[-3], FCL_out_name))
                            cursor2.insertRow(row[:-1])
                    if arcpy.management.GetCount(FCL_out_path)[0] == "0":
                        arcpy.Delete_management(FCL_out_path)
                return
            
            # functie aanroepen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking for areas smaller than 1 square meter in feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                small_area_validation(FCL_path, fcl, DS_path)

        if validate_multiparts:
            # print break
            arcpy.AddMessage("--*Validating multiparts*--")

            # functie aanmaken voor controle op multiparts
            def multipart_validation (fgdb, fcl, fcl_name, ds):
                multi_name = "MultiToSingle_{0}".format(fcl_name)
                multi_path = "{0}/{1}".format("in_memory", multi_name)
                arcpy.AddField_management(fcl, "tmpUID", "long")
                OIDFieldName = arcpy.Describe(fcl).OIDFieldName
                arcpy.CalculateField_management(fcl, "tmpUID","!" + OIDFieldName + "!", "PYTHON")
                arcpy.MultipartToSinglepart_management(fcl, multi_path)
                inCount = int(arcpy.GetCount_management(fcl).getOutput(0))
                outCount = int(arcpy.GetCount_management(multi_path).getOutput(0))
                if inCount != outCount:
                    id_values = [ row[0] for row in arcpy.da.SearchCursor(multi_path, "tmpUID") ]
                    multi_rows = [ id for id in id_values if id_values.count(id) > 1 ]
                    FCL_out_name = "MULTIPART_{0}".format(fcl_name)
                    FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                    fields = arcpy.ListFields(fcl)
                    fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape' and field.name != 'OBJECTID']
                    fieldlist += ['Shape@']
                    fieldlist2 = fieldlist[:]
                    fieldlist2[fieldlist2.index('tmpUID')] = 'OriginID'
                    arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                    for fieldname in fieldlist2[:-1]:
                        arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")
                    with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                        for row in cursor1:
                            if row[-2] in multi_rows:
                                cursor2.insertRow(row)
                                arcpy.AddMessage("Multipart polygon found! Record with id {0} is added to feature class {1}".format(row[-2], FCL_out_name))
                arcpy.DeleteField_management(fcl, ["tmpUID"])
                return

            # Controleren of er multiparts voorkomen in de feature classes
            # [0] Beschikking
            arcpy.AddMessage("Checking for multipart polygons in feature class {0}...".format(FC_list[0]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,FC_list[0])
            multipart_validation(input_fgdb_path, FCL_path, FC_list[0], DS_path)

        if validate_holes and licensed_holes:
            # print break
            arcpy.AddMessage("--*Validating hole size*--")

            def small_holes_validation(folder, fcl, fcl_name, ds):
                fill = "{0}/{1}_filled".format("in_memory", fcl_name)
                arcpy.EliminatePolygonPart_management(fcl, fill, condition="AREA", part_area=1, part_option="CONTAINED_ONLY")
                date_time = now.strftime("%Y%m%d%H%M%S")
                compfile = "{0}/compare_{1}.csv".format(folder, date_time)
                arcpy.FeatureCompare_management(fcl, fill, "identificatie", compare_type="GEOMETRY_ONLY", ignore_options = ["IGNORE_SUBTYPES"], continue_compare="CONTINUE_COMPARE", out_compare_file=compfile)
                diff_rows = []
                with arcpy.da.SearchCursor(compfile, ["Has_error", "Identifier", "Message"]) as cursor:
                    for row in cursor:
                        if row[0].strip() == "true" and row[1].strip() == "FeatureClass":
                            diff_rows += [ int(value) for value in row[2].split() if value.isnumeric() ]
                if len(diff_rows) > 0:
                    FCL_out_name = "SMALLHOLES_{}".format(fcl_name)
                    FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                    arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                    fields = arcpy.ListFields(fcl)
                    fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape']
                    fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                    fieldlist += ['Shape@'] 
                    fieldlist2 = fieldlist[:]
                    fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'
                    for fieldname in fieldlist2[:-1]:
                        arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")
                    with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                        for row in cursor1:
                            if row[-2] in diff_rows:
                                cursor2.insertRow(row)
                                arcpy.AddMessage("Polygon with one or more holes < 1 square meter found! Record with id {0} is added to feature class {1}".format(row[-2], FCL_out_name))
                arcpy.Delete_management(compfile)
                return

            # Controleren of er gaten kleiner dan 1 m2 voorkomen in de feature classes
            # [0] Beschikking
            arcpy.AddMessage("Checking for holes < 1 square meter in feature class {0}...".format(FC_list[0]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,FC_list[0])
            small_holes_validation(folder_path, FCL_path, FC_list[0], DS_path)            

        if licensed_topology and validate_topology:
            # print break in between sections
            arcpy.AddMessage("--*Validating topology*--")

            # gekozen provincie
            prov_name = parameters[7].valueAsText

            prov_dict = {"Groningen":20,
            "Friesland":21,
            "Drenthe":22,
            "Overijssel":23,
            "Flevoland":24,
            "Gelderland":25,
            "Utrecht":26,
            "Noord-Holland":27,
            "Zuid-Holland":28,
            "Zeeland":29,
            "Noord-Brabant":30,
            "Limburg":31}

            prov_code = prov_dict[prov_name]

            # provinciegrens ophalen
            arcpy.AddMessage("Adding province layer {0} to the validation dataset...".format(prov_name))
            input_FCL_path = "{0}/{1}/{2}/{3}".format(folder_path, input_fgdb_name, DS_input, FC_list[1])
            Provincie_path = "{0}/{1}/{2}/{3}".format(folder_path, input_fgdb_name, DS_name, prov_name)
            arcpy.Select_analysis(input_FCL_path, Provincie_path, '"NUMMER_CSV" = %i' % prov_code)
            arcpy.AddMessage("Province layer {0} has been added to the validation dataset.".format(prov_name))
 
            # Aanmaken topology class
            arcpy.AddMessage("Creating topology class with name {0}...".format(TP_name))
            arcpy.CreateTopology_management(DS_path, TP_name)
            TP_path = "{0}/{1}/{2}/{3}".format(folder_path, input_fgdb_name, DS_name, TP_name)
            arcpy.AddMessage("Topology class {0} has been created.".format(TP_name))
  
            # Toevoegen featureclasses aan topology class, in een loop
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Adding featureclass {0} to the validation topology class...".format(fcl))
                FCL_path = "{0}/{1}/{2}/{3}_val".format(folder_path, input_fgdb_name, DS_name, fcl)
                arcpy.AddFeatureClassToTopology_management(TP_path, FCL_path, 1, 1)
                arcpy.AddMessage("Featureclass {0} has been added to the validation dataset and topology class.".format(fcl))

            # voeg Provincie toe
            arcpy.AddMessage("Adding layer {0} to the validation topology class...".format(prov_name))
            arcpy.AddFeatureClassToTopology_management(TP_path, Provincie_path, 1, 1)
            arcpy.AddMessage("Layer {0} has been added to the validation topology class.".format(prov_name))
         
            # toevoegen van topology rules
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[0]))
            FCL_path = "{0}/{1}/{2}/{3}_val".format(folder_path, input_fgdb_name, DS_name, FC_list[0])
            arcpy.AddRuleToTopology_management(TP_path, "Must Not Overlap (Area)", FCL_path)
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", FCL_path, in_featureclass2=Provincie_path)
            arcpy.AddMessage("Topology rules have been added for feature class {}".format(FC_list[0]))

            # valideer de topologie
            arcpy.AddMessage("Validate the data against the topology rules...")
            arcpy.ValidateTopology_management(TP_path)            

        # Looptijd van het script als afsluiter laten zien
        end_time = time.time()
        hours, rem = divmod(end_time - start_time, 3600)
        minutes, seconds = divmod(rem, 60)
        arcpy.AddMessage("Script succeeded. Execution took {:0>2}:{:0>2}:{:05.2f}.".format(int(hours),int(minutes),seconds))
        arcpy.AddMessage("--*END*--")                                    
        return

class VRN_Validatie(object):
    def __init__(self):
        """Define the tool (tool name is the name of the class)."""
        self.label = "VRN Validatie"
        self.description = "Deze tool is bedoeld om de VRN data te valideren ten opzichte van de regels gedefinieerd in IMNa. " + \
        "De tool werkt alleen indien gebruik wordt gemaakt van de hiervoor bestemde File Geodatabase template. " + \
        "De resultaten worden weggeschreven in een aparte feature dataset: IMNa_validatie. Correcties moeten echter in de originele feature dataset (IMNa) doorgevoerd worden! " + \
        "De dataset IMNa_validatie wordt elke keer overschreven wanneer de tool wordt uitgevoerd. Voordat het bestand wordt ingediend via het portaal, dient deze dataset verwijderd te worden. " + \
        "Meer informatie over het gebruik van de tool is te vinden in de meegeleverde handleiding. "
        self.canRunInBackground = False

    def getParameterInfo(self):
        """Define parameter definitions"""
        in_fgdb = arcpy.Parameter(
            displayName="Input File Geodatabase",
            name="Input_File_Geodatabase",
            datatype="DEWorkspace",
            parameterType="Required",
            direction="Input")
        dup_val = arcpy.Parameter(
            displayName="Validatie unieke waarden",
            name="Duplicaten_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        domein_val = arcpy.Parameter(
            displayName="Validatie domeinen en verplichte waarden",
            name="Domein_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        multipart_val = arcpy.Parameter(
            displayName="Validatie multiparts",
            name="multipart_validatie",
            datatype="GPBoolean",
            parameterType="Required",
            direction="Input")
        topology_val = arcpy.Parameter(
            displayName="Validatie topologie: overlap met referentiedata (Standard of Advanced licentie vereist!)",
            name="Topologie_validatie",
            datatype="GPBoolean",
            parameterType="Optional",
            direction="Input")
        prov = arcpy.Parameter(
            displayName="Provincie",
            name="Provincie",
            datatype="GPString",
            parameterType="Optional",
            direction="Input")
        dup_val.values = True
        domein_val.values = True
        multipart_val.values = True
        #topology_val.values = True
        prov.filter.type = "ValueList"
        prov.filter.list = ["Groningen","Friesland","Drenthe","Overijssel","Flevoland","Gelderland","Utrecht","Noord-Holland","Zuid-Holland","Zeeland","Noord-Brabant","Limburg"]
        parameters = [in_fgdb, dup_val, domein_val, multipart_val, topology_val, prov]
        parameters[5].enabled = False
        return parameters

    def isLicensed(self):
        """Set whether tool is licensed to execute."""
        return True

    def updateParameters(self, parameters):
        """Modify the values and properties of parameters before internal
        validation is performed.  This method is called whenever a parameter
        has been changed."""
        if parameters[4].value:
            parameters[5].enabled = True
        else:
            parameters[5].enabled = False
        return

    def updateMessages(self, parameters):
        """Modify the messages created by internal validation for each tool
        parameter.  This method is called after internal validation."""
        return

    def execute(self, parameters, messages):
        """The source code of the tool."""
        arcpy.AddMessage("Imported python modules.")

        # Current date time
        start_time = time.time()
        now = datetime.now()
        
        # Start script time
        start_time_str = now.strftime("%d-%m-%Y_%H:%M:%S")
        arcpy.AddMessage("--*START*--")
        arcpy.AddMessage("{0}  Starting script...".format(start_time_str))

        # Variabelen die bepalen welke validaties uitgevoerd moeten worden
        validate_duplicates = parameters[1].value
        validate_domain = parameters[2].value
        validate_multiparts = parameters[3].value
        validate_topology = parameters[4].value

        # Controleer welke licentie er beschikbaar is
        arcpy.AddMessage("Checking license...")
        if arcpy.CheckProduct("ArcInfo") == "Available" or arcpy.CheckProduct("ArcInfo") == "AlreadyInitialized":
            licensed_topology = True
        elif arcpy.CheckProduct("ArcEditor") == "Available" or arcpy.CheckProduct("ArcEditor") == "AlreadyInitialized":
            licensed_topology = True
        else:
            licensed_topology = False

        # Controleer of er een Standard of Advanced licentie beschikbaar is voor de topologie
        if validate_topology and not licensed_topology:
            arcpy.AddWarning("WARNING: No Standard or Advanced license is available. Topology cannot be validated!!!")

        # Controleer of de parameters voor de Provincie ingevuld zijn als validatie topologie is aangevinkt
        exit_execution = False
        if validate_topology and not parameters[5].value:
            arcpy.AddError("Parameter 'Provincie' is required when 'Validatie topologie' is checked!")
            exit_execution = True
        if exit_execution:
            sys.exit()

        # FGDB variabelen
        input_fgdb_path = parameters[0].valueAsText
        folder_path = os.path.dirname(os.path.abspath(input_fgdb_path)).replace('\\', '/')
        input_fgdb_name = os.path.basename(input_fgdb_path)

        # featureclass en tabel variabelen
        DS_input = "IMNa"
        DS_name = "IMNa_validatie"
        TP_name = "IMNa_topologie"
        DS_path = "{0}/{1}/{2}".format(folder_path,input_fgdb_name,DS_name)
        SR_name = arcpy.SpatialReference(28992)
        FC_list = ["GebiedNatuur", "GebiedInrichting", "GebiedVerwerving", "NatuurNetwerkNederland", "Provinciegrenzen"]
        TB_list = ["VoortgangsRapportage", "ResterendeInrichtingsAmbitie"]

        # environment settings
        arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(28992)
        arcpy.env.XYDomain ="-30515500 -30279500 4503569111870,5 4503569347870,5"
        arcpy.env.XYResolution = "0.0005 Meters"
        arcpy.env.XYTolerance = "0.001 Meters"
        arcpy.env.overwriteOutput = True

        # print break
        arcpy.AddMessage("--*Check existance*--")

        # Dataset aanmaken
        arcpy.AddMessage("Checking for previous versions of the validation dataset {0}...".format(DS_name))
        input_DS = "{0}/{1}/{2}".format(folder_path,input_fgdb_name, DS_name)
        if arcpy.Exists(input_DS):
            arcpy.AddMessage("Validation dataset present; dataset will be recreated for a new validation set.")
            try:
                arcpy.Delete_management(input_DS)
            except:
                pass
            out_sr = arcpy.CreateSpatialReference_management(SR_name)
            arcpy.AddMessage("Recreating dataset with name {0}...".format(DS_name))
            arcpy.CreateFeatureDataset_management(input_fgdb_path,DS_name,out_sr)
            arcpy.AddMessage("Dataset with name {0} has been recreated.".format(DS_name))
        else:
            arcpy.AddMessage("No validation dataset present.")
            out_sr = arcpy.CreateSpatialReference_management(SR_name)
            arcpy.AddMessage("Creating dataset with name {0}...".format(DS_name))
            arcpy.CreateFeatureDataset_management(input_fgdb_path,DS_name,out_sr)
            arcpy.AddMessage("Dataset with name {0} has been created.".format(DS_name))

        # print break
        arcpy.AddMessage("--*Adding featureclasses to validation dataset*--")

        # Kopie van de originele featureclasses toevoegen aan de validatie dataset
        for fcl in FC_list[:-1]:
            arcpy.AddMessage("Adding featureclass {0} to the validation dataset...".format(fcl))
            FCL_input = "{0}/{1}/{2}/{3}".format(folder_path,input_fgdb_name,DS_input,fcl)
            FCL_output = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,fcl)
            arcpy.Copy_management(FCL_input, FCL_output)

        # paden naar validatie fcl aanmaken
        GebiedNatuur_path = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,(FC_list[0]))
        GebiedInrichting_path = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,(FC_list[1]))
        GebiedVerwerving_path = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,(FC_list[2]))
        NatuurNetwerkNederland_path = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,(FC_list[3]))
        VoortgangsRapportage_path = "{0}/{1}/{2}".format(folder_path,input_fgdb_name,(TB_list[0]))
        #ResterendeInrichtingsAmbitie_path = "{0}/{1}/{2}".format(folder_path,input_fgdb_name,(TB_list[1]))

        # print break in between sections
        arcpy.AddMessage("--*Validating Voortgangsrapportage record*--")

        # controleer of VoortgangsRapportage en ResterendeInrichtingsAmbitie exact 1 record bevat
        def checkNoOfRecords(fgdb, tbl_path, tbl_name):
            TB_out_name = "ERRORMESSAGE_{0}".format(tbl_name)
            TB_out_path = "{0}/{1}".format(fgdb, TB_out_name)
            if arcpy.Exists(TB_out_path):
                arcpy.Delete_management(TB_out_path)
            cnt = arcpy.management.GetCount(tbl_path)[0]
            if cnt != "1":
                arcpy.CreateTable_management(fgdb, TB_out_name)
                arcpy.AddField_management(TB_out_path, "Message", "TEXT")
                with arcpy.da.InsertCursor(TB_out_path, ["Message"]) as cursor:
                    message = "Tabel {0} bevat {1} rijen, maar dient exact 1 rij te bevatten.".format(tbl_name, cnt)
                    cursor.insertRow([message])
                arcpy.AddMessage("Table {0} must contain exactly 1 record! Message is added to table {1}".format(tbl_name, TB_out_name))
            return
        
        for tbl in TB_list:
            arcpy.AddMessage("Checking the number of records in table {0}...".format(tbl))
            TB_path = "{0}/{1}/{2}".format(folder_path, input_fgdb_name, tbl)
            checkNoOfRecords(input_fgdb_path, TB_path, tbl)                

        if validate_duplicates:
            # print break 
            arcpy.AddMessage("--*Validating duplicates*--")
  
            ## controleer of er dubbele identificaties voorkomen
            # functie aanmaken
            def duplicates_validation(fcl, fcl_name, ds):
                FCL_out_name = "DUPLICATES_{0}".format(fcl_name)
                FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=SR_name)
                arcpy.AddField_management(FCL_out_path, "identificatie", "TEXT")
                arcpy.AddField_management(FCL_out_path, "OriginID", "TEXT")
                with arcpy.da.SearchCursor(FCL_path, ["identificatie","OBJECTID", "SHAPE@"]) as cursor1:
                    identifications = []
                    dup = []
                    for row in cursor1:
                        if row[0] in identifications:
                            identifications += [row[0]]
                            dup += [row[0]]
                        else:
                            identifications += [row[0]]
                with arcpy.da.SearchCursor(fcl, ["identificatie", "OBJECTID","SHAPE@"]) as cursor2, arcpy.da.InsertCursor(FCL_out_path, ["identificatie", "OriginID","SHAPE@"]) as cursor3:  
                    for row in cursor2:
                        if row[0] in dup and row[0] is not None and row[0].strip() != '':
                            cursor3.insertRow(row)
                            arcpy.AddMessage("Duplicate value '{0}' found! Record with ID {1} has been added to feature class DUPLICATES_{2}".format(row[0], str(row[1]), fcl_name))
                if arcpy.management.GetCount(FCL_out_path)[0] == "0":
                    arcpy.Delete_management(FCL_out_path)
                return
            
            # functie aanroepen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking for duplicate values in the field 'identificatie' in feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                duplicates_validation(FCL_path, fcl, DS_path)

        if validate_domain:
            # print break
            arcpy.AddMessage("--*Validating domains*--")

            # domeinen ophalen
            domains = arcpy.da.ListDomains(input_fgdb_path)

            ## Functies aanmaken voor de domein controle
            # functie voor feature classes
            def fcl_domain_validation(fgdb, fcl, fcl_name, ds, domainslist):
                FCL_out_name = "DOMAINERROR_{0}".format(fcl_name)
                FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)           
                fields = arcpy.ListFields(fcl) 
                fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape' ]
                fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                fieldlist += ['Shape@'] 
                fieldlist2 = fieldlist[:]
                fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'            
                arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                for fieldname in fieldlist2[:-1]:
                    arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")           
                with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                    for row in cursor1:
                        row_list = list(row)
                        has_errors = False
                        for i, value in enumerate(row_list):
                            fieldname = fieldlist[i]
                            for field in fields:
                                if field.name == fieldname:
                                    field_domain = field.domain
                                    field_nullable = field.isNullable
                            if field_domain != '':
                                for domain in domainslist:
                                    if domain.name == field_domain:
                                        domainvalues = domain.codedValues
                                if value not in domainvalues:
                                    if value is not None and str(value).strip() != '':
                                        row_list[i] = str(row_list[i]) + " (FOUT)"
                                        arcpy.AddMessage("{0} value '{1}' is not in the domain list! Record with ID {2} is added to feature class {3}".format(fieldlist[i], str(value), str(row_list[-2]), FCL_out_name))
                                        has_errors = True
                            if not field_nullable:
                                if value is None or str(value).strip() == '':
                                    row_list[i] = "(ONTBREEKT)"
                                    arcpy.AddMessage("Mandatory value for field {0} is missing! Record with ID {1} is added to feature class {2}".format(fieldlist[i], str(row_list[-2]), FCL_out_name))
                                    has_errors = True
                        if has_errors:
                            cursor2.insertRow(row_list)
                    if arcpy.management.GetCount(FCL_out_path)[0] == "0":
                        arcpy.Delete_management(FCL_out_path)
                return

            # aanroepen functie voor alle kaartlagen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking if values are inside the domain for feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                fcl_domain_validation(input_fgdb_path, FCL_path, fcl, DS_path, domains)

            # functie voor tabel VoortgangsRapportage
            def table_domain_validation(fgdb, tbl, tbl_name, domainslist):
                TBL_out_name = "DOMAINERROR_{0}".format(tbl_name)
                TBL_out_path = "{0}/{1}".format(fgdb, TBL_out_name)
                fields = arcpy.ListFields(tbl)
                fieldlist = [ field.name for field in fields ]
                fieldlist.append(fieldlist.pop(fieldlist.index('OBJECTID')))
                fieldlist2 = fieldlist[:]
                fieldlist2[fieldlist2.index('OBJECTID')] = 'OriginID'
                arcpy.CreateTable_management(fgdb, TBL_out_name)
                for fieldname in fieldlist2:
                    arcpy.AddField_management(TBL_out_path, fieldname, "TEXT")
                with arcpy.da.SearchCursor(tbl, fieldlist) as cursor1, arcpy.da.InsertCursor(TBL_out_path, fieldlist2) as cursor2:
                    for row in cursor1:
                        row_list = list(row)
                        has_errors = False
                        for i, value in enumerate(row_list):
                            fieldname = fieldlist[i]
                            for field in fields:
                                if field.name == fieldname:
                                    field_domain = field.domain
                                    field_nullable = field.isNullable
                            if field_domain != '':
                                for domain in domainslist:
                                    if domain.name == field_domain:
                                        domainvalues = domain.codedValues
                                if value not in domainvalues:
                                    if value is not None and str(value).strip() != '':
                                        row_list[i] = str(row_list[i]) + " (FOUT)"
                                        arcpy.AddMessage("{0} value '{1}' is not in the domain list! Record with ID {2} is added to table {3}".format(fieldlist[i], str(value), str(row_list[-1]), TBL_out_name))
                                        has_errors = True
                            if not field_nullable:
                                if value is None or str(value).strip() == '':
                                    row_list[i] = "(ONTBREEKT)"
                                    arcpy.AddMessage("Mandatory value for field {0} is missing! Record with ID {1} is added to table {2}".format(fieldlist[i], str(row_list[-1]), TBL_out_name))
                                    has_errors = True
                            if has_errors:
                                cursor2.insertRow(row_list)
                    if arcpy.management.GetCount(TBL_out_path)[0] == "0":
                        arcpy.Delete_management(TBL_out_path)
                return

            # aanroepen functie voor tabellen
            for tbl in TB_list:
                arcpy.AddMessage("Checking if values are inside the domain for table {0}...".format(tbl))
                TB_path = "{0}/{1}/{2}".format(folder_path, input_fgdb_name, tbl)
                table_domain_validation(input_fgdb_path, TB_path, tbl, domains)                

        if validate_multiparts:
            # print break
            arcpy.AddMessage("--*Validating multiparts*--")

            # functie aanmaken voor controle op multiparts
            def multipart_validation (fgdb, fcl, fcl_name, ds):
                multi_name = "MultiToSingle_{0}".format(fcl_name)
                multi_path = "{0}/{1}".format("in_memory", multi_name)
                arcpy.AddField_management(fcl, "tmpUID", "long")
                OIDFieldName = arcpy.Describe(fcl).OIDFieldName
                arcpy.CalculateField_management(fcl, "tmpUID","!" + OIDFieldName + "!", "PYTHON")
                arcpy.MultipartToSinglepart_management(fcl, multi_path)
                inCount = int(arcpy.GetCount_management(fcl).getOutput(0))
                outCount = int(arcpy.GetCount_management(multi_path).getOutput(0))
                if inCount != outCount:
                    id_values = [ row[0] for row in arcpy.da.SearchCursor(multi_path, "tmpUID") ]
                    multi_rows = [ id for id in id_values if id_values.count(id) > 1 ]
                    FCL_out_name = "MULTIPART_{0}".format(fcl_name)
                    FCL_out_path = "{0}/{1}".format(ds, FCL_out_name)
                    fields = arcpy.ListFields(fcl)
                    fieldlist = [ field.name for field in fields if field.name[:5] != 'Shape' and field.name != 'OBJECTID']
                    fieldlist += ['Shape@']
                    fieldlist2 = fieldlist[:]
                    fieldlist2[fieldlist2.index('tmpUID')] = 'OriginID'
                    arcpy.CreateFeatureclass_management(ds, FCL_out_name, geometry_type="POLYGON", spatial_reference=arcpy.SpatialReference(28992))
                    for fieldname in fieldlist2[:-1]:
                        arcpy.AddField_management(FCL_out_path, fieldname, "TEXT")
                    with arcpy.da.SearchCursor(fcl, fieldlist) as cursor1, arcpy.da.InsertCursor(FCL_out_path, fieldlist2) as cursor2:
                        for row in cursor1:
                            if row[-2] in multi_rows:
                                cursor2.insertRow(row)
                                arcpy.AddMessage("Multipart polygon found! Record with id {0} is added to feature class {1}".format(row[-2], FCL_out_name))
                arcpy.DeleteField_management(fcl, ["tmpUID"])
                return

            # functie aanroepen voor alle kaartlagen
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Checking for multipart polygons in feature class {0}...".format(fcl))
                FCL_path = "{0}/{1}_val".format(DS_path, fcl)
                multipart_validation(input_fgdb_path, FCL_path, fcl, DS_path)                

        if validate_topology and licensed_topology:
            # topologie validatie
            arcpy.AddMessage("--*Validating topology*--")

            # gekozen provincie
            prov_name = parameters[5].valueAsText

            prov_dict = {"Groningen":20,
            "Friesland":21,
            "Drenthe":22,
            "Overijssel":23,
            "Flevoland":24,
            "Gelderland":25,
            "Utrecht":26,
            "Noord-Holland":27,
            "Zuid-Holland":28,
            "Zeeland":29,
            "Noord-Brabant":30,
            "Limburg":31}

            prov_code = prov_dict[prov_name]

            # provinciegrens ophalen
            arcpy.AddMessage("Adding province layer {0} to the validation dataset...".format(prov_name))
            input_FCL_path = "{0}/{1}/{2}/{3}".format(folder_path, input_fgdb_name, DS_input, FC_list[4])
            Provincie_path = "{0}/{1}/{2}/{3}".format(folder_path, input_fgdb_name, DS_name, prov_name)
            arcpy.Select_analysis(input_FCL_path, Provincie_path, '"NUMMER_CSV" = %i' % prov_code)
            arcpy.AddMessage("Province layer {0} has been added to the validation dataset.".format(prov_name))

            # Aanmaken topology class
            arcpy.AddMessage("Creating topology class with name {0}...".format(TP_name))
            arcpy.CreateTopology_management(DS_path, TP_name)
            TP_path = "{0}/{1}/{2}/{3}".format(folder_path,input_fgdb_name,DS_name,TP_name)
            arcpy.AddMessage("Topology class {0} has been created.".format(TP_name))

            # Toevoegen featureclasses aan topology class, in een loop
            for fcl in FC_list[:-1]:
                arcpy.AddMessage("Adding featureclass {0} to the validation topology class...".format(fcl))
                FCL_input = "{0}/{1}/{2}/{3}_val".format(folder_path,input_fgdb_name,DS_name,fcl)
                arcpy.AddFeatureClassToTopology_management(TP_path, FCL_input, 1, 1)
                arcpy.AddMessage("Featureclass {0} has been added to the topology class.".format(fcl))

            # voeg Provincie toe
            arcpy.AddMessage("Adding layer {0} to the validation topology class...".format(prov_name))
            arcpy.AddFeatureClassToTopology_management(TP_path, Provincie_path, 1, 1)
            arcpy.AddMessage("Layer {0} has been added to the validation topology class.".format(prov_name))

            # Toevoegen topology rules
            # regels voor featureclass [0] GebiedNatuur
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[0]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", GebiedNatuur_path, in_featureclass2=Provincie_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[0]))

            # regels voor featureclass [1] GebiedInrichting
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[1]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", GebiedInrichting_path, in_featureclass2=Provincie_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[1]))

            # regels voor featureclass [2] GebiedVerwerving
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[2]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", GebiedVerwerving_path, in_featureclass2=Provincie_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[2]))

            # regels voor featureclass [3] NatuurNetwerkNederland
            arcpy.AddMessage("Adding topology rules for feature class {0}....".format(FC_list[3]))
            arcpy.AddRuleToTopology_management(TP_path, "Must Be Covered By (Area-Area)", NatuurNetwerkNederland_path, in_featureclass2=Provincie_path)
            arcpy.AddMessage("Topology rules have been added for feature class {0}".format(FC_list[3]))

        if licensed_topology and validate_topology:
            # valideer de data tegen de topologie regels
            arcpy.AddMessage("Validate the data against the topology rules...")
            try:
                arcpy.ValidateTopology_management(TP_path)
            except Exception as e:
                arcpy.AddError(e)
                pass
        elif validate_topology:
            arcpy.AddWarning("Topology validation has been skipped because no Standard or Advanced license is available!!!")

        # Looptijd van het script als afsluiter laten zien
        end_time = time.time()
        hours, rem = divmod(end_time - start_time, 3600)
        minutes, seconds = divmod(rem, 60)
        arcpy.AddMessage("Script succeeded. Execution took {:0>2}:{:0>2}:{:05.2f}.".format(int(hours),int(minutes),seconds))
        arcpy.AddMessage("--*END*--")




