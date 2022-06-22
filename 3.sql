ALTER TABLE streams RENAME COLUMN start_date TO started_at;

ALTER TABLE streams ADD COLUMN finished_at TEXT;

ALTER TABLE streams ADD COLUMN students_amount INTEGER NOT NULL;

INSERT INTO streams (number, course_id, started_at, students_amount) VALUES
(165, 3, '18.08.2020', 34), 
(178, 2, '02.10.2020', 37), 
(203, 1, '12.11.2020', 35), 
(210, 1, '03.12.2020', 41);		
		
INSERT INTO teachers (name, surname, email) VALUES
('Николай', 'Савельев', 'saveliev.n@mai.ru'),								
('Наталья', 'Петрова', 'petrova.n@yandex.ru'), 						
('Елена', 'Малышева', 'malisheva.e@google.com');

UPDATE teachers SET email = 'saveliev.n@mail.ru' WHERE name = 'Николай';
				
INSERT INTO courses (name) VALUES
('Базы данных'), 
('Основы Python'), 
('Linux. Рабочая станция');											

INSERT INTO grades (teacher_id, stream_id, grade) VALUES
(3, 1, 4.7), 
(2, 2, 4.9), 
(1, 3, 4.8), 
(1, 4, 4.9);

