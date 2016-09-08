# Purpose
Tired of updating scripts by searching and replacing until your fingers fall off? Have a SQL statement you have to run against every table in your schema?
Next to Regular Expressions, this is one of the most useful tools in my arsenal.
Common uses for this are to write SQL statements that can work from a list of objects in the database:
* Tables from USER_TABLES or DBA_TABLES
* Constraints from USER_CONSTRAINTS or DBA_CONSTRAINTS
* Indexes from USER_INDEXES or DBA_INDEXES
* USER_OBJECTS with an appropriate filter on OBJECT_TYPE (TABLE, PACKAGE, SEQUENCE, etc…)
# Usage

1. Update genscript.sql to include SQL statement you want to generate (see last line)
2. Run the script:
```
SQLPLUS user/password@instance @genscript.sql
```
3. View your results:
```
EDIT c:\spool.sql
```
4. Run it!
```
SQL> @spool.sql
```
