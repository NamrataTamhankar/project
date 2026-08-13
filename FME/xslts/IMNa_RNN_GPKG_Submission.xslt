<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:param name="PARAMETER_FILE"/>
	<xsl:variable name="parameters" select="document($PARAMETER_FILE)"/>
	
	<!-- For  every single node in the xml copy it into the output while applying 
		all templates -->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>
<!-- Suppress <item> where <name> is repository/shared_resource/security/named_connection/package --> 
    <xsl:template match="item[name='repository' or name='shared_resource' or name='security' or name='named_connection' or name='package']"/>
	<!--This is for single automation in Project-->
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateExcel" -->
	<xsl:template match="value[parent::attribute/name='global.templateExcel' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_templateExcel" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateGpkg" -->
	<xsl:template match="value[parent::attribute/name='global.templateGPKG' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_templateGpkg" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateFGDB" -->
	<xsl:template match="value[parent::attribute/name='global.templateFGDB' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_templateFgdb" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateExportGpkg" -->
	<xsl:template match="value[parent::attribute/name='global.templateExportGPKG' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_exporttemplateGpkg" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateExportFGDB" -->
	<xsl:template match="value[parent::attribute/name='global.templateExportFGDB' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_exporttemplateFgdb" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "type of run" which is in the workspace "IMNa_RNN_GPKG_SubmissionInitializer.fmw" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='type' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_SubmissionInitializer.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/etl_run_type"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "PROCESSING_TYPE" which is in the workspace "IMNa_ReportFailure.fmw" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='PROCESSING_TYPE' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/etl_run_type"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "drupal_archive" which is in the workspace "IMNa_RNN_GPKG_SubmissionMessenger.fmw" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='drupal_archive' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_SubmissionMessenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/attachments_location"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_RNN_GPKG_SubmissionMessenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_SubmissionMessenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email"/></xsl:element>
	</xsl:template>
	
		<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DATABASE_NAME" which is in the workspace "IMNa_RNN_GPKG_UpdateDatabase" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DATABASE_NAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_UpdateDatabase.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/database_name"/></xsl:element>
	</xsl:template>
	<!--This is for to change value of the value of "PSQL_PATH" which is in the workspace "IMNa_RNN_GPKG_UpdateDatabase" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='PSQL_PATH' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_UpdateDatabase.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/psql_path"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DB_USERNAME" which is in the workspace "IMNa_RNN_GPKG_UpdateDatabase" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DB_USERNAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_UpdateDatabase.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/db_username"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DATABASE_IP" which is in the workspace "IMNa_RNN_GPKG_UpdateDatabase" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DATABASE_IP' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_UpdateDatabase.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/database_ip"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_RNN_GPKG_SubmissionMessenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_SubmissionMessenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_RNN_GPKG_SubmissionMessenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_GPKG_SubmissionMessenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/droptmpfolder"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_GPKG_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host"/></xsl:element>
	</xsl:template>

    	
	

	
</xsl:stylesheet>