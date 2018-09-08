#/bin/#!/bin/sh
PFXS_STEAMAPPS=()
BOLDWHITE="\033[1m\033[37m"
RESET="\033[0m"
function loadSettings()
{
  if [ ! -f ./config.cfg ]; then
    printf "${BOLDWHITE}No Steam libraries have been added... Please run the setup command to get started.\n${RESET}"
    exit 1
  else
    PFXS_STEAMAPPS=()
    for line in $( cat config.cfg ); do
      PFXS_STEAMAPPS+=($line)
    done
  fi
}
function addSteamLibrariesFromLibraryFoldersFile()
{
  for l in $(grep -o '/[^"]*' $1)
  do
      PFXS_STEAMAPPS+=($l/steamapps)
  done
}
function saveSteamLibrariesToFile()
{
  for each in "${PFXS_STEAMAPPS[@]}"
  do
    if [ -f ./config.cfg ]; then
      if grep -w "$each" config.cfg > /dev/null;  then
        printf "${BOLDWHITE}Library${RESET} $each ${BOLDWHITE}already added${RESET}\n"
      else
        printf '%b\n' "$each" >> config.cfg
      fi
    else
      printf '%b\n' "$each" >> config.cfg
    fi

  done
  printf "${BOLDWHITE}Currently added libraries:${RESET}\n"
  loadSettings
  listSteamLibraries
}
function addSteamLibrary()
{
    PFXS_SETUP_STEAMAPPS=$1
    if [ ! -d $PFXS_SETUP_STEAMAPPS ]; then
      printf "${BOLDWHITE}Please enter a valid path\n${RESET}"
      exit 1
    fi
    PFXS_STEAMAPPS+=($PFXS_SETUP_STEAMAPPS)

    if [ -f $PFXS_SETUP_STEAMAPPS/libraryfolders.vdf ]; then
      printf "${BOLDWHITE}Protonfixes has fonud that you have more Steam libraries, would you like me to add those automatically? [y/n] ${RESET}"
      read yn
      case $yn in
        [Yy]* )
          addSteamLibrariesFromLibraryFoldersFile "$PFXS_SETUP_STEAMAPPS/libraryfolders.vdf"
        ;;
        [Nn]* )
        ;;
      esac
    fi
    saveSteamLibrariesToFile
}
function listSteamLibraries()
{
  for each in "${PFXS_STEAMAPPS[@]}"
  do
    echo $each
  done
}
function hasGameGotFix()
{
  if [ -z `find ./fixes -maxdepth 1 -name $1.sh` ]; then
    printf "${BOLDWHITE}No fixes.${RESET}\n"
    promptWhatGameFix
  else
    printf "${BOLDWHITE}Fix found! Checking for game installation...${RESET}\n"
    findGameInLibraries $1
  fi
}
function findGameInLibraries()
{

  for _prefix in "${PFXS_STEAMAPPS[@]}"
  do
    if [ -z `find $_prefix -maxdepth 1 -name $1 -type d` ]; then
      printf "${BOLDWHITE}Game found, running fix!${RESET}\n"
      _PFXS_GAME_FOLDER_NAME=$(grep 'installdir' '/home/james/.steam/steam/steamapps/appmanifest_'$1'.acf' | sed -r 's/(([^"]*"){3})//; s/"//')
      _PFXS_GAME_NAME=$(grep 'name' '/home/james/.steam/steam/steamapps/appmanifest_'$1'.acf' | sed -r 's/(([^"]*"){3})//; s/"//')
      sh ./fixes/$1.sh $_prefix/compatdata/$1 "$_prefix/common/$_PFXS_GAME_FOLDER_NAME" "$_PFXS_GAME_NAME"
      break;
    fi
  done
  if [ ! -z "$PFXS_STEAMAPPS_FIX_FOUND" ]; then
    printf "${BOLDWHITE}Game not installed${RESET}\n"
    promptWhatGameFix
  fi
}
function promptWhatGameFix()
{
  printf "${BOLDWHITE}Please enter the id of the game you want a fix for: \n${RESET}"
  read PFXS_STEAMAPPS_CURRENT_GAME
  hasGameGotFix "$PFXS_STEAMAPPS_CURRENT_GAME"
}

case $1 in
  "add-library" )
      addSteamLibrary $2
      exit 1
    ;;
esac

loadSettings

case $1 in
  "fix" )
    hasGameGotFix $2
    exit 1
    ;;
  "list-libraries" )
      listSteamLibraries
    ;;
esac
