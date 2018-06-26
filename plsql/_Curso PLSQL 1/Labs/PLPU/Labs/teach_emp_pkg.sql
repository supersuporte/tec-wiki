
  CREATE OR REPLACE PACKAGE "TEACH"."EMP_PKG" IS
  PROCEDURE add_employee(
    first_name employees.first_name%TYPE,
    last_name employees.last_name%TYPE,
    email employees.email%TYPE,
    job employees.job_id%TYPE DEFAULT 'SA_REP',
    mgr employees.manager_id%TYPE DEFAULT 145,
    sal employees.salary%TYPE DEFAULT 1000,
    comm employees.commission_pct%TYPE DEFAULT 0,
    deptid employees.department_id%TYPE DEFAULT 30);
  PROCEDURE add_employee(
    first_name employees.first_name%TYPE,
    last_name employees.last_name%TYPE,
    deptid employees.department_id%TYPE);
  PROCEDURE get_employee(
    empid IN employees.employee_id%TYPE,
    sal OUT employees.salary%TYPE,
    job OUT employees.job_id%TYPE);
  FUNCTION get_employee(emp_id employees.employee_id%type)
    return employees%rowtype;
  FUNCTION get_employee(family_name employees.last_name%type)
    return employees%rowtype;
  PROCEDURE init_departments;
  PROCEDURE print_employee(emprec employees%rowtype);
END emp_pkg;
CREATE OR REPLACE PACKAGE BODY "TEACH"."EMP_PKG" wrapped
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
3
b
9200000
1
4
0
44
2 :e:
1PACKAGE:
1BODY:
1EMP_PKG:
1TYPE:
1BOOLEAN_TABTYPE:
1BOOLEAN:
1BINARY_INTEGER:
1VALID_DEPARTMENTS:
1FUNCTION:
1VALID_DEPTID:
1DEPTID:
1DEPARTMENTS:
1DEPARTMENT_ID:
1RETURN:
1ADD_EMPLOYEE:
1FIRST_NAME:
1EMPLOYEES:
1LAST_NAME:
1EMAIL:
1JOB:
1JOB_ID:
1SA_REP:
1MGR:
1MANAGER_ID:
1145:
1SAL:
1SALARY:
11000:
1COMM:
1COMMISSION_PCT:
10:
130:
1EMPLOYEE_ID:
1HIRE_DATE:
1EMPLOYEES_SEQ:
1NEXTVAL:
1TRUNC:
1SYSDATE:
1RAISE_APPLICATION_ERROR:
1-:
120204:
1Invalid department ID. Try again.:
1UPPER:
1SUBSTR:
11:
1||:
17:
1GET_EMPLOYEE:
1EMPID:
1OUT:
1=:
1EMP_ID:
1ROWTYPE:
1EMPREC:
1FAMILY_NAME:
1INIT_DEPARTMENTS:
1REC:
1LOOP:
1TRUE:
1PRINT_EMPLOYEE:
1DBMS_OUTPUT:
1PUT_LINE:
1 :
1DUMMY:
1PLS_INTEGER:
1EXISTS:
1NO_DATA_FOUND:
1FALSE:
0

0
0
237
2
0 :2 a0 97 a0 9d a0 1c a0
1c 40 a8 c 77 a3 a0 1c
81 b0 a0 8d 8f :2 a0 6b :2 a0
f b0 3d b4 :2 a0 2c 6a 9a
8f :2 a0 6b :2 a0 f b0 3d 8f
:2 a0 6b :2 a0 f b0 3d 8f :2 a0
6b :2 a0 f b0 3d 8f :2 a0 6b
:2 a0 f 6e b0 3d 8f :2 a0 6b
:2 a0 f 51 b0 3d 8f :2 a0 6b
:2 a0 f 51 b0 3d 8f :2 a0 6b
:2 a0 f 51 b0 3d 8f :2 a0 6b
:2 a0 f 51 b0 3d b4 55 6a
:2 a0 a5 b :d a0 6b :7 a0 a5 b
:3 a0 5 d7 b2 5 e9 b7 a0
7e 51 b4 2e 6e a5 57 b7
:2 19 3c b7 a4 a0 b1 11 68
4f 9a 8f :2 a0 6b :2 a0 f b0
3d 8f :2 a0 6b :2 a0 f b0 3d
8f :2 a0 6b :2 a0 f b0 3d b4
55 6a a3 :2 a0 6b :2 a0 f 1c
81 b0 :4 a0 :2 51 a5 b 7e :2 a0
:2 51 a5 b b4 2e a5 b d
:6 a0 e a5 57 b7 a4 b1 11
68 4f 9a 8f :2 a0 6b :2 a0 f
b0 3d 96 :3 a0 6b :2 a0 f b0
54 96 :3 a0 6b :2 a0 f b0 54
b4 55 6a :2 a0 ac :3 a0 b2 ee
:2 a0 7e b4 2e ac e5 d0 b2
e9 b7 a4 a0 b1 11 68 4f
a0 8d 8f :2 a0 6b :2 a0 f b0
3d b4 :3 a0 f 2c 6a a3 :2 a0
f 1c 81 b0 ac :2 a0 b2 ee
:2 a0 7e b4 2e ac e5 d0 b2
e9 :2 a0 65 b7 a4 b1 11 68
4f a0 8d 8f :2 a0 6b :2 a0 f
b0 3d b4 :3 a0 f 2c 6a a3
:2 a0 f 1c 81 b0 ac :2 a0 b2
ee :2 a0 7e b4 2e ac e5 d0
b2 e9 :2 a0 65 b7 a4 b1 11
68 4f 9a b4 55 6a 91 a0
ac a0 b2 ee ac d0 e5 e9
37 :4 a0 6b a5 b a0 d b7
a0 47 b7 a4 b1 11 68 4f
9a 8f :2 a0 f b0 3d b4 55
6a :2 a0 6b :2 a0 6b 7e 6e b4
2e 7e :2 a0 6b b4 2e 7e 6e
b4 2e 7e :2 a0 6b b4 2e 7e
6e b4 2e 7e :2 a0 6b b4 2e
7e 6e b4 2e 7e :2 a0 6b b4
2e 7e 6e b4 2e 7e :2 a0 6b
b4 2e a5 57 b7 a4 b1 11
68 4f a0 8d 8f :2 a0 6b :2 a0
f b0 3d b4 :2 a0 2c 6a a3
a0 1c 81 b0 :3 a0 6b a0 a5
b 65 b7 :3 a0 65 b7 a6 9
a4 a0 b1 11 68 4f a0 57
b3 b7 a4 b1 11 a0 b1 56
4f 1d 17 b5
237
2
0 3 7 b 15 3c 1d 21
29 2d 35 36 37 19 58 47
4b 53 46 5f 63 90 7b 7f
43 83 87 8b 7a 98 77 9d
a1 a5 a9 ad dd c5 c9 cd
d0 d4 d8 c4 e5 103 ee f2
c1 f6 fa fe ed 10b 129 114
118 ea 11c 120 124 113 131 154
13a 13e 110 142 146 14a 14f 139
15c 17d 165 169 136 16d 171 175
17a 164 185 1a6 18e 192 161 196
19a 19e 1a3 18d 1ae 1cf 1b7 1bb
18a 1bf 1c3 1c7 1cc 1b6 1d7 1f8
1e0 1e4 1b3 1e8 1ec 1f0 1f5 1df
200 1dc 205 209 20d 211 215 216
218 21c 220 224 228 22c 230 234
238 23c 240 244 248 24c 24f 253
257 25b 25f 263 267 26b 26c 26e
272 276 27a 27e 286 287 28b 290
292 296 299 29c 29d 2a2 2a7 2a8
2ad 2af 2b3 2b7 2ba 2bc 2c0 2c4
2c6 2d2 2d6 2d8 308 2f0 2f4 2f8
2fb 2ff 303 2ef 310 32e 319 31d
2ec 321 325 329 318 336 354 33f
343 315 347 34b 34f 33e 35c 33b
361 365 392 36d 371 375 378 37c
380 385 38d 36c 399 39d 3a1 3a5
369 3a9 3ac 3ad 3af 3b2 3b6 3ba
3bd 3c0 3c1 3c3 3c4 3c9 3ca 3cc
3d0 3d4 3d8 3dc 3e0 3e4 3e8 3ea
3eb 3f0 3f2 3f6 3f8 404 408 40a
43a 422 426 42a 42d 431 435 421
442 464 44b 44f 453 41e 457 45b
45f 44a 46b 48d 474 478 47c 447
480 484 488 473 494 470 499 49d
4a1 4a5 4a9 4aa 4ae 4b2 4b6 4b7
4be 4c2 4c6 4c9 4ca 4cf 4d0 4d6
4da 4db 4e0 4e2 4e6 4ea 4ec 4f8
4fc 4fe 502 532 51a 51e 522 525
529 52d 519 53a 516 53f 543 547
54b 550 554 576 55c 560 564 569
571 55b 558 57d 581 585 586 58d
591 595 598 599 59e 59f 5a5 5a9
5aa 5af 5b3 5b7 5bb 5bd 5c1 5c3
5cf 5d3 5d5 5d9 609 5f1 5f5 5f9
5fc 600 604 5f0 611 5ed 616 61a
61e 622 627 62b 64d 633 637 63b
640 648 632 62f 654 658 65c 65d
664 668 66c 66f 670 675 676 67c
680 681 686 68a 68e 692 694 698
69a 6a6 6aa 6ac 6c0 6c1 6c5 6c9
6cd 6d1 6d2 6d6 6d7 6de 6df 6e3
6e9 6ee 6f0 6f4 6f8 6fc 700 703
704 706 70a 70e 710 714 71b 71d
721 723 72f 733 735 75a 74d 751
755 74c 762 749 767 76b 76f 773
777 77a 77e 782 785 788 78d 78e
793 796 79a 79e 7a1 7a2 7a7 7aa
7af 7b0 7b5 7b8 7bc 7c0 7c3 7c4
7c9 7cc 7d1 7d2 7d7 7da 7de 7e2
7e5 7e6 7eb 7ee 7f3 7f4 7f9 7fc
800 804 807 808 80d 810 815 816
81b 81e 822 826 829 82a 82f 830
835 837 83b 83d 849 84d 84f 853
883 86b 86f 873 876 87a 87e 86a
88b 867 890 894 898 89c 8b5 8a4
8a8 8b0 8a3 8bc 8c0 8c4 8a0 8c8
8cc 8cd 8cf 8d3 8d5 8d9 8dd 8e1
8e5 8e7 8e8 8ed 8f1 8f5 8f7 903
907 909 90d 912 913 915 919 91b
927 92b 92d 930 932 933 93c
237
2
0 1 9 e 3 8 :2 24 :2 e
:3 1b :2 3 :3 15 :2 3 c 19 23 2f
23 :2 3d 23 :2 19 18 4 b :2 3
d 5 10 1a 10 :2 25 10 :3 5
f 19 f :2 23 f :3 5 b 15
b :2 1b b :3 5 9 13 9 :2 1a
9 27 :3 5 9 13 9 :2 1e 9
2b :3 5 9 13 9 :2 1a 9 27
:3 5 a 14 a :2 23 a 30 :3 5
c 16 c :2 24 c 31 :2 5 19
:2 3 8 15 :2 8 13 1d 2a 36
41 9 11 1d 28 30 40 f
:2 1d 26 32 3d 9 e 13 19
:2 13 23 28 2e e :4 7 1d 7
20 21 :2 20 28 :2 7 :4 5 :2 3 7
:4 3 d 5 10 1a 10 :2 25 10
:3 5 f 19 f :2 23 f :3 5 c
16 c :2 24 c :2 5 19 :2 3 5
b 15 b :2 1b :3 b :2 5 e 14
1b 27 2a :2 14 2c 2e 35 40
43 :2 2e :2 14 :2 e :2 5 12 1e 29
30 3a 30 :2 5 :6 3 d 5 e
18 e :2 24 e :3 5 9 d 17
d :2 1e d :3 5 9 d 17 d
:2 1e d :2 5 19 :2 3 c 14 c
a f a 5 a b 19 :3 17
:5 5 :2 3 7 :5 3 c 19 20 2a
20 :2 36 20 :2 19 18 5 c 16
c :2 3 5 c 16 :3 c 5 c
13 a 5 a b 19 :3 17 :6 5
c 5 :7 3 c 19 25 2f 25
:2 39 25 :2 19 18 5 c 16 c
:2 3 5 c 16 :3 c 5 c 13
a 5 a b 17 :3 15 :6 5 c
5 :6 3 d 0 :2 3 9 :2 18 2b
26 2b 26 :3 11 :2 5 7 19 :2 1d
:2 7 2f 7 5 9 5 :6 3 d
1c 23 2d 23 :2 1c 1b :2 3 5
:2 11 1a :2 21 2f 31 :2 1a 34 1a
:2 21 :2 1a 2c 2e :2 1a 31 1a :2 21
:2 1a 2b 2d :2 1a 30 1a :2 21 :2 1a
2a 2c :2 1a 2f 1a :2 21 :2 1a 27
29 :2 1a 2c 1a :2 21 :2 1a :2 5 :7 3
c 19 23 2f 23 :2 3d 23 :2 19
18 4 b :2 3 5 :3 b :2 5 c
:2 1e 25 :2 c 5 3 a 5 c
5 18 :2 5 3 7 :7 3 :4 1 5
:6 1
237
4
0 :3 1 :4 2 :2 3
:4 2 :5 4 :c 6 :2 7
:2 6 9 :9 a :9 b
:9 c :a d :a e :a f
:a 10 :a 11 :3 9 :4 13
:5 14 :6 15 :6 16 :9 17
16 :4 14 13 :8 19
18 :3 13 :2 12 1b
:4 9 1d :9 1e :9 1f
:9 20 :3 1d :a 21 :14 23
:9 24 :2 22 :4 1d 27
:9 28 :a 29 :a 2a :3 27
:3 2c :2 2d :3 2e :5 2f
2e :4 2c :2 2b 30
:4 27 :c 32 :4 33 :2 32
:7 34 :2 36 :3 37 :5 38
37 :4 36 :3 39 :2 35
:4 32 :c 3c :4 3d :2 3c
:7 3e :2 40 :3 41 :5 42
41 :4 40 :3 43 :2 3f
:4 3c 46 0 :2 46
:b 48 49 :8 4a 49
4b 48 :2 47 :4 46
:a 4e :b 50 :3 51 :2 50
:2 51 :2 50 51 :3 52
:2 50 :2 52 :2 50 52
:3 53 :2 50 :2 53 :2 50
53 :3 54 :2 50 :2 54
:2 50 54 :3 55 :4 50
:2 4f :4 4e :c 58 :2 59
:2 58 :5 5a :8 5c 5b
5e :3 5f :3 5e 5d
60 :4 58 :3 63 :4 62
64 :6 1
93e
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 4 :3 0 5
0 c 231 6
:3 0 6 :7 0 7
:3 0 8 :7 0 9
3 b 7 :3 0
5 c 5 :4 0
16 17 0 :2 5
:3 0 f :7 0 12
10 0 231 0
8 :6 0 9 :3 0
a :a 0 22 2
:7 0 9 :2 0 7
c :3 0 d :2 0
:2 4 :3 0 4 :2 0
1 18 1a :3 0
b :7 0 1c 1b
:3 0 e :3 0 6
:3 0 1e 20 0
22 14 21 0
231 f :a 0 a9
3 :7 0 2e 2f
0 b 11 :3 0
10 :2 0 4 25
26 0 4 :3 0
4 :2 0 1 27
29 :3 0 10 :7 0
2b 2a :3 0 37
38 0 d 11
:3 0 12 :2 0 :2 4
:3 0 4 :2 0 1
30 32 :3 0 12
:7 0 34 33 :3 0
40 41 0 f
11 :3 0 13 :2 0
:2 4 :3 0 4 :2 0
1 39 3b :3 0
13 :7 0 3d 3c
:3 0 4a 4b 0
:2 11 :3 0 15 :2 0
:2 4 :3 0 4 :2 0
1 42 44 :3 0
16 :4 0 14 :7 0
47 45 46 :2 0
54 55 0 13
11 :3 0 18 :2 0
:2 4 :3 0 4 :2 0
1 4c 4e :3 0
19 :2 0 17 :7 0
51 4f 50 :2 0
5e 5f 0 15
11 :3 0 1b :2 0
:2 4 :3 0 4 :2 0
1 56 58 :3 0
1c :2 0 1a :7 0
5b 59 5a :2 0
68 69 0 17
11 :3 0 1e :2 0
:2 4 :3 0 4 :2 0
1 60 62 :3 0
1f :2 0 1d :7 0
65 63 64 :2 0
1b :2 0 19 11
:3 0 d :2 0 :2 4
:3 0 4 :2 0 1
6a 6c :3 0 20
:2 0 b :7 0 6f
6d 6e :2 0 71
:2 0 a9 23 72
:2 0 a :3 0 b
:3 0 24 74 76
11 :3 0 21 :3 0
10 :3 0 12 :3 0
13 :3 0 15 :3 0
18 :3 0 22 :3 0
1b :3 0 1e :3 0
d :3 0 23 :3 0
24 :3 0 83 84
0 10 :3 0 12
:3 0 13 :3 0 14
:3 0 17 :3 0 25
:3 0 26 :3 0 26
8b 8d 1a :3 0
1d :3 0 b :3 0
28 :3 0 78 94
95 96 :4 0 33
3e :4 0 93 :2 0
97 40 a1 27
:3 0 28 :2 0 29
:2 0 42 99 9b
:3 0 2a :4 0 44
98 9e :2 0 a0
47 a2 77 97
0 a3 0 a0
0 a3 49 0
a4 4c a8 :3 0
a8 f :4 0 a8
a7 a4 a5 :6 0
a9 1 0 23
72 a8 231 :2 0
f :a 0 f5 4
:7 0 b6 b7 0
4e 11 :3 0 10
:2 0 4 ad ae
0 4 :3 0 4
:2 0 1 af b1
:3 0 10 :7 0 b3
b2 :3 0 bf c0
0 50 11 :3 0
12 :2 0 :2 4 :3 0
4 :2 0 1 b8
ba :3 0 12 :7 0
bc bb :3 0 54
:2 0 52 11 :3 0
d :2 0 :2 4 :3 0
4 :2 0 1 c1
c3 :3 0 b :7 0
c5 c4 :3 0 c7
:2 0 f5 ab c8
:2 0 2d :2 0 58
11 :3 0 13 :2 0
4 cb cc 0
4 :3 0 4 :2 0
1 cd cf :3 0
d0 :7 0 d3 d1
0 f3 0 13
:6 0 13 :3 0 2b
:3 0 2c :3 0 10
:3 0 2d :2 0 5a
d6 da 2e :2 0
2c :3 0 12 :3 0
2d :2 0 2f :2 0
5e dd e1 62
dc e3 :3 0 65
d5 e5 d4 e6
0 f1 f :3 0
10 :3 0 12 :3 0
13 :3 0 b :3 0
b :3 0 ec ed
67 e8 ef :2 0
f1 6c f4 :3 0
f4 6f f4 f3
f1 f2 :6 0 f5
1 0 ab c8
f4 231 :2 0 30
:a 0 12f 5 :7 0
103 104 0 71
11 :3 0 21 :2 0
4 f9 fa 0
4 :3 0 4 :2 0
1 fb fd :3 0
31 :7 0 ff fe
:3 0 10d 10e 0
73 32 :3 0 11
:3 0 1b :2 0 :2 4
:3 0 4 :2 0 1
105 107 :3 0 1a
:6 0 109 108 :3 0
77 :2 0 75 32
:3 0 11 :3 0 15
:2 0 :2 4 :3 0 4
:2 0 1 10f 111
:3 0 14 :6 0 113
112 :3 0 115 :2 0
12f f7 116 :2 0
1b :3 0 15 :3 0
7b 1a :3 0 14
:3 0 11 :3 0 7e
11e 124 0 125
:3 0 21 :3 0 31
:3 0 33 :2 0 82
122 123 :4 0 127
128 :5 0 11a 11f
0 85 0 126
:2 0 12a 88 12e
:3 0 12e 30 :4 0
12e 12d 12a 12b
:6 0 12f 1 0
f7 116 12e 231
:2 0 9 :3 0 30
:a 0 160 6 :7 0
8c :2 0 8a 11
:3 0 21 :2 0 4
134 135 0 4
:3 0 4 :2 0 1
136 138 :3 0 34
:7 0 13a 139 :3 0
e :3 0 11 :3 0
35 :3 0 13e 13f
:3 0 13c 140 0
160 132 141 :5 0
8e 11 :3 0 35
:3 0 144 145 :3 0
146 :7 0 149 147
0 15e 0 36
:6 0 36 :3 0 11
:3 0 90 14d 153
0 154 :3 0 21
:3 0 34 :3 0 33
:2 0 94 151 152
:4 0 156 157 :5 0
14a 14e 0 97
0 155 :2 0 15c
e :3 0 36 :3 0
15a :2 0 15c 99
15f :3 0 15f 9c
15f 15e 15c 15d
:6 0 160 1 0
132 141 15f 231
:2 0 9 :3 0 30
:a 0 191 7 :7 0
a0 :2 0 9e 11
:3 0 12 :2 0 4
165 166 0 4
:3 0 4 :2 0 1
167 169 :3 0 37
:7 0 16b 16a :3 0
e :3 0 11 :3 0
35 :3 0 16f 170
:3 0 16d 171 0
191 163 172 :5 0
a2 11 :3 0 35
:3 0 175 176 :3 0
177 :7 0 17a 178
0 18f 0 36
:6 0 36 :3 0 11
:3 0 a4 17e 184
0 185 :3 0 12
:3 0 37 :3 0 33
:2 0 a8 182 183
:4 0 187 188 :5 0
17b 17f 0 ab
0 186 :2 0 18d
e :3 0 36 :3 0
18b :2 0 18d ad
190 :3 0 190 b0
190 18f 18d 18e
:6 0 191 1 0
163 172 190 231
:2 0 38 :a 0 1b2
8 :8 0 194 :2 0
1b2 193 195 :2 0
39 :3 0 d :3 0
b2 c :3 0 b4
19b :2 0 19d :5 0
199 19c 0 19e
:6 0 19f :2 0 1a1
197 1a0 3a :3 0
8 :3 0 39 :3 0
d :3 0 1a4 1a5
0 b6 1a3 1a7
3b :3 0 1a8 1a9
0 1ab b8 1ad
3a :3 0 1a1 1ab
:4 0 1ae ba 1b1
:3 0 1b1 0 1b1
1b0 1ae 1af :6 0
1b2 1 0 193
195 1b1 231 :2 0
3c :a 0 1fc a
:7 0 be :2 0 bc
11 :3 0 35 :3 0
1b6 1b7 :3 0 36
:7 0 1b9 1b8 :3 0
1bb :2 0 1fc 1b4
1bc :2 0 3d :3 0
3e :3 0 1be 1bf
0 36 :3 0 d
:3 0 1c1 1c2 0
2e :2 0 3f :4 0
c0 1c4 1c6 :3 0
2e :2 0 36 :3 0
21 :3 0 1c9 1ca
0 c3 1c8 1cc
:3 0 2e :2 0 3f
:4 0 c6 1ce 1d0
:3 0 2e :2 0 36
:3 0 10 :3 0 1d3
1d4 0 c9 1d2
1d6 :3 0 2e :2 0
3f :4 0 cc 1d8
1da :3 0 2e :2 0
36 :3 0 12 :3 0
1dd 1de 0 cf
1dc 1e0 :3 0 2e
:2 0 3f :4 0 d2
1e2 1e4 :3 0 2e
:2 0 36 :3 0 15
:3 0 1e7 1e8 0
d5 1e6 1ea :3 0
2e :2 0 3f :4 0
d8 1ec 1ee :3 0
2e :2 0 36 :3 0
1b :3 0 1f1 1f2
0 db 1f0 1f4
:3 0 de 1c0 1f6
:2 0 1f8 e0 1fb
:3 0 1fb 0 1fb
1fa 1f8 1f9 :6 0
1fc 1 0 1b4
1bc 1fb 231 :2 0
9 :3 0 a :a 0
227 b :7 0 e4
:2 0 e2 c :3 0
d :2 0 4 201
202 0 4 :3 0
4 :2 0 1 203
205 :3 0 b :7 0
207 206 :3 0 e
:3 0 6 :3 0 209
20b 0 227 1ff
20c :2 0 214 215
0 e6 41 :3 0
20f :7 0 212 210
0 225 0 40
:6 0 e :3 0 8
:3 0 42 :3 0 b
:3 0 e8 216 218
219 :2 0 21b ea
226 43 :3 0 e
:3 0 44 :3 0 21e
:2 0 220 ec 222
ee 221 220 :2 0
223 f0 :2 0 226
a :3 0 f2 226
225 21b 223 :6 0
227 1 0 1ff
20c 226 231 :2 0
38 :3 0 229 22b
:2 0 22c 0 f4
22f :3 0 22f 0
22f 231 22c 22d
:6 0 232 :2 0 3
:3 0 f6 0 3
22f 235 :3 0 234
232 236 :8 0
102
4
:3 0 1 a 1
e 1 15 1
1d 1 24 1
2d 1 36 1
3f 1 49 1
53 1 5d 1
67 8 2c 35
3e 48 52 5c
66 70 1 75
1 8c a 85
86 87 88 89
8a 8e 8f 90
91 a 79 7a
7b 7c 7d 7e
7f 80 81 82
1 92 1 96
1 9a 2 9c
9d 1 9f 2
a1 a2 1 a3
1 ac 1 b5
1 be 3 b4
bd c6 1 ca
3 d7 d8 d9
3 de df e0
2 db e2 1
e4 4 e9 ea
eb ee 2 e7
f0 1 d2 1
f8 1 101 1
10b 3 100 10a
114 2 118 119
1 11d 1 121
2 120 121 2
11b 11c 1 129
1 133 1 13b
1 143 1 14c
1 150 2 14f
150 1 14b 2
158 15b 1 148
1 164 1 16c
1 174 1 17d
1 181 2 180
181 1 17c 2
189 18c 1 179
1 198 1 19a
1 1a6 1 1aa
1 1ad 1 1b5
1 1ba 2 1c3
1c5 2 1c7 1cb
2 1cd 1cf 2
1d1 1d5 2 1d7
1d9 2 1db 1df
2 1e1 1e3 2
1e5 1e9 2 1eb
1ed 2 1ef 1f3
1 1f5 1 1f7
1 200 1 208
1 20e 1 217
1 21a 1 21f
1 21c 1 222
1 211 1 22a
b d 11 22
a9 f5 12f 160
191 1b2 1fc 227

1
4
0
235
0
1
14
b
24
0 1 1 1 1 1 1 1
8 1 1 0 0 0 0 0
0 0 0 0
ca 4 0
36 3 0
b5 4 0
2d 3 0
1b5 a 0
174 7 0
143 6 0
20e b 0
ab 1 4
23 1 3
10b 5 0
3f 3 0
163 1 7
132 1 6
f7 1 5
49 3 0
197 9 0
101 5 0
53 3 0
1ff 1 b
14 1 2
e 1 0
ac 4 0
24 3 0
f8 5 0
164 7 0
3 0 1
1b4 1 a
200 b 0
be 4 0
67 3 0
15 2 0
133 6 0
5 1 0
5d 3 0
193 1 8
0

 
