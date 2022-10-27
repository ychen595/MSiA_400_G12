# MSiA_400_G12
Repo for the team project of MSiA 400: Everything Starts with Data

## Weekly Updates: 

### Until Oct 14th 2022

**What we’ve done (up to Oct 14th):**

- Downloaded pgAdmin, connected to MSiA’s Postgres server, and explored pgAdmin.

- Created a private repository in GitHub through the MSiA organization and gave access to everyone in the team, the instructor and the TA.

- Created the tables in Postgres following the database schema and granted access to everyone in the team. 

- Tried to populate the dataset. We managed to populate 3 out of the 5 tables (strinfo, skstinfo and deptinfo), but encountered problems when populating skuinfo and transact due to uncleaned data (mainly observations using commas for a specific entry that are generating extra columns in some rows).  

- Started cleaning the tables that have messy data in the command line. 

**Plan for the next week (Oct 17th-21th):**

- Fix problems in tables skuinfo and transact using command line and/or Python and/or R and import all datasets into Postgres.

- Data exploration on the database and understand the meaning or relationship between each column.

- Sample the dataset to find the most appropriate subsets. 

- Define ML questions. 

### Oct 17th - Oct 21st 

**What we’ve done this week:**

- Finished cleaning the *skuinfo* table for uploading purposes. This table had 8,148 rows that had more columns than expected. The problem developed mainly from the *color* and *company* fields which are non-quoted strings and had some comas that were causing extra columns. This problematic rows were fixed by replacing the wrong patterns for corrected versions (eg: "BB CO, I" --> "BB CO I"). See the *Clean_SKUINFO_TRNSACT.txt* file in *02_Data_Cleansing* for further details. 

- Finished cleaning the *trnsact* table for uploading purposes. The columns in this table did not correspond to those in the schema provided. Additionally, it presented two columns that where almost exactly equal (except for 7 observations). This rows were removed from the database as well as the duplicated column. 

- Finished uploading all tables into Postgres.

- We started the EDA on the tables with the goal of understanding how the data is related in order to be able to formulate our business and ML questions. The EDA included: 

	- For the transaction data we took a random sample of 100,000 observations to check the data distribution, correlation among variables and verify the presence of outliers. 

	- For the store data, we worked on Dillards' store location by state. 

	- For the SKU data, we joined it with DEPT table and checked the distribution of packsize, brand and department. 
	
	- For the relationship between SKU and store data, we took a look at the distribution of cost price and retial price for each SKU. Also, we found out there were various SKUs whose either cost price or retail price was zero and assumed that they might be some special SKUs.

- We formulated two plausible business questions: 
	
	1. Increasing revenue is the goal of any retail store. Predicting the next quarter's total sales for each brand on each store could suppor managment decisions. 

	2. Product return is a significant problem in the retail world that causes a decrease in revenues. Therefore, we could predict next quarter's return probability for each brand on each store.


**What we're going to do the next week (Oct 24th-28th)**

- Talk to the professor to receive oriententation regarding our two possible business questions. 

- Define the business problem and research more about how it is takled in the industry. 

- Define the appropiate ML learning question to address the buisness problem. 

- Keep working on the data cleansing and EDA. 


### Oct 22th - Oct 28st 

**What we’ve done this week:**
- Continue EDA work to explore feature distribution; taken outliers.
- Discussed more details on both of the possible business problems. We selected as our buisness question: "predict next quarter's return probability for each brand on each store," which we believe has more business insight.
- We discussed our ML problem. We aim to estimate logistic regression, decision forest and SVM to compare the performance of the algorithms. 
- Talk to the professor to recieve orientation regarding the most adequate ML algorithm to solve the buisness question. 


**What we're going to do the next week (Oct 29th-Nov. 5th)**

- Try to finish EDA work
- Define the ML problem.
- Start modeling. 

