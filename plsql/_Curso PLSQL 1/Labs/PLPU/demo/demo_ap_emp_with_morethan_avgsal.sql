select e.employee_id, e.last_name, e.salary, j.job_id,  j.min_salary, j.max_salary,
         (SELECT decode(count(*), 1, 'YES', 'NO') 
          FROM JOBS
          WHERE e.salary not between min_salary AND max_salary) valid_sal
FROM employees e, jobs j
WHERE e.job_id = j.job_id;
