
## NetGraf: Reading Data from Stardust API into NetGraf Database

Code for reading Data from Stardust API into Netgraf. It saves the data as a csv and stores it in NetGraf database as a time series data.

## Setup Guide
* Please ensure all dependencies are installed. 
* Replace the link below with your link generated form your firebase account:
        
        https://netpred-8a3a5-default-rtdb.firebaseio.com 


Run the following to read the data and store in the database:

    python3 snmp_query.py


You should have a csv file saved in your local directory and the data stored in your database.

