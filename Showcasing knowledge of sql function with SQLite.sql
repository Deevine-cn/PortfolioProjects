-- Who is the top donor working in Business Development living in California?
Select first_name, last_name, donation
From Donation_Data
where job_field = 'Business Development' and state = 'California'
order by donation DESC

--Who has an email address ending with '.info' and What are their names?
Select first_name, last_name, email
From Donation_Data
where email like '%.info' 

--Which donor has a first name that starts with a 'G' and ends with a 't' ?
Select first_name, last_name
From Donation_Data
where first_name like 'G%t' 

--How many donors have a shirt size of 3XL and live in Colorado?
Select count (shirt_size) as Number_of_Donors
From Donation_Data
where shirt_size ='3XL' AND state = 'Colorado'

--Of the female donors who are working in the legal industry and donated over $300 -  which 5 donated the least?
Select first_name, last_name, gender, job_field, donation
From Donation_Data
where gender ='Female' and job_field = 'Legal' and donation > 300
order by donation
Limit 5

--What is the total donation amount from the state of Georgia?
select sum(donation)
from Donation_Data
where state = 'Georgia'

--How many donors from California have a first name that ends with an 'e'?
select COUNT(first_name)
from Donation_Data
where state = 'California' and first_name like '%e'

-- What is the minimum donation from women working in the Legal industry?
select min(donation)    
from Donation_Data
where gender = 'Female' and job_field = 'Legal'

--What is the maximum donation from men in Ohio working in Sales? 
select max(donation)    
from Donation_Data
where gender = 'Male' and job_field = 'Sales' and state = 'Ohio'

--What is the average donation from men with an XS shirt size? 
select avg(donation)    
from Donation_Data
where gender = 'Male' and shirt_size = 'XS' 

-- the total donations per job field, but only for job fields with over 80 donations. 
SELECT job_field, sum(donation)
from Donation_Data
group BY job_field
having COUNT(donation) > 80