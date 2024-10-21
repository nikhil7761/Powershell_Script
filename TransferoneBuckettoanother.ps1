# Load the AWS PowerShell module
Import-Module AWSPowerShell

# Define the source and destination S3 URIs
$sourceUri = "s3://databasebackuprdsebank/DailyBackupDB/Jathbkp/MONDAYJATH.rar"
$destinationUri = "s3://databasebackuprdsebank/SixMonthsBackupDb/MONDAYJATH.rar"

# Copy the file from the source to the destination
Copy-S3Object -SourceBucket "databasebackuprdsebank" `
               -SourceKey "DailyBackupDB/Jathbkp/MONDAYJATH.rar" `
               -DestinationBucket "databasebackuprdsebank" `
               -DestinationKey "SixMonthsBackupDb/MONDAYJATH.rar"

# Output a message indicating completion
Write-Host "File transferred from $sourceUri to $destinationUri"
