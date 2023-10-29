# ECommerce Business Performance Analysis


<img src="https://img.freepik.com/free-vector/online-job-interview_23-2148613123.jpg?w=1060&t=st=1698482107~exp=1698482707~hmac=6166aa6c3b8096f1abab590923534e0e37b13e019ac0931e8fcb459fc371e8c6" alt="eCommerce" style="width:700px;height:500px;" align="center">


In the past, a company's reach was limited by the number of customers who could physically enter via a store's front doors. E-commerce now allows us to access customers all over the world. The growth of social media and the rise of internet usage have made it easier for e-commerce business owners to reach a wide new mix of customers.  
To support the performance of an e-commerce business, past evaluation and analysis are needed to improve the performance and scope of a business.  

This project will analyze an e-commerce business performance using SQL and data visualization by PowerBI to improve business performance by giving business recommendations at the end.  

## Points to Analyze  
- **Annual Customer Activity Growth**   
- **Annual Product Category Quality**   
- **Annual Payment Type Usage**


## Data Preparation  
The first step to analyze is ensuring the data is ready to be used. A local database was created by PostgreSQL to load the 8 datasets and make a data relationship diagram to ensure integrity within the database. Our datasets in a nutshell can be seen from the diagram below.  

<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/d9c1cc82-9ca0-4caf-aa62-99b316cba894" alt="erd" style="width:600px;height:350px;">

## 1. Annual Customer Activity Growth  
<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/d20bb731-ebf0-46eb-9bc3-bf7a8ad24227" alt="table_customer_growth" style="width:500px;height:125px;">  

**Description** 

- **Average MAU**: The average Monthly Active Users (MAU) per year  
- **Total New Cust**: Total of new customers each year   
- **Total Cust Repeat Oder**: Total customers who repeat orders in a year  

<br>
<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/7c4a4398-9f79-427e-9ba4-8bd8281ddde3" alt="MAU_cust1" style="width:350px;height:250px;">  
<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/545cd2f9-a0cb-4491-9b87-eca0c100a9ee" alt="MAU_cust2" style="width:350px;height:250px;">    
<br>
From the graph of Average MAU, we can see that active users per year have increased rapidly from 2016 to 2017 and grew constantly until 2018. The same thing goes with total new customers which grew tremendously from under 1k to 52k. We can conclude that new customers have a big impact on active user growth.
<br> <br>

<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/68a5fd50-fb55-4e05-9517-86caf1181758" alt="MAU_cust3" style="width:350px;height:250px;">
<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/ba246f6b-dbf4-4c90-a571-e168f7ae88a6" alt="MAU_cust4" style="width:350px;height:250px;">   
<br>

Now from the order analysis, on average we can say each customer ordered just once. 
Meanwhile, the total number of customers who repeated orders increased from 2016 (only 3 customers) to 2017 (1256 customers), but then decreased to 1167 in 2018. If we combine the customer and order analysis where 2017 is the top year for customer growth, it seems that some of our products last more than year such as furniture or houseware, so they don’t buy the same thing again. This decrease doesn't seem bad.
<br>

## 2. Annual Product Category Quality  
<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/d99fc1e6-c595-4aa2-9aba-971d5bcddce2" alt="table_product" style="width:660px;height:140px;">  

**Description**  

- **Total Revenue:** Total revenue per year  
- **Top Product:** Top product category name with the most transactions of the year  
- **Revenue of Top Product:** Revenue of top product  
- **Total Canceled:** Total canceled transactions  
- **Most Canceled Product:** Product category name with the most cancellations of the year  
- **Total Product Canceled:** Number of product categories with the most cancellations of the year  
<br>

<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/7d588a40-c2ae-42af-8441-003a012ccf6d" alt="pro_quality1" style="width:350px;height:230px;">
<img src="https://github.com/Yunanouv/ECommerce-Business-Performance-Analysis/assets/146415555/742ff304-9d2e-4395-a810-eb616c389488" alt="pro_quality1" style="width:350px;height:230px;">  
<br>
Due to many new customers especially since 2017, the revenue grew rapidly as well. If we look closer at the product category which gave high revenue, we got Health-Beauty as the top product in 2018, Bed-Bath-Table in 2017, and Furniture-Decor in 2016.  
Just as delivered orders are increasing, canceled orders are also increasing. As the graph shows, there is an increasing amount of canceled orders behind the rising revenue. Then, if we look at the product categories, the graph also shows the total product categories with the most canceled orders.
<br><br>























