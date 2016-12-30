tell application "Finder"
	-- Setting current folder path for creating folder with date and move files into.
	--set picturePath to folder "unsorted" of desktop
	set picturePath to folder (choose folder with prompt "Please select the folder you want to arrange. 請選擇要整理的資料夾")
	set objectFiles to files of picturePath
	set picturesString to "pictures"
	set videoString to "video"
	set rawString to "raw"
	
	--set selectedItem to item 1 of picturePath
	--set creationTime to the creation date of selectedItem
	
	repeat with selectedFile in objectFiles
		
		if (kind of selectedFile is not "Folder") then
			
			set creationTime to the creation date of selectedFile
			
			-- Get the creation date of the file.
			set createdYear to year of creationTime
			set createdMonth to ((month of creationTime) * 1)
			set createdDay to day of creationTime
			set tempDate to (createdYear * 10000 + createdMonth * 100 + createdDay) as string
			set createdDate to (text 1 thru 4 of tempDate) & "-" & (text 5 thru 6 of tempDate) & "-" & (text 7 thru 8 of tempDate) as string
			
			
			--Check if there already have the same date folder.
			if not (exists folder createdDate of picturePath) then
				make new folder at picturePath with properties {name:createdDate}
			end if
			
			
			--在每個子資料夾下建立Video, Picture and RAW folders, 
			--then check their document type (kind)
			--to move it relatively.
			
			
			set createdDateFolder to folder createdDate of picturePath
			
			
			
			--Check JPEG file and move it to pictures folder
			if (kind of selectedFile is "JPEG image") then
				if not (exists folder picturesString of createdDateFolder) then
					make new folder at createdDateFolder with properties {name:picturesString}
				end if
				move selectedFile to the folder picturesString of createdDateFolder
				
				
				--Check video file and move it to video folder
			else if (kind of selectedFile is "QuickTime movie" or kind of selectedFile is "MPEG-4 movie") then
				if not (exists folder videoString of createdDateFolder) then
					make new folder at createdDateFolder with properties {name:videoString}
				end if
				move selectedFile to the folder videoString of createdDateFolder
				
				
				--Check RAW file and move it to raw folder
			else if (kind of selectedFile is "Canon Camera Raw file") then
				if not (exists folder rawString of createdDateFolder) then
					make new folder at createdDateFolder with properties {name:rawString}
				end if
				move selectedFile to the folder rawString of createdDateFolder
			end if
			
			
			
			--if there have files with same name
			--Check their size.
			--if same then replace it.
			--if not, 改名另存一份
			
			
			
		end if
		
	end repeat
	
	--set name of picturePath to "sorted"
	
end tell
