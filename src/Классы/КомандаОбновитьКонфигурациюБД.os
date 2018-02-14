
///////////////////////////////////////////////////////////////////////////////////////////////////
// Прикладной интерфейс

Перем Лог;

Процедура ЗарегистрироватьКоманду(Знач ИмяКоманды, Знач Парсер) Экспорт
	
    ОписаниеКоманды = Парсер.ОписаниеКоманды(ИмяКоманды, "Обновление конфигурации базы данных");
    
    Парсер.ДобавитьПозиционныйПараметрКоманды(ОписаниеКоманды, "СтрокаПодключения", "Строка подключения к рабочему контуру");
    Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, 
    	"-db-user",
    	"Пользователь информационной базы");

    Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, 
    	"-db-pwd",
    	"Пароль пользователя информационной базы");

    Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, 
    	"-v8version",
    	"Маска версии платформы 1С");
	
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, 
    	"-uccode",
    	"Ключ разрешения запуска");

	Парсер.ДобавитьПараметрФлагКоманды(ОписаниеКоманды, 
    	"-allow-warnings",
		"Разрешить предупреждения. Означает, что НЕ воспринимать предупреждения типа 'Код справочника стал неуникален', как ошибку.
		|Тогда при таких предупреждениях скрипт отрабатывает с нормальным кодом возврата 0.
		|Любое введенное значение этого параметра воспринимается, как ИСТИНА.
		|Если необходимо воспринимать предупреждения, как ошибки, то ключ -allow-warnings указывать не нужно.");

	Парсер.ДобавитьКоманду(ОписаниеКоманды);

КонецПроцедуры

Функция ВыполнитьКоманду(Знач ПараметрыКоманды) Экспорт
    
	ВозможныйРезультат = МенеджерКомандПриложения.РезультатыКоманд();
	
    СтрокаПодключения = ПараметрыКоманды["СтрокаПодключения"];
	Пользователь      = ПараметрыКоманды["-db-user"];
	Пароль            = ПараметрыКоманды["-db-pwd"];
	ПредупрежденияВозможны = ПараметрыКоманды["-allow-warnings"];
	ИспользуемаяВерсияПлатформы = ПараметрыКоманды["-v8version"];
	КлючРазрешенияЗапуска = ПараметрыКоманды["-uccode"];
	
	Если ПустаяСтрока(СтрокаПодключения) Тогда
		Лог.Ошибка("Не задана строка подключения");
		Возврат ВозможныйРезультат.НеверныеПараметры;
	КонецЕсли;
	
	Конфигуратор = ЗапускПриложений.НастроитьКонфигуратор(
		СтрокаПодключения,
		Пользователь,
		Пароль,
		ИспользуемаяВерсияПлатформы);
	
	Если Не ПустаяСтрока(КлючРазрешенияЗапуска) Тогда
		Конфигуратор.УстановитьКлючРазрешенияЗапуска(КлючРазрешенияЗапуска);
	КонецЕсли;
	
	Лог.Информация("Запускаю обновление конфигурации БД");
	Попытка
		Конфигуратор.ОбновитьКонфигурациюБазыДанных(Не ПредупрежденияВозможны);
		Текст = Конфигуратор.ВыводКоманды();
		Если Не ПустаяСтрока(Текст) Тогда
			Лог.Информация(Текст);
		КонецЕсли;
	Исключение
		Лог.Ошибка(Конфигуратор.ВыводКоманды());
		Возврат ВозможныйРезультат.ОшибкаВремениВыполнения;
	КонецПопытки;
	
	Возврат ВозможныйРезультат.Успех;
    
КонецФункции

Лог = Логирование.ПолучитьЛог("vanessa.app.deployka");