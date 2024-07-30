-- check out the data
select *
from layoffs;

-- create a new table for edits
create table layoffs_staging
like layoffs;

insert layoffs_staging
select *
from layoffs;

select *
from layoffs_staging;

-- adding a new column for row numbers so I can ascertain if there are duplicates easily and remove them
With duplicate_cte AS
(
select *,
row_number() over (
partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions ) as row_num
from layoffs_staging
)
Select *
from Duplicate_cte
Where row_num > 1;

Select *
from layoffs_staging
where company = 'Casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_staging2; 

Insert into layoffs_staging2
select *,
row_number() over (
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions ) as row_num
from layoffs_staging;

select *
from layoffs_staging2
where row_num > 1; 

Delete
from layoffs_staging2
where row_num > 1; 

select *
from layoffs_staging2;
  
  -- standardizing the data
  
select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry 
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'crypto%';

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'united states%';

select date
from layoffs_staging2;

UPDATE layoffs_staging2
SET DATE = str_to_date(date,'%m/%d/%Y');

Alter table layoffs_staging2
modify column date date;

select *
from layoffs_staging2;

-- dealing with null and blanks

select * from  layoffs_staging2
where industry is null or industry = '';

update layoffs_staging2
set industry = null
where industry = ''; 

select *
from layoffs_staging2
where company = 'airbnb';

select *
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
	and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;

-- remove data that you are confident you do not need
delete from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;
