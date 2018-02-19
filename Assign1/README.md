# Assignment 1

#### README for ProjectAnalyze.sh 
Executing the program will result in a prompt appearing that will request a command. Each command along with what they indiviually do is described in the Command Features section.

Additional Features will describe any entirely new implented features.

General Additional Features are additional features that improve the general quality of the entire script.

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

### General Additional Features
1. Selective-Looping Execution:
	This feature allows the user to execute indiual aspects of the script without the need to execute it in its entirety. 

	* Execution till exit:
		The user must enter "exit" when propmted to enter a command to end the script.

2. Open File:
	Any feature that results in the creation/appending of a file will prompt the user "Do you wish to view ____.log? (Y/N): " this allows the user to immediatley view the created file.

3. Attempt update:
	After entering the state command and viewing the status of the repository the user will be asked whether they wish to attempt an update or not "Do you want to attempt an update? (Y/N: ". 

4. Case Insensitivity:
	All commands would work regardless of capitalization. 
