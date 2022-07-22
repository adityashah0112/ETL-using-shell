# cp-access-log.sh
# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/".

# The script then extracts the .txt file using gunzip.

# The .txt file contains the timestamp, latitude, longitude 
# and visitor id apart from other data.

# Transforms the text delimeter from "#" to "," and saves to a csv file.
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.

# Create landing table
echo "\c template1;
CREATE TABLE access_logs(timestamp TIMESTAMP, latitude float, longitude float, visitor_id char(37));" | psql --username=postgres --host=localhost

# Download the access log file
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# Unzip the gzip file
gunzip -f web-server-access-log.txt.gz

# Extract required fields from the file
echo "Extracting Data..."

# Redirect the extracted output into a file
cut -d# -f1-4 web-server-access-log.txt > extracted-data.txt

# Transform the data into CSV format

echo "Transforming Data..."
tr "#" ',' < extracted-data.txt > transformed-data.csv


# Load the data into the table access_log in PostgreSQL
echo "Loading Data..."

echo "\c template1; \COPY access_logs FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost

echo '\c template1; \\SELECT * FROM access_logs;' | psql --username=postgres --host=localhost