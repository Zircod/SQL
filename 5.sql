-- Работаем с базой данных учителей teachers.db. Для каждого задания создайте запрос, сдать нужно только код запросов в
-- текстовом файле. Для решения воспользуйтесь вложенными запросами и UNION.
-- 1. Найдите потоки, количество учеников в которых больше или равно 40. В отчет выведите номер потока, название курса
-- и количество учеников.

SELECT
    id,
    course_id,
    students_amount
FROM streams
WHERE students_amount >= 40;

-- 2. Найдите два потока с самыми низкими значениями успеваемости. В отчет выведите номер потока, название курса,
-- фамилию и имя преподавателя (одним столбцом), оценку успеваемости.

SELECT
    stream_id,
    (SELECT name FROM courses WHERE courses.id =
                                (SELECT course_id FROM streams WHERE streams.id = grades.stream_id))
        AS course_name,
    (SELECT name  FROM teachers WHERE teachers.id = grades.teacher_id)
        AS teacher_name,
    grade
FROM grades
ORDER BY grade ASC
LIMIT 2;

-- 3. Найдите среднюю успеваемость всех потоков преподавателя Николая Савельева. В отчёт выведите идентификатор
-- преподавателя и среднюю оценку по потокам.

SELECT teacher_id, AVG(grade)
FROM grades
WHERE grades.teacher_id =
      (SELECT id FROM teachers WHERE surname = 'Савельев' AND name = 'Николай');

-- 4. Найдите потоки преподавателя Натальи Петровой, а также потоки, по которым успеваемость ниже 4.8. В отчёт выведите
-- идентификатор потока, фамилию и имя преподавателя.

SELECT
       stream_id,
       (SELECT name FROM teachers WHERE teachers.id = grades.teacher_id)
            AS teacher_name,
       (SELECT surname FROM teachers WHERE teachers.id = grades.teacher_id)
            AS teacher_surname
FROM grades
WHERE (grades.teacher_id =
      (SELECT id FROM teachers WHERE surname = 'Петрова' AND name = 'Наталья')) AND grade < 4.8;

-- 5. Дополнительное задание. Найдите разницу между средней успеваемостью преподавателя с наивысшим соответствующим
-- значением и средней успеваемостью преподавателя с наименьшим значением. Средняя успеваемость считается по всем
-- потокам преподавателя

SELECT
     MAX(final_grade) - MIN(final_grade)
FROM
     (SELECT teacher_id, AVG(grade) AS final_grade
     FROM grades
     GROUP  BY teacher_id);