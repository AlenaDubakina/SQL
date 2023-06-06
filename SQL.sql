Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price (в долларах). Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.

1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

SELECT model, speed, hd FROM PC
WHERE PRICE < 500

2. Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT maker FROM Product
INNER JOIN Printer ON Product.model=Printer.model

3. Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

SELECT model, ram, screen FROM Laptop
WHERE price > 1000

4. Найдите все записи таблицы Printer для цветных принтеров.

SELECT * FROM Printer 
WHERE color='y'

5. Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

SELECT model, speed, hd FROM PC
WHERE price<600 AND (cd='12x' OR cd='24x')

6. Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT DISTINCT Product.maker, Laptop.speed
FROM Laptop
INNER JOIN Product ON Laptop.model=Product.model
WHERE hd>=10

7.Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

SELECT Product.model, PC.price
FROM Product
INNER JOIN PC ON PC.model=Product.model
WHERE maker='B'
UNION
SELECT Product.model, Laptop.price
FROM Product
INNER JOIN Laptop ON Laptop.model=Product.model
WHERE maker='B'
UNION
SELECT Product.model, Printer.price
FROM Product
INNER JOIN Printer ON Printer.model=Product.model
WHERE maker='B'

8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.

SELECT maker FROM Product
WHERE type='PC'
EXCEPT
SELECT maker FROM Product
WHERE type='Laptop'

9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

SELECT DISTINCT maker FROM Product
INNER JOIN PC ON PC.model=Product.model
WHERE PC.speed>=450

10.Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

SELECT model, price
FROM Printer
WHERE price=(SELECT MAX(price) FROM Printer)

11. Найдите среднюю скорость ПК.

SELECT AVG(speed) FROM PC

12.Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT AVG(speed) FROM Laptop
WHERE price>1000

13.Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT AVG(speed) FROM PC
INNER JOIN Product ON Product.model=PC.model
WHERE maker='A'

14. Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT Ships.class, Ships.name, Classes.country FROM Ships
INNER JOIN Classes ON Ships.class=Classes.class
WHERE numGuns >=10

15.Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT hd FROM PC
GROUP BY hd
HAVING COUNT(model) >= 2