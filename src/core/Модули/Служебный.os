Перем РежимОтладки;
Перем ПараметрыОтладки;

Процедура СохранитьТекстВФайл(Текст, ИмяФайла) Экспорт
	
	ЗаписьТекста = Новый ЗаписьТекста(ИмяФайла, КодировкаТекста.UTF8);
	ЗаписьТекста.Записать(Текст);
	ЗаписьТекста.Закрыть();

КонецПроцедуры

Функция ВерсияЧислом(Знач Версия, Разделитель = ".") Экспорт
	ЧастиВерсии = СтрРазделить(Версия, Разделитель, Ложь);
	Если ЧастиВерсии.Количество() <= 1 Тогда
		Возврат 0;
	КонецЕсли;

	ВерсияКакЧисло = 0;
	Разрядов = 4;
	Для инд = 1 По Разрядов Цикл
		Если ЧастиВерсии.Количество() >= Инд Тогда
			ВерсияКакЧисло = ВерсияКакЧисло + ЧастиВерсии[инд-1] * Pow(1000, Разрядов-инд);
		КонецЕсли;
	КонецЦикла;
	Возврат ВерсияКакЧисло;
КонецФункции

Функция ФайлВТекст(ИмяФайла) Экспорт
	
	Если ТипЗнч(ИмяФайла) = Тип("Файл") Тогда
		_ИмяФайла = ИмяФайла.ПолноеИмя;
	Иначе
		_ИмяФайла = ИмяФайла;
	КонецЕсли;
	
	ЧтениеТекста = Новый ЧтениеТекста(_ИмяФайла);
	Текст = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	Возврат Текст;
	
КонецФункции

Функция СовпаденияВТексте(Текст, Выражение) Экспорт
	
	РВ = Новый РегулярноеВыражение(Выражение);
	Совпадения = РВ.НайтиСовпадения(Текст);
	
	Возврат Совпадения;

КонецФункции

Функция СовпаденияВФайле(ИмяФайла, Выражение) Экспорт
	
	Текст = ФайлВТекст(ИмяФайла);

	Совпадения = СовпаденияВТексте(Текст, Выражение);
	
	Возврат Совпадения;

КонецФункции

// Дата из строки формата MM.DD.YYYY or MM.DD.YY
Функция ДатаИзСтроки(Знач ДатаСтрокой) Экспорт

	ВремЧастиДаты = СтрРазделить(ДатаСтрокой, ".");

	КоличествоЧастейДаты = 3;

	Если ВремЧастиДаты.Количество() < КоличествоЧастейДаты Тогда
		Возврат Дата(1,1,1);
	КонецЕсли;

	Попытка
		Если СтрДлина(ВремЧастиДаты[2]) = 4 Тогда
			Возврат Дата(СтрШаблон("%1%2%3%4", ВремЧастиДаты[2], ВремЧастиДаты[1], ВремЧастиДаты[0], "000000"));
		ИначеЕсли СтрДлина(ВремЧастиДаты[2]) = 2 Тогда
			Возврат Дата(СтрШаблон("20%1%2%3%4", ВремЧастиДаты[2], ВремЧастиДаты[1], ВремЧастиДаты[0], "000000"));
		Иначе
			Возврат Дата(1,1,1);
		КонецЕсли;
	Исключение
		Возврат Дата(1,1,1);
	КонецПопытки;

КонецФункции

Функция ВМассиве(Знач Значение1, 
	Знач Значение2 = Неопределено, 
	Знач Значение3 = Неопределено,
	Знач Значение4 = Неопределено,
	Знач Значение5 = Неопределено) Экспорт
	
	Массив = Новый Массив;
	Массив.Добавить(Значение1);
	Если ЗначениеЗаполнено(Значение2) Тогда
		Массив.Добавить(Значение2);
	КонецЕсли;
	Если ЗначениеЗаполнено(Значение3) Тогда
		Массив.Добавить(Значение3);
	КонецЕсли;
	Если ЗначениеЗаполнено(Значение4) Тогда
		Массив.Добавить(Значение4);
	КонецЕсли;
	Если ЗначениеЗаполнено(Значение5) Тогда
		Массив.Добавить(Значение5);
	КонецЕсли;

	Возврат Массив;
КонецФункции

Функция РежимОтладки() Экспорт

	Если РежимОтладки = Неопределено Тогда
		ПараметрОтладка = ПолучитьПеременнуюСреды("RCE_DEBUG");
		Попытка
			РежимОтладки = Булево(ПараметрОтладка);
		Исключение
			РежимОтладки = Ложь;
		КонецПопытки;
	КонецЕсли;
	
	Возврат РежимОтладки;
	
КонецФункции

Функция ПараметрыОтладки() Экспорт
	стк = Новый Структура();
	стк.Вставить("РежимОтладки", РежимОтладки());
	стк.Вставить("ИмяОтладочногоФайла", ПолучитьПеременнуюСреды("RCE_DEBUG_HTMLFILE"));
	Возврат стк;
КонецФункции
