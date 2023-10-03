# 1. How many types of tigers can be found in the taxonomy table of the dataset? What is the "ncbi_id" of the Sumatran Tiger?
select count(distinct species)Types_of_tiger from taxonomy
where species Like '%Tiger%' ;
select ncbi_id,species from taxonomy 
where  species LIKE '%sumatran Tiger%';

# 2.Find all the columns that can be used to connect the tables in the given database.

select * from INFORMATION_SCHEMA.COLUMNS ;

#3.Which type of rice has the longest DNA sequence? (hint: use the rfamseq and the taxonomy tables)


SELECT t.species, MAX(LENGTH(r.rfamseq_acc)) AS max_sequence_length
FROM rfamseq AS r
INNER JOIN taxonomy AS t ON r.ncbi_id = t.ncbi_id
WHERE t.species LIKE '%rice%'
GROUP BY t.species
ORDER BY max_sequence_length DESC
LIMIT 3;


# 4. We want to paginate a list of the family names and their longest DNA sequence lengths (in descending order of length) where only
# families that have DNA sequence lengths greater than 1,000,000 are included. Give a query that will return the 9th page when there
# are 15 results per page. (hint: we need the family accession ID, family name and the maximum length in the results)

select fn.rfam_acc,f.author,max(length) from family f
inner join family_ncbi fn on fn.rfam_id=f.rfam_id
inner join rfamseq_temp rt on rt.ncbi_id =fn.ncbi_id
WHERE length > 1000000
GROUP BY rt.length
ORDER BY rt.length DESC
LIMIT 9 OFFSET 15 ;