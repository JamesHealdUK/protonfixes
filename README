# Disclaimer

BE WARNED. The quality of code in this script is horrific. Looking at it may cause negativity towards your wellbeing. If you feel brave enough to help me make it not toxic to look at, I'd very much appreciate it.



# What is Protonfixes?

A bash script with a library of fixes for games running under Proton.

Protonfixes is a FOSS script where people can contribute and add their own fixes for Steam games running under the Proton compatibility layer. The fixes are made in the form of a bash script for ease of use and development.



# How do I use it?

First of all, make sure the `protonfixes.sh` has execute permissions by executing the following command:

`chmod +x protonfixes.sh`

The next thing you will want to do is add your steamapps folder, you can do so by executing the following command:

`./protonfixes.sh add-library /home/username/.steam/steam/steamapps`

If you add your main Steam library (the one that comes with your Steam installation), it will look through your `libraryfolders.vtf` file to see if there are any other libraries added to your system. It will prompt you whether or not you want to add those libraries, at which point you can answer y/n.

At this point you can now execute any of the pre made fixes that come with Protonfixes. You will need the appid for your game which you can obtain by going to the store page and extracting the ID from the URL. Heres an example:

`./protonfixes.sh fix 266840`

This will then make Protonfixes look for any fixes available, if there is one, it will then look through all your libraries to see if the game is installed. If that checks out, the script will execute and will (hopefully) fix the game you specified.



# Commands

**add-library**

`./protonfixes.sh add-library [steamapps directory]`

 Add library expects a steamapps directory as it's first argument. Upon execution, `add-library` will look for  a file named `libraryfolders.vdf` which contains a list of all the other added libraries within Steam. Protonfixes will then prompt you whether or not you want to add all the libraries that are added to your Steam client.

Upon completion, it will save all the libraries you've added to a file called `config.cfg`.

**fix**

`./protonfixes.sh fix [appid] [--dev]`

Fix expects a steam app id as its main argument. When executed, Protonfixes will look for the appropriate fix for the specified game and check for an install of that game in your libraries.

If that checks out, the fix will execute and upon completion; it will place a lockfile in both the apps prefix folder and game directory to assure the user doesn't execute the fix twice.

The `--dev` flag is used for when you develop scripts and you *don't* want the lockfiles to be put in the app folder and the prefix folder. This is helpful when developing a fix of your own.

**list-libraries**

`./protonfixes.sh list-libraries`

List libraries does exactly what it says on the tin: it lists all the libraries you currently have added to Protonfixes.



# Developing your own fix script

If you want to make a fix for Protonfixes, all you need to do is add a new file under the `fixes` folder and name it `[appid-here].sh`. Make sure it's executable and you're good to go!
The script will receive 3 arguments...

* `$1` = The path to the compatdata folder of the game
* `$2` = The path to the common folder for the game.
* `$3` = The game's name in plain text.

Past that, the ball is in your court. You can look at the Age Of Mythology fix for inspiration (appid `266840`)



# Upcoming fixes/features

* The ability to remove libraries with a `remove-library` command
* Potential frontend for the script so the users can benefit from a nice GUI
* Rename prefix variables to steamapps (it doesnt make sense to call the steamapps folder a prefix... Thats 5am coding without caffeine for you)
