-- employeeに対して、viewを実行するsql --
CREATE VIEW employee_view AS SELECT * FROM employee;
-- employee_viewに対して、viewを実行するsql --
SELECT * FROM employee_view;

-- employee_viewを削除するsql --
DROP VIEW employee_view;

-- dependentに対して、viewを実行するsql --
CREATE VIEW dependent_view AS SELECT * FROM dependent;
-- dependent_viewに対して、viewを実行するsql --
SELECT * FROM dependent_view;

-- dependent_viewを削除するsql --
DROP VIEW dependent_view;