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
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.program" /></xsl:element>
	</xsl:template>
	
	
	<!--This is for to change value of "global.bronType" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.bronType' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.bronType" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.provinceBordersTollerance" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.provinceBordersTollerance' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.provinceBordersTollerance" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateExcel" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateExcel' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.templateExcel" /></xsl:element>
	</xsl:template>
	
		<!--This is for to change value of "global.templateFGDB" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateFGDB' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.templateFGDB" /></xsl:element>
	</xsl:template>
			
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DUTCH_BORDER" which is in the workspace "IMNa_OutsideBorderValidation" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DUTCH_BORDER' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_OutsideBorderValidation.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dutch_border" /></xsl:element>
	</xsl:template>
	
	
	<!--This is for to change value of the value of "drupal_archive" which is in the workspace "IMNa_IKN_ValidationMessenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='drupal_archive' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_IKN_ValidationMessenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/drupal_archive" /></xsl:element>
	</xsl:template>
	
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_IKN_ValidationMessenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_IKN_ValidationMessenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtphost" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_IKN_ValidationMessenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_IKN_ValidationMessenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email" /></xsl:element>
	</xsl:template>
	
	
	<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_IKN_ValidationMessenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_IKN_ValidationMessenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/droptmpfolder" /></xsl:element>
	</xsl:template>
	
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_report_failure" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_IKN_FGDB_Validation' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtphost" /></xsl:element>
	</xsl:template>
	
</xsl:stylesheet>
