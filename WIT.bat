:: WITCHCRAFT IMAGE TOOLKIT VERSION 1.8-2019
:: Copyright (c) 2019 Gabriel Torelli.
::  
:: This program is free software: you can redistribute it and/or modify  
:: it under the terms of the GNU General Public License as published by  
:: the Free Software Foundation, version 3.
:: 
:: This program is distributed in the hope that it will be useful, but 
:: WITHOUT ANY WARRANTY; without even the implied warranty of 
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
:: General Public License for more details.
::
:: You should have received a copy of the GNU General Public License 
:: along with this program. if not, see <http://www.gnu.org/licenses/>.
::
@echo off
 :Start2 
    cls
    goto Start
    :Start
	@echo [95m
	@echo                  ___                               
	@echo                 /\  \                              
	@echo                _\:\  \       ___           ___     
	@echo               /\ \:\  \     /\__\         /\__\    
	@echo              _\:\ \:\  \   /:/__/        /:/  /    
	@echo             /\ \:\ \:\__\ /::\  \       /:/__/     
	@echo             \:\ \:\/:/  / \/\:\  \__   /::\  \     
	@echo              \:\ \::/  /     \:\/\__\ /:/\:\  \    
	@echo               \:\/:/  /       \::/  / \/__\:\  \   
	@echo                \::/  /        /:/  /       \:\__\  
	@echo                 \/__/         \/__/         \/__/  
	@echo [0m
	@echo [42mVersion: 1.8-2019 [0m
	@echo.
	@echo                [92m W[0mITCHCRAFT [92m I[0mMAGE [92m T[0m00LKIT [0m         
	@echo            Functions for Batch Image Processing    
	@echo       This is a Open Source and Free to Use Software 
	@echo        Author: Gabriel Torelli - torelli@yahoo.com  
	@echo.
	@echo [95m                      [Options] [0m
	@echo.
    @echo [95m[1][0m Convert frames (jpg) to video (avi)
    @echo [95m[2][0m Convert video (avi) to frames (jpg)
	@echo [95m[3][0m Convert tif to jpg 
	@echo [95m[4][0m Convert bmp to jpg	
	@echo [95m[5][0m Convert png to jpg	
	@echo [95m[6][0m Resize all frames
	@echo [95m[7][0m Build a 1x4 video grid
	@echo [95m[8][0m Place a timed tag in video (avi)
    @echo [95m[9][0m Quit
	@echo.
    set /a one=1
    set /a two=2
	set /a three=3
	set /a four=4
	set /a five=5
	set /a six=6
	set /a seven=7
	set /a eight=8
	set /a nine=9
    set input=
    set /p input= Enter Selection [95m[1-9][0m:
    if %input% equ %one% goto F if not goto Start2
   	if %input% equ %two% goto X if not goto Start2
	if %input% equ %three% goto I if not goto Start2
	if %input% equ %four% goto B if not goto Start2
	if %input% equ %five% goto P if not goto Start2
	if %input% equ %six% goto R if not goto Start2
	if %input% equ %seven% goto G if not goto Start2
	if %input% equ %eight% goto T if not goto Start2
	if %input% equ %nine% goto Q if not goto Start2
    :F
	set /p framerate=Enter the framerate (FPS):
	for /r %%a in (frames\*.jpg) do (
    echo file '%%a' >> buffer.txt
	)
	libs\ffmpeg\bin\ffmpeg.exe -r %framerate% -f concat -safe 0 -i buffer.txt -vcodec mjpeg -qscale 0 videos/videoFrames.avi
	del /q buffer.txt
	goto :start2
	
	:X
	set /p framerate=Enter the framerate (FPS):
	set /p filename=Enter the filename in "videos" directory:
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -r %framerate% videos\%%02d.jpg
	goto :start2
	
	:I
	libs\imagemagick\mogrify.exe -format jpg frames\*.tif
	goto :start2
	
	:B
	libs\imagemagick\mogrify.exe -format jpg frames\*.bmp
	goto :start2
	
	:P
	libs\imagemagick\mogrify.exe -format jpg frames\*.png
	goto :start2	

	:R
	set /p resolution=Enter the resolution (ex.: 1024x768, 800x600, 500x480 ):
	libs\imagemagick\mogrify.exe -resize %resolution%! frames\*
	goto :start2
	
	:G
	libs\ffmpeg\bin\ffmpeg.exe -i videos\video1.avi -i videos\video2.avi -i videos\video3.avi -i videos\video4.avi -filter_complex "nullsrc=size=2560x480 [base]; [0:v] setpts=PTS-STARTPTS [left]; [1:v] setpts=PTS-STARTPTS [middleleft]; [2:v] setpts=PTS-STARTPTS [middleright]; [3:v] setpts=PTS-STARTPTS [right]; [base][left] overlay=shortest=1 [tmp1]; [tmp1][middleleft] overlay=shortest=1:x=640 [tmp2]; [tmp2][middleright] overlay=shortest=1:x=1280 [tmp3]; [tmp3][right] overlay=shortest=1:x=1920" -qscale 0 videos\videoGrid.avi
	goto :start2
	
	:T
	set /p filename=Enter the filename in "videos" directory:
	set /p tagsno=Specify the number of tags (1-8):
	set /a tag1=1
    set /a tag2=2
	set /a tag3=3
	set /a tag4=4
	set /a tag5=5
	set /a tag6=6
	set /a tag7=7
	set /a tag8=8
	set input=
    if %tagsno% equ %tag1% goto T1 if not goto Start2
   	if %tagsno% equ %tag2% goto T2 if not goto Start2
	if %tagsno% equ %tag3% goto T3 if not goto Start2
	if %tagsno% equ %tag4% goto T4 if not goto Start2
	if %tagsno% equ %tag5% goto T5 if not goto Start2
	if %tagsno% equ %tag6% goto T6 if not goto Start2
	if %tagsno% equ %tag7% goto T7 if not goto Start2
	if %tagsno% equ %tag8% goto T8 if not goto Start2
	
	:T1
	@echo No of tags: 1
	@echo.
	set /p tagT1=Enter the tag:
	set /p timeT1=Define the interval (start,end):
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -vf drawtext="fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT1%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT1%)'" -qscale 0 -codec:a copy videos\videoTag1.avi
	goto :start2
	
	:T2
	@echo No of tags: 2
	@echo.
	set /p tagT1=Enter the tag 1:
	set /p timeT1=Define the interval (start,end):
	set /p tagT2=Enter the tag 2:
	set /p timeT2=Define the interval (start,end):
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -vf drawtext="fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT1%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT1%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT2%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT2%)'" -qscale 0 -codec:a copy videos\videoTag2.avi
	goto :start2
	
	:T3
	@echo No of tags: 3
	@echo.
	set /p tagT1=Enter the tag 1:
	set /p timeT1=Define the interval (start,end):
	set /p tagT2=Enter the tag 2:
	set /p timeT2=Define the interval (start,end):
	set /p tagT3=Enter the tag 3:
	set /p timeT3=Define the interval (start,end):
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -vf drawtext="fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT1%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT1%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT2%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT2%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT3%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT3%)'" -qscale 0 -codec:a copy videos\videoTag3.avi
	goto :start2
	
	:T4
	@echo No of tags: 4
	@echo.
	set /p tagT1=Enter the tag 1:
	set /p timeT1=Define the interval (start,end):
	set /p tagT2=Enter the tag 2:
	set /p timeT2=Define the interval (start,end):
	set /p tagT3=Enter the tag 3:
	set /p timeT3=Define the interval (start,end):
	set /p tagT4=Enter the tag 4:
	set /p timeT4=Define the interval (start,end):
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -vf drawtext="fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT1%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT1%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT2%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT2%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT3%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT3%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT4%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT4%)'" -qscale 0 -codec:a copy videos\videoTag4.avi
	goto :start2
	
	:T5
	@echo No of tags: 5
	@echo.
	set /p tagT1=Enter the tag 1:
	set /p timeT1=Define the interval (start,end):
	set /p tagT2=Enter the tag 2:
	set /p timeT2=Define the interval (start,end):
	set /p tagT3=Enter the tag 3:
	set /p timeT3=Define the interval (start,end):
	set /p tagT4=Enter the tag 4:
	set /p timeT4=Define the interval (start,end):
	set /p tagT4=Enter the tag 5:
	set /p timeT4=Define the interval (start,end):
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -vf drawtext="fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT1%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT1%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT2%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT2%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT3%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT3%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT4%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT4%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT5%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT5%)'" -qscale 0 -codec:a copy videos\videoTag5.avi
	goto :start2
	
	:T6
	@echo No of tags: 6
	@echo.
	set /p tagT1=Enter the tag 1:
	set /p timeT1=Define the interval (start,end):
	set /p tagT2=Enter the tag 2:
	set /p timeT2=Define the interval (start,end):
	set /p tagT3=Enter the tag 3:
	set /p timeT3=Define the interval (start,end):
	set /p tagT4=Enter the tag 4:
	set /p timeT4=Define the interval (start,end):
	set /p tagT5=Enter the tag 5:
	set /p timeT5=Define the interval (start,end):
	set /p tagT6=Enter the tag 6:
	set /p timeT6=Define the interval (start,end):
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -vf drawtext="fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT1%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT1%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT2%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT2%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT3%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT3%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT4%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT4%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT5%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT5%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT6%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT6%)''" -qscale 0 -codec:a copy videos\videoTag6.avi
	goto :start2
	
	:T7
	@echo No of tags: 7
	@echo.
	set /p tagT1=Enter the tag 1:
	set /p timeT1=Define the interval (start,end):
	set /p tagT2=Enter the tag 2:
	set /p timeT2=Define the interval (start,end):
	set /p tagT3=Enter the tag 3:
	set /p timeT3=Define the interval (start,end):
	set /p tagT4=Enter the tag 4:
	set /p timeT4=Define the interval (start,end):
	set /p tagT5=Enter the tag 5:
	set /p timeT5=Define the interval (start,end):
	set /p tagT6=Enter the tag 6:
	set /p timeT6=Define the interval (start,end):
	set /p tagT7=Enter the tag 7:
	set /p timeT7=Define the interval (start,end):
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -vf drawtext="fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT1%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT1%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT2%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT2%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT3%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT3%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT4%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT4%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT5%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT5%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT6%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT6%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT7%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT7%)'" -qscale 0 -codec:a copy videos\videoTag7.avi
	goto :start2
	
	:T8
	@echo No of tags: 8
	@echo.
	set /p tagT1=Enter the tag 1:
	set /p timeT1=Define the interval (start,end):
	set /p tagT2=Enter the tag 2:
	set /p timeT2=Define the interval (start,end):
	set /p tagT3=Enter the tag 3:
	set /p timeT3=Define the interval (start,end):
	set /p tagT4=Enter the tag 4:
	set /p timeT4=Define the interval (start,end):
	set /p tagT5=Enter the tag 5:
	set /p timeT5=Define the interval (start,end):
	set /p tagT6=Enter the tag 6:
	set /p timeT6=Define the interval (start,end):
	set /p tagT7=Enter the tag 7:
	set /p timeT7=Define the interval (start,end):
	set /p tagT8=Enter the tag 8:
	set /p timeT8=Define the interval (start,end):
	libs\ffmpeg\bin\ffmpeg.exe -i videos\%filename%.avi -vf drawtext="fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT1%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT1%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT2%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT2%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT3%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT3%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT4%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT4%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT5%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT5%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT6%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT6%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT7%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT7%)', drawtext=fontfile=C\\:/Windows/Fonts/Arial.ttf: \ text='%tagT8%': fontcolor=white: fontsize=60: box=1: boxcolor=black@0: \ boxborderw=5: x=(w-text_w)/2: y=(h-text_h):enable='between(t,%timeT8%)'" -qscale 0 -codec:a copy videos\videoTag8.avi
	goto :start2
	:Q
	exit
