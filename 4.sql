-- 1. Преобразовать дату начала потока в таблице потоков к виду год-месяц-день. Используйте команду UPDATE.

UPDATE streams SET started_at = SUBSTR (started_at, 7, 4) || '-' ||
                                SUBSTR (started_at, 4, 2) || '-' || SUBSTR (started_at, 1, 2);

-- 2. Получите идентификатор и номер потока, запланированного на самую позднюю дату.

SELECT id, number, MAX(started_at) FROM streams;

-- 3. Покажите уникальные значения года по датам начала потоков обучения.

SELECT DISTINCT(SUBSTR(started_at, 1, 4)) AS 'year' FROM streams;

-- 4. Найдите количество преподавателей в базе данных. Выведите искомое значение в столбец с именем total_teachers.

SELECT COUNT(*) AS 'total_teachers' FROM teachers;

-- 5. Покажите даты начала двух последних по времени потоков.

SELECT * FROM streams ORDER BY started_at DESC LIMIT 2;

SELECT started_at FROM streams ORDER BY started_at DESC LIMIT 2;

-- 6. Найдите среднюю успеваемости учеников по потокам преподавателя с идентификатором равным 1.

SELECT teacher_id, AVG(grade) FROM grades WHERE teacher_id = 1;

-- 7. Дополнительное задание (выполняется по желанию): найдите идентификаторы преподавателей,
-- у которых средняя успеваемость по всем потокам меньше 4.8.

SELECT teacher_id, AVG(grade) AS 'avg_grade' FROM grades GROUP BY teacher_id HAVING avg_grade < 4.8;



