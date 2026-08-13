# This script will deploy all the workspaces and FME project containing automations from Gitlab to the destination FME Server
# Set-ExecutionPolicy RemoteSigned

# Read environment specific properties file
$RawProperties=cat $Args[0];
$PropertiesToConvert=($RawProperties -replace '\\','\\') -join [Environment]::NewLine;
$Properties=ConvertFrom-StringData $PropertiesToConvert;

$PROJECT_FILE = $Properties.'PROJECT_FILE'
$JRE_HOME = $Properties.'JRE_HOME'
$SAXON_HOME = $Properties.'SAXON_HOME'
$XSLT_FILE = $Properties.'XSLT_FILE'
$FME_SERVER_URL = $Properties.'FME_SERVER_URL'
$REPOSITORY_LOCATION = $Properties.'REPOSITORY_LOCATION'
$PROPERTIES_FILE = $Properties.'PROPERTIES_FILE'
$PARAMETER_FILE = $Properties.'PARAMETER_FILE_IMNa_IKN_FGDB_Submission'
$AUTOMATION_NAME = 'IMNa_IKN_FGDB_Submission'

$fmetoken=$Args[1];

$ErrorActionPreference = "Stop"

# Unzip project file
	echo "Unzipping $AUTOMATION_NAME.fsproject file"
	try{
		Rename-Item -Path $PROJECT_FILE\$AUTOMATION_NAME.fsproject -NewName ("$AUTOMATION_NAME.fsproject" -replace ".fsproject", ".zip")
		Expand-Archive -Path $PROJECT_FILE\$AUTOMATION_NAME.zip -DestinationPath $PROJECT_FILE\$AUTOMATION_NAME\temp\
		#C:\Windows\System32\timeout /t 2
		del $PROJECT_FILE\$AUTOMATION_NAME.zip
	}
	catch{
		echo "Error unzipping $AUTOMATION_NAME.fsproject file"
		echo $_
		break
	}
 
# Apply xslt to xml data file 
	echo 'Appling xslt to xml data file'
	try{
		Invoke-Expression "$JRE_HOME\java.exe -jar $SAXON_HOME\saxon-he-12.3.jar -s:$PROJECT_FILE\$AUTOMATION_NAME\temp\data.xml -xsl:$XSLT_FILE\$AUTOMATION_NAME.xslt -o:$PROJECT_FILE\$AUTOMATION_NAME\temp\data.xml PARAMETER_FILE=$PROPERTIES_FILE/$PARAMETER_FILE" 
		#C:\Windows\System32\timeout /t 2
	}
	catch{
		echo 'Error appling xslt to xml data file'
		echo $_
		break
	}

# Zip project file
	echo 'Zipping project file'
	try{
		Compress-Archive -Path $PROJECT_FILE\$AUTOMATION_NAME\temp\* -DestinationPath $PROJECT_FILE\$AUTOMATION_NAME.zip
		#C:\Windows\System32\timeout /t 2
		Rename-Item -Path $PROJECT_FILE\$AUTOMATION_NAME.zip -NewName ("$AUTOMATION_NAME.zip" -replace ".zip", ".fsproject")
		Remove-Item -Path $PROJECT_FILE\$AUTOMATION_NAME -Recurse
	}
	catch{
		echo 'Eror zipping project file'
		echo $_
		break
	}
	
# Publish workspaces to FME Server	
	echo 'Publishing workspaces to FME Server'
	try{
		Get-ChildItem "$REPOSITORY_LOCATION"  | 
		Foreach-Object {
			$folder = $_.Name
			if ( 'IMNa_IKN' -eq $folder ){
				Get-ChildItem $_.FullName *.fmw | 
				Foreach-Object {
					$filePath = $_.FullName
					$fileName = $_.Name
					# First delete and then insert
					C:\Windows\System32\curl.exe -X DELETE "$FME_SERVER_URL/fmerest/v3/repositories/$folder/items/$fileName" -H "Accept: application/json" -H "Authorization: fmetoken token=$fmetoken"
					C:\Windows\System32\curl.exe -X POST "$FME_SERVER_URL/fmerest/v3/repositories/$folder/items" -H "Accept: application/json" -H "Content-Disposition: attachment; filename=$fileName" -H "Authorization: fmetoken token=$fmetoken" -T "$filePath"
					echo $fileName
				}
			}
		}
	}
	catch{
		echo 'Error publishing workspaces to FME Server'
		echo $_
		break
	}

# Import project to FME Server
	echo 'Importing project to FME Server'
	try{
		C:\Windows\System32\curl.exe -X POST "$FME_SERVER_URL/fmerest/v3/projects/import/upload?disableProjectItems=false&importMode=UPDATE&pauseNotifications=true&projectsImportMode=UPDATE" -H "Content-Type:application/octet-stream" -H "Content-Disposition:attachment; filename='$AUTOMATION_NAME.fsproject'" -H "Authorization:fmetoken token=$fmetoken" -T "$PROJECT_FILE\$AUTOMATION_NAME.fsproject"
	}
	catch{
		echo 'Error importing project to FME Server'
		echo $_
	}
	
