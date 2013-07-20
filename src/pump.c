/*
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

#include "version.h"

#define		CO_NONE			0x0000
#define 	CO_HELP			0x0001
#define 	CO_VERSION		0x0002
#define 	CO_TEST			0x0004
#define 	CO_ONCE			0x0008
#define 	CO_STATE		0x0010
#define 	CO_LOG			0x0020
#define 	CO_LIMIT		0x0040
#define 	CO_ELSE			0x0080
#define 	CO_STOP			0x0100

/*
 * @purpose:			Parse program argumets.
 *
 * @params:
 * int argc				- count of arguments, transtale from main signature
 * char* argv[]			- program arguments, transtale from main signature
 *
 * return int			0 - normal start in daemon process, 1 - single shot
 *
 */
int parseArgs(int argc, char* argv[])
{
	int res = CO_NONE;
	res = CO_VERSION;
	
	return res;
}

/*
 * @purpose:			parse program argumets.
 *
 * @params:
 * int argc				- count of arguments, transtale from main signature
 * char* argv[]			- program arguments, transtale from main signature
 *
 * return int			0 - normal start in daemon process, 1 - single shot
 *
 */
int main(int argc, char* argv[])
{
	FILE *fp = NULL;
	pid_t process_id = 0;
	pid_t sid = 0;
	
	int mask = parseArgs(argc, argv);
	
	if((mask & CO_VERSION) == CO_VERSION)
	{
		printf("\n");
		printf("%s ver. %d.%d, build #%d.\n", DESCRIPTION, VER_MAJOR, VER_MINOR, BUILD_NUM);
		printf("\n");
		printf("Author: %s\n", AUTHOR_NAME);
		printf("\n");
		printf("Contact info:\n");
		printf("\tEmail: %s\n", AUTHOR_EMAIL);
		printf("\tSkype: %s\n", AUTHOR_SKYPE);
		printf("\tPhone: %s\n", AUTHOR_PHONE);
		printf("\n");
		printf("%s\n", COPYRIGHT);
		printf("\n");
		printf("Git src commit hash '%s' from '%s' branch.\n", SRC_COMMIT, SRC_BRANCH);
		printf("\n");
		exit(0);
	}
	
	if((mask & CO_HELP) == CO_HELP)
	{
		printf("Pump version: %s\n", VERSION);
		exit(0);
	}
	
	if((mask & CO_STATE) == CO_STATE)
	{
		printf("Version: %d.%d, build %d.\n", VER_MAJOR, VER_MINOR, BUILD_NUM);
		printf("Git commit hash '%s' from '%s' branch.\n", SRC_COMMIT, SRC_BRANCH);
		printf("\n");
		printf("%s", COPYRIGHT);
		exit(0);
	}
	
	
	if((mask & CO_STOP) == CO_STOP)
	{
		printf("Stop!\n");
		exit(0);
	}
	
	// Create child process
	process_id = fork();
	
	// Indication of fork() failure
	if (process_id < 0)
	{
		printf("fork failed!\n");
		// Return failure in exit status
		exit(1);
	}

	// PARENT PROCESS. Need to kill it.
	if (process_id > 0)
	{
		printf("process_id of child process %d \n", process_id);
		// return success in exit status
		exit(0);
	}

	//unmask the file mode
	umask(0);

	//set new session
	sid = setsid();
	if(sid < 0)
	{
		// Return failure
		exit(1);
	}

	// Change the current working directory to root.
	chdir("/");

	// Close stdin. stdout and stderr
	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	close(STDERR_FILENO);

	// Open a log file in write mode.
	fp = fopen ("Log.txt", "w+");

	//Daemon main loop
	while (1)
	{
		//Dont block context switches, let the process sleep for some time
		sleep(1);
		fprintf(fp, "Logging info...\n");
		fflush(fp);
		// Implement and call some function that does core work for this daemon.
	}

	fclose(fp);

	return (0);
}

