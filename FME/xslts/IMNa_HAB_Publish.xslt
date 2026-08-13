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
	
	<!--This is for to change value of "global.templateGPKG" -->
	<!--This is for single automation in Project-->
	<xsl:template match="value[parent::attribute/name='global.templateGPKG' and 
		parent::attribute/parent::attributes/parent::item/type='globals' and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/name='globals'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish'  
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/global_templateGPKG" /></xsl:element>
	</xsl:template>
			
	<!--This is for to change value of the value of "DIRWATCH_PATH"  -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DIRWATCH_PATH' 
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/dirwatch_path" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "GEOPKG_FILE_LOCATION" which is in the workspace "IMNa_HAB_DownloadGeoPackage" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='GEOPKG_FILE_LOCATION' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_DownloadGeoPackage.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/geopkg_file_location" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "NDVHGEOWEBSHARE_DOCUMENT_PUBLIC" which is in the workspace "IMNa_HAB_DownloadGeoPackage" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='FME_NDVHGEOWEBSHARE_DOCUMENT_PUBLIC' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_DownloadGeoPackage.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/public_document_location" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ALL_CACHE_FILE_LOCATION" which is in the workspace "IMNa_HAB_Publish_CopyCacheFile" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ALL_CACHE_FILE_LOCATION' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Publish_CopyCacheFile.fmw'] and
		ancestor::*/type='automations'
		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 
		
		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/all_cache_file_location" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "PUBLIC_CACHE_FILE_LOCATION" which is in the workspace "IMNa_HAB_Publish_CopyCacheFile" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='PUBLIC_CACHE_FILE_LOCATION' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Publish_CopyCacheFile.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/public_cache_file_location" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DB_SERVER_IP" which is in the workspace "IMNa_HAB_Publish_UpdateDatamart" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DB_SERVER_IP' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Publish_UpdateDatamart.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/database_ip" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DB_USERNAME" which is in the workspace "IMNa_HAB_Publish_UpdateDatamart" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DB_USERNAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Publish_UpdateDatamart.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/db_username" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "DATABASE_NAME" which is in the workspace "IMNa_HAB_Publish_UpdateDatamart" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DATABASE_NAME' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Publish_UpdateDatamart.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/database_name" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "PSQL_PATH" which is in the workspace "IMNa_HAB_Publish_UpdateDatamart" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='PSQL_PATH' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Publish_UpdateDatamart.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/psql_path" /></xsl:element>
	</xsl:template>
	<!--This is for to change value of the value of "DropTmpFolder" which is in the workspace "IMNa_HAB_Publish_Messenger" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='DropTmpFolder' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_HAB_Publish_Messenger.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/remove_temp_folder" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "ADMIN_EMAIL" which is in the workspace "IMNa_ReportFailure" -->	
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='ADMIN_EMAIL' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] and
		ancestor::*/type='automations' 
				and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/admin_email" /></xsl:element>
	</xsl:template>
	
	<!--This is for to change value of the value of "SMTP_HOST" which is in the workspace "IMNa_ReportFailure" -->
	<xsl:template match="value[parent::attribute/name='value' and 
		parent::attribute/parent::attributes/parent::item/name='SMTP_HOST' and
		parent::attribute/parent::attributes/parent::item/parent::items/descendant::item[name='WORKSPACE' and descendant::attributes/attribute/value = 'IMNa_ReportFailure.fmw'] 
		 and ancestor::*/type='automations' 
		 		and parent::attribute/parent::attributes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/parent::items/parent::itemtype/parent::itemtypes/parent::item/attributes/attribute/value='IMNa_HAB_Publish' 

		]">
		<xsl:element name="value"><xsl:value-of select="$parameters/parameters/smtphost" /></xsl:element>
	</xsl:template>
	
</xsl:stylesheet>