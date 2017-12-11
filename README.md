# omi_logs_scan - log4j 

This is my script to quickly obtain all OMi 10.x logs (log4j), then scan through them to see the ERRORS, WARNINGS and DEBUG log events.

The script is run relative to to the time you run the script and uses the current date, this is due to limiting the amount of data as there are many logs and enteries. Its puprpose is for the OMi administrator to quickly see if there are any ERROR’s acrossall the logs. 

Functions:

    Copys all the logs into a temp folder
    Shows the size of the logs (can be very large)
    Scans through the logs and finds ERROR, WARNING, DEBUG logs, copys them into a new file which contains the log name and log entry.

You can then look at the files created, there are three files

    omi_error_report.txt (Main one used, good for finding ERRORS)
    omi_warning_report.txt
    omi_debug_report.txt

(If you want debug info, then you will need to enable this within OMi)

The enviroment was OMi10.6 / RHEL 6.5
