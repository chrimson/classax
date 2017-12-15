ClassAx
Chris Limson
a crowdsourced wiki database


Environment:
CentOS 7 x64
Firefox 52.4.0 x64
Eclipse JEE Kepler
JDK 1.8.0 152
apache-tomcat-7.0.82
mysql-5.5.58-linux-glibc2.12-x86_64
jstl-1.2.jar
mysql-connector-java-5.1.44-bin.jar


MySQL:
mysql> create database ClassAx;
mysql> use ClassAx;
mysql> source ClassAx.sql;


shell> mysqldump -u root -p ClassAx > ClassAx.sql


Log:
2017-02-15
Table redundancy, Headers control instead
add ID to table, hide its display
add Rating to table, remove its text input field

2017-02-14
use HTTP sessions to manage user login state

TODO:
check entry if must be number
merged parent header
add rank field, like buttons for each row. declare constants for additional columns
XML config

2017-12-12
comment

2017-12-11
comment
fix null value comparison to numbers

2017-12-08
enable buttons only when valid
don't log out just with home link
fix clear to include reset
add null numeric values
MySQL import/export notes, SQL database

2017-12-07
new/add op searches first
sort by number of matches
use previous entry for default values 
clear input fields of any values
sort numeric values in order
add/new to table

2017-12-06
modify default first page to show blank
add spec match count field

2017-12-01
un/collapse table
input box widths column widths
search SQL database
fix login

2017-11-30
MySQL Table of serialized objects
vary number of columns
aesthetics
sort table

2017-11-29
JSTL include pages

2017-11-28
Eclipse Dynamic Web Project

MySQL

Users
Username
Password

Cars
Specs

