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
	
	<!--This is for to change value of "global.templateGPKG" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateGPKG' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.templateGPKG" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateExcel" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateExcel' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.templateExcel" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of "global.templateFGDB" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateFGDB' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global.templateFGDB" /></xsl:element>
	</xsl:template>
			
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "templatefgdb" which is in the workspace "IMNa_HAB_SpecificRepairs" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='templatefgdb' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_SpecificRepairs.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/templatefgdb" /></xsl:element>
	</xsl:template>
	
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_reportFailure" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>
	
		<!--This is for to change value of the value of "Attachments_location" which is in the workspace "IMNa_HAB_Sub_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='Attachments_location' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Sub_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/attachments_location" /></xsl:element>
	</xsl:template>
	
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_HAB_Sub_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Sub_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email_messenger" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_HAB_Sub_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Sub_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtp_host" /></xsl:element>
	</xsl:template>	
	
		<!--This is for to change value of the value of "private_attachement_folder" which is in the workspace "IMNa_HAB_Sub_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='private_attachement_folder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Sub_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/private_attachement_folder" /></xsl:element>
	</xsl:template>
	
		<!--This is for to change value of the value of "public_attachement_folder" which is in the workspace "IMNa_HAB_Sub_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='public_attachement_folder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Sub_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/public_attachement_folder" /></xsl:element>
	</xsl:template>
	
			<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_HAB_Sub_Messenger" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Sub_Messenger.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/remove_temp_folder" /></xsl:element>
	</xsl:template>
	
		<!--This is for to change value of the value of "GEOPKG_FILE_LOCATION" which is in the workspace "IMNa_HAB_DownloadGeoPackage" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='GEOPKG_FILE_LOCATION' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_DownloadGeoPackage.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/geopkg_file_location" /></xsl:element>
	</xsl:template>
	
		<!--This is for to change value of the value of "FME_NDVHGEOWEBSHARE_DOCUMENT_PUBLIC" which is in the workspace "IMNa_HAB_DownloadGeoPackage" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='FME_NDVHGEOWEBSHARE_DOCUMENT_PUBLIC' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_DownloadGeoPackage.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_T0_Submission' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/fme_ndvhgeowebshare_document_public" /></xsl:element>
	</xsl:template>
	
	
</xsl:stylesheet>