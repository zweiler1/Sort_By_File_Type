#!/bin/bash
# this is a shebang

#src = /home/zweiler1/Desktop/Test/Source/
#dest = /home/zweiler1/Desktop/Test/Target/

#LANG="ENG"
source_directory=""
target_directory=""
delete_empty_dirs=""
types_images=('JPG' 'jpg' 'JPEG' 'jpeg' 'PNG' 'png')
types_videos=('MP4' 'mp4' 'MOV' 'mov')
types_audio=('MP3' 'mp3' 'WAV' 'wav' 'FLAC' 'flac' 'AAC' 'aac' 'OPUS' 'opus' 'OGG' 'ogg' 'M4A' 'm4a')

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

#echo "Do you want to search for image files? Y/n"
echo "Möchten Sie nach Bildern suchen? J/n"
read -r search_for_images
echo
[ "$search_for_images" = "J" ] || [ "$search_for_images" = "j" ] || [ "$search_for_images" = "Y" ] || [ "$search_for_images" = "j" ] || [ "$search_for_images" = "" ] && search_for_images=true || search_for_images=false

#echo "Do you want to search for video files? Y/n"
echo "Möchten Sie nach Videos suchen? J/n"
read -r search_for_videos
echo
[ "$search_for_videos" = "J" ] || [ "$search_for_videos" = "j" ] || [ "$search_for_videos" = "Y" ] || [ "$search_for_videos" = "y" ] || [ "$search_for_videos" = "" ] && search_for_videos=true || search_for_videos=false

#echo "Do you want to search for audio files? Y/n"
echo "Möchten Sie nach Audiodateien suchen? J/n"
read -r search_for_audio
echo
[ "$search_for_audio" = "J" ] || [ "$search_for_audio" = "j" ] || [ "$search_for_audio" = "Y" ] || [ "$search_for_audio" = "y" ] || [ "$search_for_audio" = "" ] && search_for_audio=true || search_for_audio=false

#echo "Do you want to delete empty directories after moving the files? Y/n"
echo "Möchten Sie nach dem Verschieben die leerern Ordner löschen? J/n"
read -r delete_empty_dirs
echo
[ "$delete_empty_dirs" = "J" ] || [ "$delete_empty_dirs" = "j" ] || [ "$delete_empty_dirs" = "Y" ] || [ "$delete_empty_dirs" = "y" ] || [ "$delete_empty_dirs" = "" ] && delete_empty_dirs=true || delete_empty_dirs=false

search_for_type() {
    mkdir "$target_directory/$1" 2>/dev/null
    type="$1"
    export "target_directory"
    export "type"
    #find "$source_directory" -name "*.$1" -exec bash -c 'mv "$0" "$target_directory/$type/" && echo -e "Moved to ./$type: \t\t$0"' {} \;
    find "$source_directory" -name "*.$1" -exec bash -c 'mv "$0" "$target_directory/$type/" && echo -e "Verschoben nach ./$type: \t\t$0"' {} \;
}

delete_empty_directories() {
    find . -type d -empty -print
    echo "Möchten Sie diese Ordner löschen? J/n"
    read -r apply_deletion
    echo
    [ "$apply_deletion" = "J" ] || [ "$apply_deletion" = "j" ] || [ "$apply_deletion" = "Y" ] || [ "$apply_deletion" = "y" ] || [ "$apply_deletion" = "" ] && apply_deletion=true || apply_deletion=false
    "$apply_deletion" && find . -type d -empty -delete
}

# Le searching
"$search_for_images" && for type in "${types_images[@]}"; do search_for_type "$type"; done
"$search_for_videos" && for type in "${types_videos[@]}"; do search_for_type "$type"; done
"$search_for_audio" && for type in "${types_audio[@]}"; do search_for_type "$type"; done
"$delete_empty_dirs" && delete_empty_directories
