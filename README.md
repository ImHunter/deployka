# Vanessa Deployment Engine

Развертывание конфигураций 1С на целевой базе 1С.

## Возможные команды

* help      - Вывод справки по параметрам
* loadcfg   - Загрузка/обновление конфигурации
* loadrepo  - Обновить из хранилища подключенную базу
* session   - Управление сеансами информационной базы
* dbupdate  - Обновление конфигурации базы данных
* run       - Управление запуском в режиме предприятия

Для подсказки по конкретной команде наберите help <команда>

## session - Управление сеансами информационной базы

### Параметры:
* <Действие> - lock|unlock|kill|closed
Действие kill по умолчанию также устанавливает блокировку начала сеансов пользователей. Для подавления этого эффекта используется ключ -with-nolock.
Действие closed предназначено для проверки отсутствия сеансов. Например, может применяться для проверки того, что после блокировки, все регламенты завершили свою работу.
Если сеансы оказались найдены, то происходит завершение работы скрипта с ошибкой.
* -ras - Сетевой адрес RAS, по умолчанию localhost:1545
* -rac - Команда запуска RAC, по умолчанию находим в каталоге установки 1с
* -db - Имя информационной базы
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -cluster-port - Порт кластера
* -cluster-admin - Администратор кластера
* -cluster-pwd - Пароль администратора кластера
* -v8version - Маска версии платформы 1С
* -lockmessage - Сообщение блокировки
* -lockuccode - Ключ разрешения запуска
* -lockstart - Время старта блокировки пользователей, время указываем как '2040-12-31T23:59:59'
* -lockstartat - Время старта блокировки через n сек
* -with-nolock - Не блокировать сеансы (y/n). Применяется для действия kill -
по умолчанию, при его выполнении автоматически блокируется начало сеансов.
Пример: ... kill -with-nolock y ...
* -filter - Фильтр поиска сеансов. Предполагает возможность указания множественных вариантов фильтрации. Задается в формате '[filter1]|[filter2]|...|[filterN]', где filter - составляющая фильтра.
Составляющая фильтра задается в формате [[appid=приложение1[;приложение2]][[name=username1[;username2]]
Пока предусмотрено только два фильтра - по имени приложения (appid) и по имени пользователя 1С (name).
Для фильтра по приложению доступны следующие имена: 1CV8 1CV8C WebClient Designer COMConnection WSConnection BackgroundJob WebServerExtension.
Использование wildchar/regex пока не предусмотрено. Регистронечувствительно. Параметры должны разделяться через |.
Действует для команд kill и search.
Пример: ... kill -filter appid=Designer|name=регламент;администратор ...

## loadcfg - Загрузка/обновление конфигурации

### Параметры:

* <СтрокаПодключения> - Строка подключения к рабочему контуру
* <ПутьДистрибутива> - Путь к дистрибутиву в виде каталога версии
* /mode - Режим обновления:
 *	-auto - Сначала искать CFU, потом CF
 *	-cf   - Использовать только CF
 *	-cfu  - Использовать только CFU
 *	-load - Полная загрузка конфигурации
 *	-skip - Не выполнять обновление
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -v8version - Маска версии платформы 1С

## loadrepo - Обновить из хранилища подключенную базу

### Параметры:

* <СтрокаПодключения> - Строка подключения к рабочему контуру
* <АдресХранилища> - Путь или сетевой адрес хранилища 1С
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -storage-user - Пользователь хранилища конфигурации
* -storage-pwd - Пароль пользователя хранилища конфигурации
* -storage-ver - Версия (номер) закладки в хранилище - необязательно
* -v8version - Маска версии платформы 1С
* -uccode - Ключ разрешения запуска

## dbupdate - Обновление конфигурации базы данных

### Параметры:

* <СтрокаПодключения> - Строка подключения к рабочему контуру
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -v8version - Маска версии платформы 1С
* -uccode - Ключ разрешения запуска
* -allow-warnings - Разрешить предупреждения. Означает, что НЕ воспринимать предупреждения типа 'Код справочника стал неуникален', как ошибку.
Тогда при таких предупреждениях скрипт отрабатывает с нормальным кодом возврата 0.

## run - Управление запуском в режиме предприятия

### Параметры:
 
* <СтрокаПодключения> - Строка подключения к рабочему контуру
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -v8version - Маска версии платформы 1С
* -uccode - Ключ разрешения запуска
* -command - Строка передаваемя в ПараметрыЗапуска, /C''
* -execute - Путь обработки для запуска
* -log - Полное имя файла для записи лога работы Предприятия, /Out

## disablesupport - Снять базу данных с поддержки

### Параметры:

* <СтрокаПодключения> - Строка подключения к рабочему контуру
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -v8version - Маска версии платформы 1С
* -uccode - Ключ разрешения запуска
* -force - Принудительное выполнение

## unbindrepo - Отключить конфигурацию от хранилища. Приводит в появлению ключа запуска Конфигуратора /ConfigurationRepositoryUnbindCfg -force

### Параметры:

* <СтрокаПодключения> - Строка подключения к рабочему контуру
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -v8version - Маска версии платформы 1С

## info - Получение информации о базе данных (выводится в консоль выполнения скрипта).
Может применяться для проверки работы RAS/RAC.
### Параметры:
* -ras - Сетевой адрес RAS, по умолчанию localhost:1545
* -rac - Команда запуска RAC, по умолчанию находим в каталоге установки 1с
* -db - Имя информационной базы
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -cluster-admin - Администратор кластера
* -cluster-pwd - Пароль администратора кластера
* -v8version - Маска версии платформы 1С

## scheduledjobs - Управление сеансами/регламентами информационной базы
### Параметры:
* <Действие> - lock|unlock
* -ras - Сетевой адрес RAS, по умолчанию localhost:1545
* -rac - Команда запуска RAC, по умолчанию находим в каталоге установки 1с
* -db - Имя информационной базы
* -db-user - Пользователь информационной базы
* -db-pwd - Пароль пользователя информационной базы
* -cluster-admin - Администратор кластера
* -cluster-pwd - Пароль администратора кластера
* -v8version - Маска версии платформы 1С