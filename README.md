# nestjs_test
Решение тестового задания<br>
Цель - выполнить RestAPI на Nextjs+Postgresql по постановке.<br>
Решение:<br>
  Запросы только get<br>
  Шаблонизаторов нет<br>
  Ответы - строка 0- неудачно, 1 - удачно.<br>
Установка:<br>
  выполнить init.sql в БД<br>
  настроить подключение к БД в src/db-module.module.ts<br>
  запустить npm run start:dev<br>
Функции(пример):<br>
  /car/isavailable?id=1&from=2022-01-01&to=2022-01-12<br>
  /car/getcost?id=1&from=2022-01-01&to=2022-01-12<br>
  /boo/dobook?id=1&from=2022-07-11&to=2022-07-20<br>
