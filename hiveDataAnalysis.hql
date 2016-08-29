--Querying print_data using get_json_object

select get_json_object(biobot_print.value, '$.print_data.deadpercent') as DEAD_PERCENT, 
       get_json_object(biobot_print.value, '$.print_data.elasticity') as ELASTICITY,
       get_json_object(biobot_print.value, '$.print_data.livePercent') as LIVE_PERCENT
from biobot_print;

--Querying print_data using json_tuple

select v2.DEAD_PERCENT, v2.ELASTICITY, v2.LIVE_PERCENT
from biobot_print bio
     LATERAL VIEW json_tuple(bio.value, 'print_data') v1
     as print_data
     LATERAL VIEW json_tuple(v1.print_data, 'deadPercent', 'elasticity', 'livePercent') v2
     as DEAD_PERCENT, ELASTICITY, LIVE_PERCENT;

--Finding all users whose deadPercent is less than 50

select v3.USER_EMAIL 
from biobot_print bio
     LATERAL VIEW json_tuple(bio.value, 'print_data', 'user_info') v1
     as print_data
     LATERAL VIEW json_tuple(v1.print_data, 'deadPercent') v2 as DEAD_PERCENT
     LATERAL VIEW json_tuple(v1.user_info, 'email') v3 as USER_EMAIL
     where DEAD_PERCENT < 50.0;


--Finding all users whose crosslinking duration is not equal to 0

select v3.USER_EMAIL 
from biobot_print bio
     LATERAL VIEW json_tuple(bio.value, 'print_info', 'user_info') v1
     as print_info
     LATERAL VIEW json_tuple(v1.print_info, 'crosslinking') v2 as CL
     LATERAL VIEW json_tuple(CL.crosslinking, 'c1_duration') as DURATION	
     LATERAL VIEW json_tuple(v1.user_info, 'email') v3 as USER_EMAIL
     where DURATION != 0;


--Finding average resolution layer height

select avg(v3.LAYER_HEIGHT) 
from biobot_print bio
     LATERAL VIEW json_tuple(bio.value, 'print_info') v1
     as print_info
     LATERAL VIEW json_tuple(v1.print_info, 'resolution') v2 as RESOLUTION
     LATERAL VIEW json_tuple(v2.RESOLUTION, 'layerHeight') v3 as LAYER_HEIGHT;

--Finding maximum wellplate

select max(WP) 
from biobot_print bio
     LATERAL VIEW json_tuple(bio.value, 'print_info') v1
     as print_info
     LATERAL VIEW json_tuple(v1.print_info, 'wellplate') v2 as WP;

--Finding users who printed more than once, number of times they printed

select v3.USER_EMAIL, count(1) 
from biobot_print bio
     LATERAL VIEW json_tuple(bio.value, 'print_data', 'user_info') v1
     as print_data
     LATERAL VIEW json_tuple(v1.print_data, 'deadPercent') v2 as DEAD_PERCENT
     LATERAL VIEW json_tuple(v1.user_info, 'email') v3 as USER_EMAIL
     group by USER_MAIL
     having count(1) > 1;

--Finding all the records whose output is null

select v3.USER_MAIL 
from biobot_print bio
     LATERAL VIEW json_tuple(bio.value, 'print_info', 'user_info') v1
     as print_info
     LATERAL VIEW json_tuple(v1.print_info, 'files') v2 as FILES
     LATERAL VIEW json_tuple(v2.FILES, 'output') as OP	
     LATERAL VIEW json_tuple(v1.user_info, 'email') v3 as USER_EMAIL
     where OP is NULL;
