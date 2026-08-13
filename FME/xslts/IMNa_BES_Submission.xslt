<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:param name="PARAMETER_FILE"/>
	<xsl:variable name="parameters" select="document($PARAMETER_FILE)"/>
	
	<!-- For every single node in the xml copy it into the output while applying 
		all templates -->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>
	<!-- Suppress <item> where <name> is repository/shared_resource/security/named_connection/package -->
    <xsl:template match="item[name='repository' or name='shared_resource' or name='security' or name='named_connection' or name='package']"/>
	
	<!--This is for to change value of "global.program" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.program' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_program" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.provinceBordersTollerance" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.provinceBordersTollerance' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_provinceBordersTollerance" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateFGDB" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateFGDB' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_templateFGDB" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateExcel" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateExcel' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_templateExcel" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "templatefgdb" which is in the workspace "IMNa_BES_SpecificRepairs" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='templatefgdb' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_SpecificRepairs.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/templateFGDB" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DB_SERVER_IP" which is in the workspace "IMNa_BES_Sub_UpdateDatabase" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DB_SERVER_IP' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_UpdateDatabase.fmw'] and
		ancestor::*/type='automations'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 
		
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/database_ip" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "PSQL_PATH" which is in the workspace "IMNa_BES_Sub_UpdateDatabase" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='PSQL_PATH' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_UpdateDatabase.fmw'] and
		ancestor::*/type='automations'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 
		
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/psql_path" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DATABASE_NAME" which is in the workspace "IMNa_BES_Sub_UpdateDatabase" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DATABASE_NAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_UpdateDatabase.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/database_name" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DB_USERNAME" which is in the workspace "IMNa_BES_Sub_UpdateDatabase" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DB_USERNAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_UpdateDatabase.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/db_username" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "XLSX_TEMPLATE" which is in the workspace "IMNa_BES_Sub_UpdateReport" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='XLSX_TEMPLATE' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_UpdateReport.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/xlsx_template" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "GeoWeb_Archive" which is in the workspace "IMNa_BES_Sub_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='GeoWeb_Archive' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/geowebArchiveLocation" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_BES_Sub_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_messenger" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_BES_Sub_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_BES_Sub_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_BES_Sub_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/remove_the_temp_folder" /></xsl:element>
	</xsl:template>
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_reportFailure" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_BES_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>
</xsl:stylesheet>
