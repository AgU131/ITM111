-- STEP 3: Load the University database

-- Insert college
SELECT * FROM college;
INSERT INTO college VALUES
    (1, 'College of Physical Science and Engineering'),
    (2, 'College of Business and Communication'),
    (3, 'College of Language and Letters');

-- Insert department
SELECT * FROM department;
INSERT INTO department VALUES	-- (department_id, department_code, department, college_id)
(1, 'ITM', 'Computer Information', 1),
(2, 'ECON', 'Economics', 2),
(3, 'HUM', 'Humanities and Philosophy', 3);

-- Insert course
SELECT * FROM course;
INSERT INTO course VALUES		-- (course_id, course_num, course_title, credits, course, department_id)
(1, 111, 'Intro to Databases', 3, 'ITM 111', 1),
(2, 388, 'Econometrics', 4, 'ECON 388', 2),
(3, 150, 'Micro Economics', 3, 'ECON 150', 2),
(4, 376, 'Classical Heritage', 2, 'HUM 376', 3);

-- Insert term
SELECT * FROM term;
INSERT INTO term VALUES			-- (term_id, term, year)
(1, 'Fall', 2019),
(2, 'Winter', 2018);

-- Insert faculty
SELECT * FROM faculty;
INSERT INTO faculty VALUES		-- (faculty_id, faculty_fname, faculty_lname)
(1, 'Marty', 'Morring'),
(2, 'Nate', 'Norris'),
(3, 'Ben', 'Barrus'),
(4, 'John', 'Jensen'),
(5, 'Bill', 'Barney');

-- Insert section
SELECT * FROM section;
INSERT INTO section VALUES		-- (section_id, section_number, capacity, faculty_id, course_id, term_id)
(1,1,30,1,1,1), -- ITM 111 1 Fall
(2,1,50,2,3,1), -- ECON 150 1 Fall
(3,2,50,2,3,1), -- ECON 150 2 Fall
(4,1,35,3,2,1), -- ECON 388 1 Fall
(5,1,30,4,4,1), -- HUM 376 1 Fall
(6,2,30,1,1,2), -- ITM 111 2 Winter
(7,3,35,5,1,2), -- ITM 111 3 Winter
(8,1,50,2,3,2), -- ECON 150 1 Winter
(9,2,50,2,3,2), -- ECON 150 2 Winter
(10,1,30,4,4,2); -- HUM 376 1 Winter

-- Insert student
SELECT * FROM student;
INSERT INTO student VALUES		-- (student_id, fname, lname, gender, city, state, birthdate)
(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
(2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
(3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
(4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
(5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
(6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
(7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
(8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
(9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
(10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

-- INSERT INTO enrollment VALUES;
SELECT * FROM enrollment;
INSERT INTO enrollment VALUES
(6,7),
(7,6),
(7,8),
(7,10),
(4,5),
(9,9),
(2,4),
(3,4),
(5,4),
(5,5),
(1,1),
(1,3),
(8,9),
(10,6);


-- STEP 4: Query the University database

USE university;

-- Query 1: Students, and their birthdays, of students born in September. Format the date to look like it is shown in the result set. Sort by the student's last name.
SELECT fname, lname, birthdate AS 'Sept Birthdays'
FROM student
WHERE MONTH(birthdate) = 9;

-- Query 2: Student's age in years and days as of Jan. 5, 2017. Sorted from oldest to youngest. (You can assume a 365 day year and ignore leap day.) Hint: Use modulus for days left over after years. The 5th column is just the 3rd and 4th column combined with labels.
SELECT 
	lname, fname, 
	FLOOR(DATEDIFF('2017-1-5', birthdate)/365) AS Years, 
	MOD(DATEDIFF('2017-1-5', birthdate),365) AS Days, 
    CONCAT(FORMAT(DATEDIFF('2017-1-5', birthdate)/365, 0), '- Yrs, ', DAY(birthdate), ' - Days') AS "Years and Days"
FROM student
ORDER BY Years DESC, Days DESC;

-- Query 3: Students taught by John Jensen. Sorted by student's last name
SELECT fname, lname
FROM student stu
	JOIN enrollment e
    ON stu.student_id = e.student_id
    JOIN section s
    ON e.section_id = s.section_id
    JOIN faculty f
    ON s.faculty_id = f.faculty_id
WHERE f.faculty_fname = 'John' AND f.faculty_lname = 'Jensen'
ORDER BY lname;

-- Query 4: Instructors Bryce will have in Winter 2018. Sort by the faculty's last name.
SELECT faculty_fname, faculty_lname
FROM faculty f
    JOIN section s
    ON s.faculty_id = f.faculty_id
	JOIN enrollment e
    ON e.section_id = s.section_id
	JOIN student stu
    ON stu.student_id = e.student_id
WHERE stu.fname = 'Bryce' AND s.term_id = 2
ORDER BY faculty_lname;

-- Query 5: Students that take Econometrics in Fall 2019. Sort by student last name.
SELECT fname, lname
FROM student stu
	JOIN enrollment e
    ON stu.student_id = e.student_id
    JOIN section s
    ON e.section_id = s.section_id
    JOIN course c
    ON s.course_id = c.course_id
WHERE c.course_title = 'Econometrics' AND s.term_id = 1
ORDER BY lname;

-- Query 6: Report showing all of Bryce Carlson's courses for Winter 2018. Sort by the name of the course.
SELECT department_code, course_num, course_title AS name
FROM student stu
	JOIN enrollment e
    ON stu.student_id = e.student_id
    JOIN section s
    ON e.section_id = s.section_id
    JOIN course c
    ON s.course_id = c.course_id
    JOIN department d
    ON c.department_id = d.department_id
WHERE stu.student_id = 7
ORDER BY name;

-- Query 7: The number of students enrolled for Fall 2019
SELECT t.term, t.year, COUNT(e.student_id) AS Enrollment
FROM enrollment e
    JOIN section s
    ON e.section_id = s.section_id
    JOIN term t
    ON s.term_id = t.term_id
WHERE t.term_id = 1;


SELECT COUNT(student_id)
FROM enrollment;

SELECT COUNT(DISTINCT e.student_id) AS total_students
FROM enrollment e
	JOIN section sec 
	ON e.section_id = sec.section_id
WHERE sec.term_id = 1;

-- Query 8: The number of courses in each college. Sort by college name.
SELECT college AS Colleges, COUNT(course_id) AS Courses
FROM college c
	JOIN department d
    ON c.college_id = d.college_id
    JOIN course co
    ON d.department_id = co.department_id
GROUP BY c.college_id
ORDER BY Courses DESC;

-- Query 9: The total number of students each professor can teach in Winter 2018. Sort by that total number of students (teaching capacity).
SELECT faculty_fname AS fname, faculty_lname AS lname, SUM(capacity) AS TeachingCapacity
FROM faculty f
    JOIN section s
    ON s.faculty_id = f.faculty_id
WHERE term_id = 2
GROUP BY f.faculty_id
ORDER BY TeachingCapacity;

-- Query 10: Each student's total credit load for Fall 2019, but only students with a credit load greater than three.  Sort by credit load in descending order.
SELECT lname, fname, SUM(c.credits) AS Credits
FROM student stu
	JOIN enrollment e
    ON stu.student_id = e.student_id
    JOIN section s
    ON e.section_id = s.section_id
    JOIN course c
    ON s.course_id = c.course_id
WHERE s.term_id = 1
GROUP BY stu.student_id
HAVING Credits > 3
ORDER BY Credits DESC;


 