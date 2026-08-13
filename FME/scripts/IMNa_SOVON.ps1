# This script will deploy all the generic workspaces and custom transformers from  Gitlab to the destination FME Server
# Set-ExecutionPolicy RemoteSigned

# Read environment specific properties file
$RawProperties=cat $Args[0];
$PropertiesToConvert=($RawProperties -replace '\\','\\') -join [Environment]::NewLine;
$Properties=ConvertFrom-StringData $PropertiesToConvert;

$FME_SERVER_URL = $Properties.'FME_SERVER_URL'
$REPOSITORY_LOCATION = $Properties.'REPOSITORY_LOCATION'

$fmetoken=$Args[1];


# Publish workspaces to FME Server	
	    # Define a list of workspaces to exclude
# Publish workspaces to FME Server        
        $excludeWorkspaces = @('IMNa_SOVON_CreateDichtheidGeoTiff.fmw', 'IMNa_SOVON_CreateKwantielGeoTiff.fmw', 'IMNa_SOVON_DeterminDelta.fmw', 'IMNa_SOVON_DownloadGeoPackage.fmw', 'IMNa_SOVON_Initializer.fmw', 'IMNa_SOVON_SchemaTransformer.fmw', 'IMNa_SOVON_Trigger.fmw', 'IMNa_SOVON_UpdateDatabase.fmw')
	try{
		Get-ChildItem "$REPOSITORY_LOCATION/IMNa_SOVON"  | 
		Foreach-Object {
			Get-ChildItem $_.FullName *.fmw 
			$filePath = $_.FullName
			$fileName = $_.Name
			# Check if the workspace is in the exclude list
			if ($excludeWorkspaces -contains $fileName) {
					echo "Skipping $fileName"
					return
			}

			# First delete and then insert
			C:\Windows\System32\curl.exe -X DELETE "$FME_SERVER_URL/fmerest/v3/repositories/IMNa_SOVON/items/$fileName" -H "Accept: application/json" -H "Authorization: fmetoken token=$fmetoken"
			C:\Windows\System32\curl.exe -X POST "$FME_SERVER_URL/fmerest/v3/repositories/IMNa_SOVON/items" -H "Accept: application/json" -H "Content-Disposition: attachment; filename=$fileName" -H "Authorization: fmetoken token=$fmetoken" -T "$filePath"
			echo $fileName
		}
	}
	catch{
		echo 'Error publishing workspaces to FME Server'
		echo $_
		break
	}