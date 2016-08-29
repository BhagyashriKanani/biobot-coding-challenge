# biobot-coding-challenge

Approach: 
Loaded data file in to 2 hive tables. 
Loaded as JSON file in to first hive table using JSON serde "org.apache.hive.hcatalog.data.JsonSerDe". This serde couldn't retrieve results as expected as the file is nested JSON. I found couple of other json serdes that can handle nested json better but they seem to be inefficient in terms of performance. 
Loaded as text file in to second hive table. Since default delimiter for text files is new line character, I removed new line characters from the input file. There are couple of built in hive functions to parse json files and retrieve results from a hive table.
1. get_json_object
2. json_tuple

# preprocess.sh
This script accomplishes:
1. Loads input file into hdfs cluster
2. Removes new line characters from the json file

It accepts 4 arguments. Usage of the script is mentioned in the script.

#hiveTableCreation.hql
This script creates 2 hive tables as mentioned above. One using json serde and other using default text serde.

#hiveDataAnalysis.hql
This script analyzes the data loaded in the second hive table. 
