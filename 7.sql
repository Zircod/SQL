-- Работаем с базой данных учителей teachers.db.
-- 1. Создайте представление, которое для каждого курса выводит название, номер последнего потока, дату начала обучения
-- последнего потока и среднюю успеваемость курса по всем потокам.

CREATE VIEW 'courses_info' AS
SELECT
    courses.name AS course_name,
    MAX(streams.number) AS stream_number_last,
    streams.started_at,
    AVG(grades.grade) AS grade_avg
FROM courses
    JOIN streams
    ON courses.id = streams.course_id
    JOIN grades
    ON streams.id = grades.stream_id
GROUP BY courses.name;

-- 2. Удалите из базы данных всю информацию, которая относится к преподавателю с идентификатором, равным 3. Используйте
-- транзакцию.

BEGIN TRANSACTION;
    DELETE FROM grades WHERE teacher_id = 3;
    DELETE FROM teachers WHERE id = 3;
COMMIT;

-- 3. Создайте триггер для таблицы успеваемости, который проверяет значение успеваемости на соответствие диапазону
-- чисел от 0 до 5 включительно.

CREATE TRIGGER check_grade_level BEFORE INSERT
ON grades
BEGIN
    SELECT CASE
    WHEN
        (NEW.grade NOT BETWEEN 1 AND 5)
    THEN
        RAISE(ABORT, 'Wrong format grade')
    END;
END;

-- 4. Дополнительное задание. Создайте триггер для таблицы потоков, который проверяет, что дата начала потока больше
-- текущей даты, а номер потока имеет наибольшее значение среди существующих номеров. При невыполнении условий необходимо
-- вызвать ошибку с информативным сообщением.

CREATE TRIGGER 'check_data_started_number_streams' BEFORE INSERT
ON streams
BEGIN
    SELECT CASE
    WHEN
        (NEW.started_at <= DATE('now'))
        OR(NEW.number < MAX(number))
    THEN
        RAISE(ABORT, 'Wrong data started or number stream')
    END;
END;


INSERT INTO streams (id, number, course_id, started_at, finished_at, students_amount) VALUES
(5, 177, 3, '2020-12-04', 'null', 35);
