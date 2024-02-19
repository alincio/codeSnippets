# Load the required assembly for creating a GUI
Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Change Date'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

# Create a label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Enter the number of days to add in positive numbers `nand to substract in negative numbers:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10,20)
$form.Controls.Add($label)

# Create a text box for user input
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,50)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

# Create a button that will change the date when clicked
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10,100)
$button.Size = New-Object System.Drawing.Size(260,30)
$button.Text = 'Change Date'
$form.Controls.Add($button)

# Define the button click event
$button.Add_Click({
    # Get the current date
    $CurrentDate = Get-Date

    # Subtract the input number of days from the current date
    $DaysToChange = [int]$textBox.Text
    $NewDate = $CurrentDate.AddDays($DaysToChange)

    # Set the new date
    Set-Date -Date $NewDate

    # Display the new date with a popup
    [System.Windows.Forms.MessageBox]::Show("The new date is: $($NewDate.ToString('yyyy-MM-dd'))")
})

# Show the form
$form.ShowDialog()
