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
	
	<!--This is for to change value of "global.DSO_VERSION" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.DSO_VERSION' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.dso_version" /></xsl:element>
	</xsl:template>
			
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "trigger_folder" which is in the workspace "IMNa_DSO_Trigger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='trigger_folder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_Trigger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/trigger_folder" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DSO-URL" which is in the workspace "IMNa_DSO_SchemaTransformerV2" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DSO-URL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_SchemaTransformerV2.fmw'] and
		ancestor::*/type='automations'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 
		
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dso-url" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "X-API-KEY" which is in the workspace "IMNa_DSO_SchemaTransformerV2" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='X-API-KEY' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_SchemaTransformerV2.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/x-api-key" /></xsl:element>
	</xsl:template>
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_DSO_SchemaTransformerV2" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_SchemaTransformerV2.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_schema_transformer" /></xsl:element>
	</xsl:template> 
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_DSO_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_DSO_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtphost" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_DSO_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/droptmpfolder" /></xsl:element>
	</xsl:template>
	
		<!--This is for to change value of the value of "ENVIRONMENT_NAME" which is in the workspace "IMNa_DSO_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ENVIRONMENT_NAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/environment_name" /></xsl:element>
	</xsl:template>
	
			<!--This is for to change value of the value of "ENVIRONMENT" which is in the workspace "IMNa_DSO_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ENVIRONMENT' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_DSO_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/environment" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_report_failure" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_DSO_Workitems_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtphost" /></xsl:element>
	</xsl:template>
	
</xsl:stylesheet>
