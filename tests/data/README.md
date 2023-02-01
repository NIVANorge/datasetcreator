# ODM2 test database

A small odm2 test database

```bash
pg_dump -O -h localhost -p 5432 -U postgres -n odm2 -d odm2 > data/odm2.sql
```
