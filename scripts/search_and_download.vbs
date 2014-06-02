' Title: search_and_download.vbs
' Author: Jacob Carey
' Date: 3-19-14
' Description: 
'	Downloads new extracts from outlook
'	and saves the extracts to the extracts
' 	path. This script is called via main.py

' Set up variables to access outlook
Set olApp = CreateObject("Outlook.Application")
Set xlApp = CreateObject("Excel.Application")
Set olNs = olApp.GetNamespace("MAPI")
Set olInbox = olNs.GetDefaultFolder(6)

' Set up FSO to read/write to text file 
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Read date of last search from text file
Set objInputFile = objFSO.OpenTextFile("search_time.txt", 1)
last_search = objInputFile.ReadLine
objInputFile.Close

' Write current date time to text file
Set objOutputFile = objFSO.OpenTextFile("search_time.txt", 2)
objOutputFile.WriteLine(Now)
objOutputFile.Close

' Get absolute path of extracts folder
' in order to save new extract CSVs there
extracts_path = objFSO.GetAbsolutePathName("..") _
	& "\extracts\"
	
visits_path = objFSO.GetAbsolutePathName("..") _
	& "\visits\"
	
' Count number of new emails with this variable
message_count = 0

' subject to search for
subj_prk = "Personalization Rule Key Data Extract"
Set subj_prk_repull = New RegExp
subj_prk_repull.IgnoreCase = TRUE
subj_prk_repull.Global = FALSE
subj_prk_repull.Pattern = "Personalized Rule Key * repull *"
subj_visit = "Visits to Pages with Personalization"

Set subj_deal = New RegExp
subj_deal.IgnoreCase = TRUE
subj_deal.Global = FALSE
subj_deal.Pattern = "*week* deal* report*"
	
For Each olMsg in olInbox.Items	
	If (InStr(olMsg.subject, subj_prk) > 0 or _
		subj_prk_repull.Test(olMsg.subject) = TRUE) And _
	DateDiff("s", last_search, olMsg.CreationTime) > 0 Then
		With olMsg.Attachments
			If .Count > 0 Then
				num_file = 0
							
				For i = 1 To olMsg.Attachments.Count
					If InStr(.Item(i).FileName, ".csv") > 0 or _
						InStr(.Item(i).FileName, ".zip") > 0 Then
						num_file = i
						Exit For
					End If
				Next
				
				'Handle instances where there is no csv attached
				If num_file > 0 Then
					message_count = message_count + 1
					.Item(num_file).SaveAsFile extracts_path & _
					.Item(num_file).FileName
					
					' Handle zipped files
					If InStr(.Item(i).FileName, ".zip") > 0 Then
						' Unzip CSV to extracts_path
						Extract extracts_path & .Item(num_file).FileName, extracts_path
						' Delete zip file
						objFSO.DeleteFile(extracts_path & .Item(num_file).FileName)
					End If
				End If
			End If
		End With
	
	ElseIf InStr(olMsg.subject, subj_visit) > 0 And _
	DateDiff("s", last_search, olMsg.CreationTime) > 0 Then
		With olMsg.Attachments
			If .Count > 0 Then
								
				num_file = 0
							
				For i = 1 To olMsg.Attachments.Count
					If InStr(.Item(i).FileName, ".xlsx") > 0 Then
						num_file = i
						Exit For
					End If
				Next
				
				'Handle instances where there is no xlsx attached
				If num_file > 0 Then
					message_count = message_count + 1
											
					msgDate = Replace(FormatDateTime(CDate(olMsg.CreationTime), 2), "/", "-")
													
					.Item(num_file).SaveAsFile visits_path & msgDate & .Item(num_file).FileName
					
					Set xlBook = xlApp.Workbooks.Open(visits_path & msgDate & .Item(num_file).FileName)
					Set xlSheet = xlBook.Sheets(1)
					
					Set objOutputFile = objFSO.OpenTextFile(Replace(visits_path & msgDate & .Item(num_file).FileName, ".xlsx", ".txt"), 2, TRUE)
									
					Start_Data = FALSE
					End_Sheet = FALSE
					
					i = 1
					
					Do While End_Sheet = False
						If Start_Data = TRUE Then
							If xlSheet.Cells(i, 1).Value = "" Then
								End_Sheet = TRUE
								Exit Do
							End If
							
							item_date = CDate(xlSheet.Cells(i, 2).Value)
							
							strYYYY = DatePart("yyyy", item_date)
							strMM = Right("0" & DatePart("m", item_date), 2)
							strDD = Right("0" & DatePart("d", item_date), 2)
							csv_row = strYYYY & "-" & strMM & "-" & strDD
													
							For j = 3 To 9
								csv_row = csv_row & "," & xlSheet.Cells(i, j).Value
							Next
							
							objOutputFile.WriteLine(csv_row)
							
						End If
					
						If xlSheet.Cells(i, 2) = "Total" Then
							Start_Data = TRUE
						End If
						
						i = i + 1
						
					Loop
					
					objOutputFile.Close
					xlApp.Quit
				End If
				
			End If
		End With	
		
	REM ElseIf subj_deal.Test(olMsg.subject) = TRUE And _
	REM DateDiff("s", last_search, olMsg.CreationTime) > 0 Then
		REM With olMsg.Attachments
			REM If .Count > 0 Then
								
				REM num_file = 0
							
				REM For i = 1 To olMsg.Attachments.Count
					REM If InStr(.Item(i).FileName, ".xlsx") > 0 Then
						REM num_file = i
						REM Exit For
					REM End If
				REM Next
				
				REM 'Handle instances where there is no xlsx attached
				REM If num_file > 0 Then
					REM message_count = message_count + 1
											
					REM .Item(num_file).SaveAsFile visits_path & .Item(num_file).FileName
					
					REM Set xlBook = xlApp.Workbooks.Open(visits_path & .Item(num_file).FileName)
					REM Set xlSheet = xlBook.Sheets(2)
					
					REM Set objOutputFile = objFSO.OpenTextFile(Replace(visits_path & .Item(num_file).FileName, ".xls", ".txt"), 2, TRUE)
									
					REM End_Sheet = FALSE
					
					REM i = 1
					
					REM Do While End_Sheet = False
						REM If Start_Data = TRUE Then
							REM If xlSheet.Cells(i, 1).Value = "" Then
								REM End_Sheet = TRUE
								REM Exit Do
							REM End If
							
							REM item_date = CDate(xlSheet.Cells(i, 2).Value)
							
							REM strYYYY = DatePart("yyyy", item_date)
							REM strMM = Right("0" & DatePart("m", item_date), 2)
							REM strDD = Right("0" & DatePart("d", item_date), 2)
							REM csv_row = strYYYY & "-" & strMM & "-" & strDD
													
							REM For j = 3 To 9
								REM csv_row = csv_row & "," & xlSheet.Cells(i, j).Value
							REM Next
							
							REM objOutputFile.WriteLine(csv_row)
							
						REM End If
					
						REM If xlSheet.Cells(i, 2) = "Total" Then
							REM Start_Data = TRUE
						REM End If
						
						REM i = i + 1
						
					REM Loop
					
					REM objOutputFile.Close
					REM xlApp.Quit
				REM End If
				
			REM End If
		REM End With	
		
	End If
	
Next

' Write output to console via std out
Set StdOut = objFSO.GetStandardStream(1)
StdOut.WriteLine "Downloaded " & message_count & " file(s)."

Sub Extract( ByVal myZipFile, ByVal myTargetDir )
' Function to extract all files from a compressed "folder"
' (ZIP, CAB, etc.) using the Shell Folders' CopyHere method
' (http://msdn2.microsoft.com/en-us/library/ms723207.aspx).
' All files and folders will be extracted from the ZIP file.
' A progress bar will be displayed, and the user will be
' prompted to confirm file overwrites if necessary.
'
' Note:
' This function can also be used to copy "normal" folders,
' if a progress bar and confirmation dialog(s) are required:
' just use a folder path for the "myZipFile" argument.
'
' Arguments:
' myZipFile    [string]  the fully qualified path of the ZIP file
' myTargetDir  [string]  the fully qualified path of the (existing) destination folder
'
' Based on an article by Gerald Gibson Jr.:
' http://www.codeproject.com/csharp/decompresswinshellapics.asp
'
' Written by Rob van der Woude
' http://www.robvanderwoude.com

    Dim intOptions, objShell, objSource, objTarget

    ' Create the required Shell objects
    Set objShell = CreateObject( "Shell.Application" )

    ' Create a reference to the files and folders in the ZIP file
    Set objSource = objShell.NameSpace( myZipFile ).Items( )

    ' Create a reference to the target folder
    Set objTarget = objShell.NameSpace( myTargetDir )

    ' These are the available CopyHere options, according to MSDN
    ' (http://msdn2.microsoft.com/en-us/library/ms723207.aspx).
    ' On my test systems, however, the options were completely ignored.
    '      4: Do not display a progress dialog box.
    '      8: Give the file a new name in a move, copy, or rename
    '         operation if a file with the target name already exists.
    '     16: Click "Yes to All" in any dialog box that is displayed.
    '     64: Preserve undo information, if possible.
    '    128: Perform the operation on files only if a wildcard file
    '         name (*.*) is specified.
    '    256: Display a progress dialog box but do not show the file
    '         names.
    '    512: Do not confirm the creation of a new directory if the
    '         operation requires one to be created.
    '   1024: Do not display a user interface if an error occurs.
    '   4096: Only operate in the local directory.
    '         Don't operate recursively into subdirectories.
    '   8192: Do not copy connected files as a group.
    '         Only copy the specified files.
    intOptions = 256

    ' UnZIP the files
    objTarget.CopyHere objSource, intOptions

    ' Release the objects
    Set objSource = Nothing
    Set objTarget = Nothing
    Set objShell  = Nothing
End Sub