# Assignment 1

#### README for ProjectAnalyze.sh 
Executing the program will result in a prompt appearing that will request a command. Each command along with what they indiviually do is described in the Command Features section.

Additional Features will describe any entirely new features implemented by the creator.

General Additional Features are additional features that improve the general quality of the entire script.

### Project Analyze Command Features
1. state => Informs you if your local repository is up-to-date with the remote repository
2. changes => Appends all uncommited changes into a file (changes.log)
3. todo => Appends every line with #TODO into a file (todo.log)
4. error => Scans all haskell files for syntax errors and appends the results into a file (error.log)

### Additional Features
1. due(1-3) => Will check then output whether Assignments 1-3 are still due or if there due dates have passed

### General Additional Features
1. Looping Execution:
	This feature allows the user to execute indiual aspects of the script without the need to execute it in its entirety. 

2. Execution till exit
	This feature allows the suer to run any combiniation of commands without needing to re-execute the script. when prompted to "Enter command: " the user my enter exit to quit the script.

3. Open File
	Any feature that results in the creation/appending of a file will prompt the user "Do you wich to view ____.log? (Y/N): " this allows the user to immediatley view the created file.
