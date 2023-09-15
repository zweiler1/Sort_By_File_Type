#!/bin/bash
# this is a shebang

#src = /home/zweiler1/Desktop/Test/Source/
#dest = /home/zweiler1/Desktop/Test/Target/

#LANG="ENG"
source_directory=""
target_directory=""
types_images=('JPG' 'jpg' 'JPEG' 'jpeg' 'PNG' 'png')
types_videos=('MP4' 'mp4' 'MOV' 'mov')
types_audio=('MP3' 'mp3' 'WAV' 'wav' 'FLAC' 'flac')

#echo "Please enter the source directory, where all files are contained"
echo "Bitte den Quellordner angeben"
read -r source_directory
source_directory="${source_directory%%/}"
#source_directory="${source_directory!!\(.*\)/$!\1}"
echo

#echo "Please enter the target directory, where all files get stored by their type"
echo "Bitte den Zielordner angeben"
read -r target_directory
target_directory="${target_directory%%/}"
echo

#echo "Do you want to search for image files?"
echo "Möchten Sie nach Bildern suchen? J/n"
read -r search_for_images
echo
[ "$search_for_images" = "J" ] || [ "$search_for_images" = "j" ] || [ "$search_for_images" = "" ] && search_for_images=true || search_for_images=false

#echo "Do you want to search for video files?"
echo "Möchten Sie nach Videos suchen? J/n"
read -r search_for_videos
echo
[ "$search_for_videos" = "J" ] || [ "$search_for_videos" = "j" ] || [ "$search_for_videos" = "" ] && search_for_videos=true || search_for_videos=false

#echo "Do you want to search for audio files?"
echo "Möchten Sie nach Audiodateien suchen? J/n"
read -r search_for_audio
echo
[ "$search_for_audio" = "J" ] || [ "$search_for_audio" = "j" ] || [ "$search_for_audio" = "" ] && search_for_audio=true || search_for_audio=false

search_for_type() {
    mkdir "$target_directory/$1" 2>/dev/null
    type="$1"
    export "target_directory"
    export "type"
    #find "$source_directory" -name "*.$1" -exec bash -c 'mv "$0" "$target_directory/$type/" && echo -e "Moved to ./$type: \t\t$0"' {} \;
    find "$source_directory" -name "*.$1" -exec bash -c 'mv "$0" "$target_directory/$type/" && echo -e "Verschoben nach ./$type: \t\t$0"' {} \;
}

# Le searching
"$search_for_images" && for type in "${types_images[@]}"; do search_for_type "$type"; done
"$search_for_videos" && for type in "${types_videos[@]}"; do search_for_type "$type"; done
"$search_for_audio" && for type in "${types_audio[@]}"; do search_for_type "$type"; done
