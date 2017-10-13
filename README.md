# ProcessUsage
This script contained here logs in to multiple servers and lists out the RAM usage of required processes.

Input: Script will take as input a file containing lines in the following format:

IP username password process_name

e.g. 127.0.0.1 admin admin apache2

Output: IP : PROCESS : Memory usage of the process

Note:
1) The name of the input file should be : hostlist
2) The file should be in the same directory where the script is
3) I could test the script in an ssh based password-less environment. The script is designed to work in the same type of environment. 
4) If you want to make the script work in an username/password based environment, please comment line 20 and uncomment line 21 . Although, 
5) I could only test this for 1 server, it should work for multiple servers as well. Please do let me know if it does not. Also, for this to work, sshpass should be installed in the server from which this script is being ran.
