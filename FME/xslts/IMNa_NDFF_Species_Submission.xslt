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
			
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "NDFF_URL" which is in the workspace "IMNa_NDFF_SchemaTransformer" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='NDFF_URL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_SchemaTransformer.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/ndffUrl" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "NDFF_URL" which is in the workspace "IMNa_NDFF_Rodelijstsoort_SchemaTransformer" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='NDFF_URL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_Rodelijstsoort_SchemaTransformer.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/ndffrodelijstUrl" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DATABASE_IP" which is in the workspace "IMNa_NDFF_UpdateDatabase" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DATABASE_IP' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_UpdateDatabase.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/database_IP" /></xsl:element>
	</xsl:template>	
	
		<!--This is for to change value of the value of "PSQL_PATH" which is in the workspace "IMNa_NDFF_UpdateDatabase" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='PSQL_PATH' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_UpdateDatabase.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/psql_path" /></xsl:element>
	</xsl:template>	
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_NDFF_UpdateDatabase" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_UpdateDatabase.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_NDFF_UpdateDatabase" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_UpdateDatabase.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email" /></xsl:element>
	</xsl:template>	
	
	<!--This is for to change value of the value of "ENVIRONMENT_NAME" which is in the workspace "IMNa_NDFF_UpdateDatabase" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ENVIRONMENT_NAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_UpdateDatabase.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/environment_name" /></xsl:element>
	</xsl:template>
	
   <!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_NDFF_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>
	
	 <!--This is for to change value of the value of "ENVIRONMENT_NAME" which is in the workspace "IMNa_NDFF_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ENVIRONMENT_NAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/environment_name" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_NDFF_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email" /></xsl:element>
	</xsl:template>	
	
	<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_NDFF_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/droptmpfolder" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_reportFailure" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "trigger_folder" which is in the workspace "IMNa_NDFF_Trigger.fmw" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='trigger_folder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_NDFF_Trigger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_NDFF_Species_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/trigger_folder_location" /></xsl:element>
	</xsl:template>
</xsl:stylesheet>