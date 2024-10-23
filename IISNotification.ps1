# Specify the application URL and email settings
$applicationUrl = "http://localhost:8085"  # Your application's URL
$recipientEmail = "recipient@example.com"  # Who will receive the email
$smtpUser = "yourgmail@gmail.com"          # Your Gmail address
$smtpPass = "your-app-password"            # Your Gmail App Password
$smtpServer = "smtp.gmail.com"
$smtpPort = 587

# Send an email function
function Send-Notification {
    param (
        [string]$message
    )
    
    # Prepare the email message
    $emailMessage = New-Object system.net.mail.mailmessage
    $emailMessage.from = $smtpUser
    $emailMessage.To.add($recipientEmail)
    $emailMessage.Subject = "React Application Down Alert"
    $emailMessage.Body = $message

    # Configure the SMTP client
    $smtpClient = New-Object system.net.mail.smtpclient($smtpServer, $smtpPort)
    $smtpClient.EnableSsl = $true
    $smtpClient.Credentials = New-Object System.Net.NetworkCredential($smtpUser, $smtpPass)

    try {
        # Attempt to send the email
        $smtpClient.Send($emailMessage)
        Write-Host "Email sent successfully."
    } catch {
        Write-Host "Failed to send email. Error: $_"
    }
}

# Check if the application is running
try {
    Write-Host "Checking the application status..."
    
    # Check the URL's status
    $response = Invoke-WebRequest -Uri $applicationUrl -UseBasicParsing
    
    if ($response.StatusCode -eq 200) {
        Write-Host "Application is running successfully. Status Code: 200"
    } else {
        Write-Host "Application returned non-200 status code: $($response.StatusCode)"
        Send-Notification "The React application is down! Status Code: $($response.StatusCode)"
    }
} catch {
    # Catch any errors in reaching the application
    Write-Host "Failed to reach the application. Sending notification..."
    Send-Notification "The React application is not responding!"
}

# Pause to keep the window open for debugging
Read-Host "Press Enter to close the window"
