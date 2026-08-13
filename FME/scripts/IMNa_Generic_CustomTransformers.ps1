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
	echo 'Publishing generic workspaces to FME Server'
	try{
		Get-ChildItem "$REPOSITORY_LOCATION/IMNa_Generic"  | 
		Foreach-Object {
			Get-ChildItem $_.FullName *.fmw 
			$filePath = $_.FullName
			$fileName = $_.Name
			# First delete and then insert
			C:\Windows\System32\curl.exe -X DELETE "$FME_SERVER_URL/fmerest/v3/repositories/IMNa_Generic/items/$fileName" -H "Accept: application/json" -H "Authorization: fmetoken token=$fmetoken"
			C:\Windows\System32\curl.exe -X POST "$FME_SERVER_URL/fmerest/v3/repositories/IMNa_Generic/items" -H "Accept: application/json" -H "Content-Disposition: attachment; filename=$fileName" -H "Authorization: fmetoken token=$fmetoken" -T "$filePath"
			echo $fileName
		}
	}
	catch{
		echo 'Error publishing generic workspaces to FME Server'
		echo $_
		break
	}

# Publish custom transformers to FME Server	
	echo 'Publishing custom transformers to FME Server'
	try{
		Get-ChildItem "$REPOSITORY_LOCATION/IMNa_CustomTransformers"  | 
		Foreach-Object {
			Get-ChildItem $_.FullName *.fmx  
			$filePath = $_.FullName
			$fileName = $_.Name
			C:\Windows\System32\curl.exe -X POST "$FME_SERVER_URL/fmerest/v3/resources/connections/FME_SHAREDRESOURCE_ENGINE/filesys/Transformers?overwrite=true" -H "Accept: application/json" -H "Content-Disposition: attachment; filename=$fileName" -H "Content-Type: application/octet-stream" -H "Authorization: fmetoken token=$fmetoken" -T "$filePath"
			echo $fileName
		}
	}
	catch{
		echo 'Error publishing custom transformers to FME Server'
		echo $_
		break
	}
