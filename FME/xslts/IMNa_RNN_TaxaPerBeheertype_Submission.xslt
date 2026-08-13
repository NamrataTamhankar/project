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

	<!--This is for single automation in Project-->
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "trigger_folder" which is in the workspace "IMNa_RNN_Trigger.fmw" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='trigger_folder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_Trigger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/trigger_folder_location"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "Type of run" which is in the workspace "IMNa_RNN_TaxaPerBeheertype_Initializer" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='type' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_TaxaPerBeheertype_Initializer.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/etl_run_type"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "FILE" which is in the workspace "IMNa_RNN_TaxaPerBeheertype_SchemaTransformer" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='FILE' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_TaxaPerBeheertype_SchemaTransformer.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/source_file"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "PROCESSING_TYPE which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='PROCESSING_TYPE' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/etl_run_type"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_RNN_TaxaPerBeheertype_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_TaxaPerBeheertype_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email"/></xsl:element>
	</xsl:template>
	
		<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_RNN_TaxaPerBeheertype_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_TaxaPerBeheertype_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtphost"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_RNN_TaxaPerBeheertype_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_RNN_TaxaPerBeheertype_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/droptmpfolder"/></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_RNN_TaxaPerBeheertype_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtphost"/></xsl:element>
	</xsl:template>
	
</xsl:stylesheet>