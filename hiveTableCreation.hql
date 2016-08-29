
-- creating hive table on nested json

create external table bioprint(
print_data struct<deadpercent:decimal, elasticity:decimal, livepercent:decimal>,
print_info struct<crosslinking struct<c1_duration : int, c1_enabled : boolean, c1_intensity : int>,files struct<input : string, output : string>,pressure struct<extruder1 : decimal, extruder2 : decimal>,resolution struct<layerheight : decimal, layernum : int>,wellplate : int>,
user_info struct<email:string, serial:int>)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION '/user/bdrive/data/test';



-- creating hive table assuming TextFileFormat

create external table biobot_print(
value string)
location  '/user/bdrive/data/test';
