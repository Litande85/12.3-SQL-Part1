#Получите уникальные названия районов из таблицы с адресами, 
#которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.
SELECT DISTINCT district 
FROM address 
WHERE district LIKE 'K%a' AND district NOT LIKE '% %' ;

#Получите из таблицы платежей за прокат фильмов информацию по платежам, 
#которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года включительно 
#и стоимость которых превышает 10.00.
SELECT * FROM payment 
WHERE payment_date BETWEEN '2005-06-15' AND '2005-06-19'
AND amount > 10;

#Получите последние пять аренд фильмов (в исходном порядке).
SELECT * FROM
(SELECT * FROM rental
ORDER BY rental_date DESC
LIMIT 5) t
ORDER BY rental_id;

#Одним запросом получите активных покупателей, имена которых Kelly или Willie. 
#Сформируйте вывод в результат таким образом:
#- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
#- замените буквы 'll' в именах на 'pp'.
SELECT REPLACE(lower_first_name, 'll', 'pp') new_first_name, new_last_name FROM
(SELECT LOWER(first_name) lower_first_name, LOWER(last_name) new_last_name FROM customer 
WHERE active NOT LIKE '0' 
AND first_name LIKE 'Kelly' OR first_name LIKE 'Willie') t;

#Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: 
#в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.
SELECT SUBSTRING_INDEX(email, '@', 1) as 1column, 
RIGHT (email, (CHAR_LENGTH(email) - CHAR_LENGTH(SUBSTRING_INDEX(email, '@', 1)) - 1)) as 2column
FROM customer;





#Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: 
#первая буква должна быть заглавной, остальные — строчными.
SELECT 
CONCAT(UPPER(LEFT (1column, 1)), LOWER(RIGHT(1column, (CHAR_LENGTH(1column)-1)))) as one_column, 
CONCAT(UPPER(LEFT (2column, 1)), LOWER(RIGHT(2column, (CHAR_LENGTH(2column)-1)))) as two_column
FROM
(SELECT SUBSTRING_INDEX(email, '@', 1) as 1column, 
RIGHT (email, (CHAR_LENGTH(email) - CHAR_LENGTH(SUBSTRING_INDEX(email, '@', 1)) - 1)) as 2column 
FROM customer) t;



