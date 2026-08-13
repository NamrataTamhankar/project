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
	
	<!--This is for to change value of "global.program" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.program' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_program" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.provinceBordersTollerance" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.provinceBordersTollerance' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_provinceBordersTollerance" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateFGDB" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateFGDB' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_templateFGDB" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateExcel" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateExcel' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_templateExcel" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "templatefgdb" which is in the workspace "IMNa_NBP_SpecificRepairs" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='templatefgdb' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NBP_SpecificRepairs.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/templateFGDB" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "subsidieJaar" which is in the workspace "IMNa_NBP_SpecificProjectValidations" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='subsidieJaar' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NBP_SpecificProjectValidations.fmw'] and
		ancestor::*/type='automations'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 
		
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/subsidieJaar" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "GeoWeb_Archive" which is in the workspace "IMNa_NBP_Val_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='GeoWeb_Archive' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NBP_Val_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/geowebArchiveLocation" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_NBP_Val_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NBP_Val_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_messenger" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_NBP_Val_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NBP_Val_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_NBP_Val_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NBP_Val_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/remove_the_temp_folder" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_reportFailure" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NBP_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>
</xsl:stylesheet>
