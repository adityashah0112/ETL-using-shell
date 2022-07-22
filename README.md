# ETL-using-shell
Shell script for basic ETL process on a file fetched from an online source.
The file is a '#' separated value file with multiple fields. The aim is to load the data of a 100 rows into an SQL table using Postgres.

The file is transformed from a # separated value to a CSV in order to convert it into a CSV format.
This can then be used to easily load data into the postgresql table that was created in the shell script.
