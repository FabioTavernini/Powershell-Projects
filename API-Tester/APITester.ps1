# Import the required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a new Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "API Tester"
$form.Width = 450
$form.Height = 400

# Create a Label for the API endpoint
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,10)
$label1.Width = 80
$label1.Text = "API Endpoint:"
$form.Controls.Add($label1)

# Create a TextBox for the API endpoint
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(90,10)
$textbox.Width = 290
$form.Controls.Add($textbox)

# Create a Label for the HTTP method
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,40)
$label2.Width = 80
$label2.Text = "HTTP Method:"
$form.Controls.Add($label2)

# Create a ComboBox for the HTTP method
$combobox = New-Object System.Windows.Forms.ComboBox
$combobox.Location = New-Object System.Drawing.Point(90,40)
$combobox.Width = 290
$combobox.Items.Add("GET")
$combobox.Items.Add("POST")
$combobox.Items.Add("PUT")
$combobox.Items.Add("DELETE")
$form.Controls.Add($combobox)

# Create a Label for the request body
$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(10,70)
$label3.Width = 80
$label3.Text = "Request Body:"
$form.Controls.Add($label3)

# Create a TextBox for the request body
$bodytextbox = New-Object System.Windows.Forms.TextBox
$bodytextbox.Location = New-Object System.Drawing.Point(90,70)
$bodytextbox.Width = 290
$bodytextbox.Height = 200
$bodytextbox.Multiline = $true
$form.Controls.Add($bodytextbox)

# Create a Button for sending the request
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(310,280)
$button.Width = 60
$button.Text = "Send"
$button.Add_Click({
    if ($combobox.SelectedItem -eq "POST" -or $combobox.SelectedItem -eq "PUT") {
        $response = Invoke-RestMethod -Uri $textbox.Text -Method $combobox.SelectedItem -Body $bodytextbox.Text
    } else {
        $response = Invoke-RestMethod -Uri $textbox.Text -Method $combobox.SelectedItem
    }
    # Show the response in a message box
    [System.Windows.Forms.MessageBox]::Show($response)
})
$form.Controls.Add($button)

$form.ShowDialog()
