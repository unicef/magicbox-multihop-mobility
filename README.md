![Calculating Multi-Hop](./media/unicef-logo.png)

# Overview

The purpose of this project is to find the best SQL script to calculate multi-hop values given a database table that represents call detail records (CRD). One version of the solution was written for PostgreSQL and has recently been updated with slight modifications to work with SQL Server 2008. Due to operational constraints that some users of this query could face, we are building it to work in older systems.

Please read the explanation below, and check out the solutions we have so far. Please add any suggestions in an issue. If you have one, submit a pull request with an alternative solution.

# Calculating Multi-Hop Mobility using SQL
What is multi-hop? In our context, it is a large-scale overview of how people are moving by calculating anonymized, aggregated data of trips between specific points (i.e. cellphone towers), over the course of a day. To better the understand multi-hop, imagine 3 users (u1, u2, and u3) and 3 cellphone towers that they might ping off of (A, B, and C).

Over the course of a day, the first user may travel in such a way that, when using their phone, they ping the following towers:
AAAA BBB C A

Additional user trips might be:

u2: C A BB

u3: CC BBB A C

To calculate the mobility for each user user, we need to calculate all trips between areas, but not count "self-loops", or when the start and end towers are the same (i.e. A -> A).

First, we would simplify the trips to remove self-loops, finding their basic path in chronological order.

For example, u1: A, B, C, A

Next, we need to calculate all trips among these locations:

Single-hop trips:

A -> B, B -> C, C -> A

Two-hop trips:

A -> C, B -> A

Three-hop trips:

 A -> A (this can be thrown out, as it is a self loop)

# Pre-Requisite
1. A SQL environment: This project has been done with PostgreSQL and SQL Server 2008.
2. Environment to run bash script

# Database Structure

We want to create a databse table where the columns are
sim_id : identifier of sim card, which is a primary key
timestamp : datetime dd-mm-yyy hh:mm:ss, where hh is given in 24 hour format
event : the type of event that generated this row, can be sms, call, data, which is a varchar
site_id : antenna identifier, which is a varchar

However, the table structure above is just for testing purpose.

The database could be hundreds of thousands to millions of lines, so the query should be efficient. It could be broken down into parts and use temporary tables, for example, so portions of the query can be run at a time to minimize chances of timing out. Variable names should be clear, so that this can be easily adapted to multiple different databases.

# Example 1
Let's start with a simple example. In the example above, where the data for one user is u1: A, B, C, A, we have A B C A as the sequence. This is unidirectional, and we generate the permutation, while removing self-loop and duplicates.

A -> B: 1

B -> C: 1

C -> A: 1

A -> C: 1

# Example 2

Let's look at slightly more complicated example. The activity sequences are:

u1: AAAA BBB C A

u2: C A BB

u3: CC BBB A C

And we can write as below:

![Calculation from Given Example](./media/diagram1.png)

Calculting the hops result in:

The mobility results should be:

AB: 2

AC: 2

BA: 2

BC: 2

CA: 3

CB: 2


### Solutions so far

1. [A](https://github.com/unicef/magicbox-multihop-mobility/tree/master/solutions/computate) single query.
2. [Use](https://github.com/unicef/magicbox-multihop-mobility/tree/master/solutions/marcellamaki) a temporary table to store each individual's multi-hop trips, before performing an aggregation of all user multi-hop trips.
