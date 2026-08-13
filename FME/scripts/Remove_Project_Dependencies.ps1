param (
    [string]$PROJECT_FILE,
    [string]$AUTOMATION_NAME
)
#Remove files directory and empty the files.map	
	echo 'Delete the Files directory'
	$filesDir = "$PROJECT_FILE\$AUTOMATION_NAME\temp\files"
	if ($filesDir) {
    Remove-Item $filesDir -Recurse -Force
    echo 'Deleted Files directory.'
	} else {
		echo 'Files directory not found.'
	}
	echo 'Empty the files.map'
	$filesMapPath = "$PROJECT_FILE\$AUTOMATION_NAME\temp\files.map"
	if ($filesMapPath) {
		Set-Content -Path $filesMapPath -Value ""
		echo 'Cleared contents of files.map.'
	} else {
		echo 'files.map not found.'
	}

# Update project yaml file	
	$path = "$PROJECT_FILE\$AUTOMATION_NAME\temp\project.yml"
	$lines = Get-Content $path
	$output = @()
	$keep = $true

	foreach ($line in $lines) {
		if ($line -match '^project_content:') {
			$output += $line
			$output += "  automations:"
			$output += "  - $AUTOMATION_NAME"
			$output += "  projects:"
			$output += "  - $AUTOMATION_NAME"
			$keep = $false
		}
		elseif ($line -match '^(fsproject_version|version|fme_server_encryption_mode):') {
			$keep = $true
			$output += $line
		}
		elseif ($keep) {
			$output += $line
		}
	}

	Set-Content $path $output
	echo 'Updated the yaml file'
