# Assignment 1

#### README for ProjectAnalyze.sh 
Executing the script will result in a prompt appearing that will request a command. Each command along with what they indiviually do is described in the Command Features section.
	* Additional Features will describe any entirely new implented features
	* General Additional Features are additional features that improve the general quality of the entire script.

### Project Analyze Command Features
1. state => Informs you if your local repository is up-to-date with the remote repository
2. changes => Appends all uncommited changes into a file (changes.log)
3. todo => Appends every line with #TODO into a file (todo.log)
4. error => Scans all haskell files for syntax errors and appends the results into a file (error.log)

### Additional Features
1. due(1-3) => Will check then output whether Assignments 1-3 are still due or if there due dates have passed
	- due1 => Ckecks if Assignment 1 is due
	- due2 => Checks if Assignment 2 is due
	- due3 => Checks if Assignment 3 is due

2. time => Will propmt the user asking if they want to see the exact time as a 24 hour clock(ie 12:00 AM = 12:00, 12:00 PM = 24:00). [ cite: https://stackoverflow.com/questions/16548528/linux-command-to-get-time-in-milliseconds ]
	* Entering "nano" for the prompt will result in the current time up to the nanosecond to be outputed
	* Entering "milli" for the prompt will result in the current time up to the millisecond to be outputed
	* Entering "n" for the prompt will result in the current time up to the second to be outputed

3. search => Will find a specified file/line with a given parameter. [ cite: https://github.com/gibsoj12/CS1XA3/blob/master/ProjectAnalyze.sh ] 
	* Entering "file" when prompted, then a desired pattern to be searched for when prompted, will output all file names containing the specified pattern.
	* Entering "line" when prompted, then a desired pattern to be searched for when prompted will output all lines in files containing the specified pattern.

4. replace => Will allow the user to change an inputed word into another word in a chosen file, creates another file named "M.fileName" for it being a modified verison of the original file. (Due to he nature of this feature the inputs must be case sensitive)
	* First the user must enter a file name in the current directory.
	* Then the user must enter a word he/she wishes to replace
	* Then the user must enter the word he/she wishes to replace with

5. diff => Will create a diff.log file contained any differences between the local repository and the master repository, will also output the differences for viewing. [ cite: https://github.com/deleeuwj1/CS1XA3/blob/master/ProjectAnalyze.sh and https://stackoverflow.com/questions/9964823/how-to-check-if-a-file-is-empty-in-bash ]

### General Additional Features
1. Selective Execution:
	This feature allows the user to execute indiual aspects of the script without the need to execute it in its entirety. 

2. Looping Execution:
	This feature entails that commands can be continually enetered, until the users enters "exit" to end the script.

3. Open File:
	Any feature that results in the creation/appending of a file will prompt the user "Do you wish to view ____.log? (Y/N): " this allows the user to immediatley view the created file.

4. Attempt update:
	After entering the state command and viewing the status of the repository the user will be asked whether they wish to attempt an update or not "Do you want to attempt an update? (Y/N): ". 

5. Case Insensitivity:
	All commands would work regardless of capitalization. 
