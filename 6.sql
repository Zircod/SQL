-- Работаем с базой данных учителей teachers.db. Для решений воспользуйтесь объединением JOIN, не используйте вложенные
-- запросы и объединение UNION.
-- 1. Покажите информацию по потокам. В отчет выведите номер потока, название курса и дату начала занятий.

SELECT
    streams.number AS stream_number,
    courses.name AS course_name,
    streams.started_at
FROM courses JOIN streams
ON courses.id = streams.course_id;

-- 2. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и количество учеников по всем
-- потокам курса.

SELECT
    courses.name AS course_name,
    SUM(streams.students_amount) AS students_total
FROM courses JOIN streams
ON courses.id = streams.course_id
GROUP BY courses.id;

-- 3. Для всех учителей найдите среднюю оценку по всем проведённым потокам. В отчёт выведите идентификатор, фамилию и имя
-- учителя, среднюю оценку по всем проведенным потокам. Важно чтобы учителя, у которых не было потоков, также попали в
-- выборку.

SELECT
    teachers.surname,
    teachers.name,
    AVG(grades.grade) AS grade_avg
FROM teachers LEFT JOIN grades
ON teachers.id = grades.teacher_id
GROUP BY teachers.id;

-- 4. Дополнительное задание. Для каждого преподавателя выведите имя, фамилию, минимальное значение успеваемости по всем
-- потокам преподавателя, название курса, который соответствует потоку с минимальным значением успеваемости, максимальное
-- значение успеваемости по всем потокам преподавателя, название курса, соответствующий потоку с максимальным значением
-- успеваемости, дату начала следующего потока.

SELECT
    teachers.surname,
    teachers.name,
    MIN(grades.grade) AS grade_min,
    courses.name AS course_name,
    MAX(grades.grade) AS grade_max,
    courses.name AS course_name,
    streams.started_at
FROM teachers
    JOIN grades
    ON teachers.id = grades.teacher_id
    JOIN streams
    ON grades.stream_id = streams.id
    JOIN courses
    ON streams.course_id = courses.id
GROUP BY teachers.id;