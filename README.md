# nestjs_test
Решение тестового задания
Цель - выполнить RestAPI на Nextjs+Postgresql по постановке.
Решение:
  Запросы только get
  Шаблонизаторов нет
  Ответы - строка 0- неудачно, 1 - удачно.
Установка:
  выполнить init.sql в БД
  настроить подключение к БД в src/db-module.module.ts
  запустить npm run start:dev
Функции(пример):
  /car/isavailable?id=1&from=2022-01-01&to=2022-01-12
  /car/getcost?id=1&from=2022-01-01&to=2022-01-12
  /boo/dobook?id=1&from=2022-07-11&to=2022-07-20<br>
  Знаком с Nestjs 3 дня. Очень удобный фреймворк.
