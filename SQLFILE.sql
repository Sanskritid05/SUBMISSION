create database data_Analysis ; 
use data_Analysis ;

-- ## 1. Total Sales and Profit by Region for 2022

-- calculated Total Sales and Profit by Region for  the year2022
select s.Region , round(sum(sales_amount), 2)as Total_Sales ,
round(sum(profit) ,2) as Profit
from sales_data s 
join targets t on t.Region = s.Region 
where year in(2022) 
group by s.region ; 

-- ## 2. Top 5 customers based on total purchase

-- ### Top 5 customers with highest total purchase
select cd.customerid , count(Orderid)
from customer_data cd
join sales_data sd
on cd.customerid = sd.customerid 
group by cd.customerid
order by count(Orderid) desc
limit 5;

-- ##Products with >20% discount but positive profit

-- ### products with profit > 0 , discount > 20
select productname 
from product_data pd
join sales_data sd on pd.productid = pd.productid 
where `Discount (%)` > '20' and Profit > 0; 

-- ##Region-wise average discount

-- ### average discount --> Region-wise 
select Region , round(avg(`Discount (%)`) , 2) Avg_Discount
from sales_data 
group by region;

-- ##Year-wise sales growth %

-- ### yearly profit earned
select distinct(year) year, round(avg(profit), 2)Profit
from targets t 
join sales_data sd on sd.region = t.region 
group by year;

-- ##Product category with highest profit margin
select distinct(category) , round(sum(profit) ,2) Profit_Margin from 
product_data pd
join sales_data sd on pd.productid =  sd.productid
group by category;

-- ##AOV per customer segment
-- ##Top 3 products with continuous yearly sales growth