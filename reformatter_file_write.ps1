Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Input Text"
$form.Size = New-Object System.Drawing.Size(300, 320)
$form.StartPosition = "CenterScreen"

# Create a label for file name
$fileNameLabel = New-Object System.Windows.Forms.Label
$fileNameLabel.Text = "File Name:"
$fileNameLabel.Location = New-Object System.Drawing.Point(10, 10)
$form.Controls.Add($fileNameLabel)

# Create a textbox for file name
$fileNameBox = New-Object System.Windows.Forms.TextBox
$fileNameBox.Size = New-Object System.Drawing.Size(260, 20)
$fileNameBox.Location = New-Object System.Drawing.Point(10, 30)
$form.Controls.Add($fileNameBox)

# Create a label for input text
$textLabel = New-Object System.Windows.Forms.Label
$textLabel.Text = "Input Text:"
$textLabel.Location = New-Object System.Drawing.Point(10, 60)
$form.Controls.Add($textLabel)

# Create a textbox for input text
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Multiline = $true
$textBox.Size = New-Object System.Drawing.Size(260, 100)
$textBox.Location = New-Object System.Drawing.Point(10, 80)
$form.Controls.Add($textBox)

# Create a label for test number
$testNoLabel = New-Object System.Windows.Forms.Label
$testNoLabel.Text = "Test Count:"
$testNoLabel.Location = New-Object System.Drawing.Point(10, 190)
$form.Controls.Add($testNoLabel)

# Create a textbox for test number
$testNoBox = New-Object System.Windows.Forms.TextBox
$testNoBox.Size = New-Object System.Drawing.Size(260, 20)
$testNoBox.Location = New-Object System.Drawing.Point(10, 210)
$form.Controls.Add($testNoBox)

# Create a save button
$saveButton = New-Object System.Windows.Forms.Button
$saveButton.Text = "Save to file"
$saveButton.Location = New-Object System.Drawing.Point(100, 240)
$saveButton.Add_Click({
  $inputText = $textBox.Text
  $testNo = $testNoBox.Text
  $fileName = $fileNameBox.Text
  $pythonFilePath = "d:\vscode\zybooks special\output.py"
  $pythonContent = @("if run_count == ${testNo}:`n    with open(`"$fileName`", `"w`") as file:`n")
  $inputLines = $inputText -replace "`n", "" -split "`r"
  foreach ($line in $inputLines) {
    if ($line -ne "") {
      $pythonContent += "        file.write(`"$line`\n`")"
    }
  }
  [System.IO.File]::WriteAllLines($pythonFilePath, $pythonContent)
  $form.Close()
})
$form.Controls.Add($saveButton)

# Create a Clear button
$clearButton = New-Object System.Windows.Forms.Button
$clearButton.Text = "Clear file"
$clearButton.Location = New-Object System.Drawing.Point(180, 240)
$clearButton.Add_Click({
  $pythonFilePath = "d:\vscode\zybooks special\output.py"
  [System.IO.File]::WriteAllText($pythonFilePath, "")
  $form.Close()
})
$form.Controls.Add($clearButton)

# Show the form
$form.ShowDialog()