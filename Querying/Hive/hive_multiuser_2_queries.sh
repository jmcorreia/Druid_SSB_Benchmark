#!/bin/bash

if [[ $1 = *"analytical"* ]]; then

# variables
path="/home/admin/correia/testes"
host="node5.dsi.uminho.pt"
port="2181"
q1_1="select sum(discounted_price) as revenue from $1 where od_year = 1993 and discount between 1 and 3 and quantity < 25"
q1_2="select sum(discounted_price) as revenue from $1 where od_yearmonthnum = 199401 and discount between 4 and 6 and quantity between 26 and 35"
q1_3="select sum(discounted_price) as revenue from $1 where od_weeknuminyear = 6 and od_year = 1994 and discount between 5 and 7 and quantity between 26 and 35"
q2_1="select sum(revenue), od_year, p_brand1 from $1 where p_category = 'MFGR#12' and s_region = 'AMERICA' group by od_year, p_brand1 order by od_year, p_brand1"
q2_2="select sum(revenue), od_year, p_brand1 from $1 where p_brand1 between 'MFGR#2221' and 'MFGR#2228' and s_region = 'ASIA' group by od_year, p_brand1 order by od_year, p_brand1"
q2_3="select sum(revenue), od_year, p_brand1 from $1 where p_brand1= 'MFGR#2239' and s_region = 'EUROPE' group by od_year, p_brand1 order by od_year, p_brand1"
q3_1="select c_nation, s_nation, od_year, sum(revenue) as revenue from $1 where c_region = 'ASIA' and s_region = 'ASIA' and od_year >= 1992 and od_year <= 1997 group by c_nation, s_nation, od_year order by od_year asc, revenue desc"
q3_2="select c_city, s_city, od_year, sum(revenue) as revenue from $1 where c_nation = 'UNITED STATES' and s_nation = 'UNITED STATES' and od_year >= 1992 and od_year <= 1997 group by c_city, s_city, od_year order by od_year asc, revenue desc"
q3_3="select c_city, s_city, od_year, sum(revenue) as revenue from $1 where (c_city='UNITED KI1' or c_city='UNITED KI5') and (s_city='UNITED KI1' or s_city='UNITED KI5') and od_year >= 1992 and od_year <= 1997 group by c_city, s_city, od_year order by od_year asc, revenue desc"
q3_4="select c_city, s_city, od_year, sum(revenue) as revenue from $1 where (c_city='UNITED KI1' or c_city='UNITED KI5') and (s_city='UNITED KI1' or s_city='UNITED KI5') and od_yearmonth = 'Dec1997' group by c_city, s_city, od_year order by od_year asc, revenue desc"
q4_1="select od_year, c_nation, sum(net_revenue) as profit from $1 where c_region = 'AMERICA' and s_region = 'AMERICA' and (p_mfgr = 'MFGR#1' or p_mfgr = 'MFGR#2') group by od_year, c_nation order by od_year, c_nation"
q4_2="select od_year, s_nation, p_category, sum(net_revenue) as profit from $1 where c_region = 'AMERICA' and s_region = 'AMERICA' and (od_year = 1997 or od_year = 1998) and (p_mfgr = 'MFGR#1' or p_mfgr = 'MFGR#2') group by od_year, s_nation, p_category order by od_year, s_nation, p_category"
q4_3="select od_year, s_city, p_brand1, sum(net_revenue) as profit from $1 where c_region = 'AMERICA' and s_nation = 'UNITED STATES' and (od_year = 1997 or od_year = 1998) and p_category = 'MFGR#14' group by od_year, s_city, p_brand1 order by od_year, s_city, p_brand1"


echo '----------------------------------------------------------------------------------------------------------------' > $path/results_hive_druid_multiuser_2_$1.txt
echo "						Benchmark Results $1"																		>> $path/results_hive_druid_multiuser_2_$1.txt
echo '----------------------------------------------------------------------------------------------------------------' >> $path/results_hive_druid_multiuser_2_$1.txt

echo -e '\nQUERY2.1-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-2.1 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q2_1\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY2.1-DONE'
echo -e '\nQUERY2.2-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-2.2 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q2_2\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY2.2-DONE'
echo -e '\nQUERY2.3-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-2.3 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q2_3\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY2.3-DONE'
echo -e '\nQUERY3.1-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-3.1 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q3_1\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY3.1-DONE'
echo -e '\nQUERY3.2-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-3.2 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q3_2\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY3.2-DONE'
echo -e '\nQUERY3.3-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-3.3 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q3_3\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY3.3-DONE'
echo -e '\nQUERY3.4-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-3.4 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q3_4\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY3.4-DONE'
echo -e '\nQUERY4.1-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-4.1 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q4_1\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY4.1-DONE'
echo -e '\nQUERY4.2-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-4.2 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q4_2\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY4.2-DONE'
echo -e '\nQUERY4.3-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-4.3  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q4_3\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY4.3-DONE'

echo -e '\nQUERY1.1-STARTING'
echo -e "\n+++++++++++++++++++++++++++++++++++++++++ QUERY-1.1 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q1_1\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY1.1-DONE'
echo -e '\nQUERY1.2-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-1.2 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q1_2\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY1.2-DONE'
echo -e '\nQUERY1.3-STARTING'
echo -e "\n\n+++++++++++++++++++++++++++++++++++++++++ QUERY-1.3 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>$path/results_hive_druid_multiuser_2_$1.txt

for i in 1 2 3 4

do 

    echo "----------------------------------------------------------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt
 	{ time beeline -u "jdbc:hive2://$host:$port/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2-hive2" -e "\"$q1_3\""; } &>> $path/results_hive_druid_multiuser_2_$1.txt
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">>$path/results_hive_druid_multiuser_2_$1.txt

done

echo 'QUERY1.3-DONE'

elif [ $1 == "--help" ]; then
	echo "Usage: analytical_obj[SF]_S[SegmentGranularity]_Q[QueryGranularity]"

else

echo "Missing database. To ask for help use '--help' Ex: analytical_obj1_SQuarter_QDay"

fi