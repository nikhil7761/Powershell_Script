# Specify the application URL
$applicationUrl = "http://localhost:8045"  # Your application's URL

# Check if the application is running
try {
    Write-Host "Checking the application status..."
    
    # Make a request to the application URL
    $response = Invoke-WebRequest -Uri $applicationUrl -UseBasicParsing
    
    # If the status code is 200, the application is running
    if ($response.StatusCode -eq 200) {
        Write-Host "Application is running successfully. Status Code: 200"
    } else {
        Write-Host "Application returned a non-200 status code: $($response.StatusCode)"
    }
} catch {
    # If there's an error (e.g., the app isn't running), report it
    Write-Host "Failed to reach the application. It may be down."
}

# Pause to keep the window open for review
Read-Host "Press Enter to close the window"
