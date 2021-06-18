use classicmodels;


select p.productName ProductName, p.productline ProductLine, o.ordernumber OrderNumber
from orderdetails o 
join products p
on p.productCode = o.productcode;

select * from payments;
select c.customername CustomerName, c.country Country, sum(pa.amount) Total_Amount
from payments pa 
join customers c
on c.customernumber = pa.customernumber
group by CustomerNAme, country;


select * from customers;
select * from employees;
select * from orders;

select c.country Country, count(distinct(c.customername)) "No of customer", 
concat(e.firstname,' ',e.lastname) Sales_Represetative , ord.quantityordered*ord.priceeach sales
from employees e 
join customers c
on c.salesrepemployeenumber = e.employeeNumber
join orders o 
on o.customernumber = c.customernumber
join orderdetails ord
on o.ordernumber = ord.ordernumber
group by country;



select sum(ord.quantityordered*ord.priceeach) Total_sales, 
concat(e.firstname,' ',e.lastname) Sales_Represetative, p.productline ProductLine
from products p 
join orderdetails ord
on  p.productcode = ord.productcode
join orders o
on ord.ordernumber = o.ordernumber
join customers c
on o.customernumber = c.customernumber
join employees e
on c.salesrepemployeenumber = e.employeenumber
group by Sales_Represetative;



select c.customername customername, sum(p.amount) total_purchase 
from customers c 
join payments p
on c.customernumber = p.customernumber
where customername like "a%"
group by customername;

select c.customername customername,
ord.quantityordered*ord.priceeach total_sales,
(ord.quantityordered*ord.priceeach)-( p.buyprice*ord.quantityordered) profit
from customers c
join orders o 
on o.customernumber = c.customernumber
join orderdetails ord 
on ord.ordernumber = o.ordernumber
join products p
on p.productcode = ord.productcode
where customername like "a%"
group by customername;

select p.productline Productline, 
sum(ord.quantityordered*ord.priceeach)-sum( p.buyprice*ord.quantityordered) profit,
(p.quantityinstock-ord.quantityordered) stocked_inventory
from products p
join orderdetails ord
on p.productcode = ord.productcode
group by Productline;




select c.customername customername, sum(ord.quantityordered*ord.priceeach) total_purchase, 
c.creditlimit CreditLimit, 
((c.creditlimit-sum(ord.quantityordered*ord.priceeach))/c.creditlimit)*100 percentage_deviation
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails ord 
on o.ordernumber = ord.ordernumber
group by customername;


create view temp as
select  concat(e.firstname,' ',e.lastname) Sales_Represetativec, salesrepemployeenumber salesman_number, 
sum(ord.quantityordered*ord.priceeach) total_revenue_generated,
count(distinct(c.customernumber)) total_customers
from employees e
join customers c
on c.salesrepemployeenumber = e.employeenumber
join orders o 
on c.customernumber = o.customernumber
join orderdetails ord 
on ord.ordernumber = o.ordernumber
group by salesman_number
order by total_revenue_generated, total_customers;
select * from temp;

select * from orderdetails;
select * from productlines;
select * from products;
select * from payments;
select * from customers;
select * from employees;
select * from orders;
select * from offices;


create view temp as
select concat(c.contactfirstname,' ',c.contactlastname) ContactFullName, c.creditlimit creditlimit,
c.country country, concat(e.firstname,' ',e.lastname) Sales_Represetative,
ord.quantityordered*ord.priceeach total_purchase, pa.amount Amount,
( p.buyprice*ord.quantityordered) Actual_buy_price, p.productline productline
from employees e
join customers c
on c.salesrepemployeenumber = e.employeenumber
join payments pa 
on c.customernumber = pa.customernumber
join orders o
on o.customernumber = pa.customernumber
join orderdetails ord
on ord.ordernumber = o.ordernumber
join products p
on p.productcode = ord.productcode;


create index customerNumber_index
on customers (customernumber);

select customernumber from customers;

