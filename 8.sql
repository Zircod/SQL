-- Работаем с базой данных учителей teachers.db. Для каждого задания требуется сдать только код, который выполняется для
-- получения результата, в текстовом файле. В качестве отчёта к четвёртому заданию надо приложить скриншот.
-- 1. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и количество учеников по всем
-- потокам курса. Решите задание с применением оконных функций.

SELECT DISTINCT
    courses.name,
    SUM (streams.students_amount) OVER (PARTITION BY courses.id) AS students_amount
FROM courses
    LEFT JOIN streams
        ON courses.id = streams.course_id
ORDER BY courses.name;


-- 2. Найдите среднюю оценку по всем потокам для всех учителей. В отчёт выведите идентификатор, фамилию и имя учителя,
-- среднюю оценку по всем проведённым потокам. Учителя, у которых не было потоков, также должны попасть в выборку. Решите
-- задание с применением оконных функций.

SELECT DISTINCT
    teachers.id,
    teachers.name,
    teachers.surname,
    AVG(grades.grade) OVER (w_teachers) AS grade_avg
FROM teachers
    LEFT JOIN grades
        ON teachers.id = grades.teacher_id
WINDOW w_teachers AS (PARTITION BY teachers.id)
ORDER BY teachers.id;


-- 3. Какие индексы надо создать для максимально быстрого выполнения представленного запроса?
SELECT
    surname,
    name,
    number,
    performance
FROM academic_performance
         JOIN teachers
              ON academic_performance.teacher_id = teachers.id
         JOIN streams
              ON academic_performance.stream_id = streams.id
WHERE number >= 200;


CREATE INDEX students_surname_name_idx ON students(surname,name);


-- 4. Установите SQLiteStudio, подключите базу данных учителей, выполните в графическом клиенте любой запрос.

-- lesson-8.4.jpg


-- 5. Дополнительное задание. Для каждого преподавателя выведите имя, фамилию, минимальное значение успеваемости по всем
-- потокам преподавателя, название курса, который соответствует потоку с минимальным значением успеваемости, максимальное
-- значение успеваемости по всем потокам преподавателя, название курса, соответствующий потоку с максимальным значением
-- успеваемости, дату начала следующего потока. Выполните задачу с использованием оконных функций.

SELECT DISTINCT
    teachers.name,
    teachers.surname,
    MIN(grades.grade) OVER (w_teachers) AS min_grade,
    courses.name AS course_name_with_min_grade,
    MAX(grades.grade) OVER (w_teachers) AS max_grade,
    courses.name AS course_name_with_max_grade,
    streams.started_at
FROM teachers
         JOIN grades
              ON teachers.id = grades.teacher_id
         JOIN streams
              ON grades.stream_id = streams.id
         JOIN courses
              ON streams.course_id = courses.id
    WINDOW w_teachers AS (PARTITION BY teachers.id)
ORDER BY teachers.id;