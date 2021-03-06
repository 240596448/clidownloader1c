#Использовать 1connector
#Использовать asserts
#Использовать fs

Перем Логин;
Перем Пароль;
Перем Домен;
Перем Сессия;
Перем ПутьСохранения;

Процедура ПриСозданииОбъекта(парамАдрес, парамЛогин, парамПароль)
	
	Домен = парамАдрес;
	Логин = парамЛогин;
	Пароль = парамПароль;

	УстановитьПараметрыАвторизации();

	ИнициализироватьСессию();

КонецПроцедуры

Функция ПолучитьСодержимое(Адрес) Экспорт

	Префикс = ?(Лев(Адрес, 4) = "http", "", Домен);
	Ответ = Сессия.ВызватьМетод("GET", Префикс + Адрес);
	
	Результат = Новый Структура;
	Результат.Вставить("ЭтоФайл", Лев(Ответ.URL, 10) = "https://dl");
	Если НЕ Результат.ЭтоФайл Тогда
		Результат.Вставить("ТекстСтраницы", Ответ.Текст());

		Отладка = Служебный.ПараметрыОтладки();
		Если Отладка.РежимОтладки Тогда
			Служебный.СохранитьТекстВФайл(Результат.ТекстСтраницы, Отладка.ИмяОтладочногоФайла);
		КонецЕсли;
		
	Иначе
		ИмяФайла = ОпределитьИмяФайла(Ответ.Заголовки);
		Если ПустаяСтрока(ИмяФайла) Тогда
			Части = СтрРазделить(Ответ.URL, "/");
			ИмяФайла = Части[Части.ВГраница()];
		КонецЕсли;
		
		Если ПустаяСтрока(ИмяФайла) Тогда
			ИмяФайла = ПолучитьИмяВременногоФайла("exe1с");
		КонецЕсли;
		
		ФС.ОбеспечитьКаталог(ПутьСохранения);
		ПолныйПуть = ОбъединитьПути(ПутьСохранения, ИмяФайла);	
		
		ДД = Ответ.ДвоичныеДанные();
		ДД.Записать(ПолныйПуть);
		Файл = Новый Файл(ПолныйПуть);
		Результат.Вставить("ИмяФайла", Файл.ПолноеИмя);

		ВремяВыполнения = Ответ.ВремяВыполнения / 1000;
		ДлинаФайла = ЗначениеЗаголовка(Ответ.Заголовки, "Content-Length", 0);
		РазмерФайла = Окр(ДлинаФайла / 1024, 1);
		Сообщить(СтрШаблон("Скачан файл %1: %2 секунд, %3 kb " + Символы.ПС, Файл.ПолноеИмя, ВремяВыполнения, РазмерФайла));

	КонецЕсли;

	Возврат Результат;
	
КонецФункции

Функция ЗначениеЗаголовка(Заголовки, Имя, ЗначениеПоУмолчанию="")
	Для каждого КЗ Из Заголовки Цикл
		Если НРег(КЗ.Ключ) = НРег(Имя) Тогда
			Возврат КЗ.Значение;
		КонецЕсли;
	КонецЦикла;
	Возврат ЗначениеПоУмолчанию;
КонецФункции

Функция ОпределитьИмяФайла(Заголовки)
	Значение = ЗначениеЗаголовка(Заголовки, "content-disposition");
	Если ПустаяСтрока(Значение) Тогда
		Возврат "";
	КонецЕсли;
	Части = СтрРазделить(Значение, ";=");
	ИмяФайла = СтрЗаменить(Части[2], """", "");
	Возврат ИмяФайла;
КонецФункции

Функция ПолучитьСессию() Экспорт
	Возврат Сессия;
КонецФункции

Процедура УстановитьПараметрыАвторизации() Экспорт
	
	Консоль = Новый Консоль();
	Попытка
		ПредыдущийЦветТекстаКонсоли = Консоль.ЦветТекста;
	Исключение
		ПредыдущийЦветТекстаКонсоли = ЦветКонсоли.Белый;
	КонецПопытки;
	
	Если НЕ ЗначениеЗаполнено(Логин) Тогда
		
		Консоль.ЦветТекста = ЦветКонсоли.Белый;	
		Консоль.Вывести("Введите login: ");

		Консоль.ЦветТекста = ЦветКонсоли.Желтый;	
		Пока НЕ ЗначениеЗаполнено(Логин) Цикл
			Логин = Консоль.ПрочитатьСтроку();
		КонецЦикла;
		
		Консоль.ЦветТекста = ПредыдущийЦветТекстаКонсоли;
		
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Пароль) Тогда

		Консоль.ЦветТекста = ЦветКонсоли.Белый;	
		Консоль.Вывести("Введите pass: ");

		Консоль.ЦветТекста = ЦветКонсоли.Черный;
		Пока НЕ ЗначениеЗаполнено(Пароль) Цикл
			Пароль = Консоль.ПрочитатьСтроку();
		КонецЦикла;
		
		Консоль.ЦветТекста = ПредыдущийЦветТекстаКонсоли;

		Консоль.Очистить(); //скрыть пароль с экрана
		
	КонецЕсли;

КонецПроцедуры

Функция ИзвлечьExecution(HTML)
	
	Начало = СтрНайти(HTML, "name=""execution""");
	Конец = СтрНайти(HTML, ">", НаправлениеПоиска.СНачала, Начало);
	КороткаяСтрока = Сред(HTML, Начало, Конец - Начало);
	
	Начало = СтрНайти(КороткаяСтрока, "value=""") + СтрДлина("value=""");
	Конец = СтрНайти(КороткаяСтрока, """", НаправлениеПоиска.СНачала, Начало); 
	
	Возврат Сред(КороткаяСтрока, Начало, Конец - Начало);
	
КонецФункции

Процедура ИнициализироватьСессию()

	Сессия = Новый Сессия();
	Сессия.Заголовки["User-Agent"] = "Oscript";
	Ответ = Сессия.ВызватьМетод("GET", Домен + "/total");

	Данные = Новый Структура;
	Данные.Вставить("execution", ИзвлечьExecution(Ответ.Текст()));
	Данные.Вставить("username", Логин); 	
	Данные.Вставить("password", Пароль);
	Данные.Вставить("_eventId", "submit");
	Данные.Вставить("geolocation", "");
	Данные.Вставить("submit", "Войти");
	Данные.Вставить("rememberMe", "on");
	Ответ = Сессия.ВызватьМетод("POST", Ответ.URL, Новый Структура("Данные", Данные));

	Ожидаем.Что(Ответ.URL).Равно(Домен + "/total");
	
КонецПроцедуры

Процедура УстановитьПутьСохранения(Знач парамПутьСохранения) Экспорт
	ПутьСохранения = парамПутьСохранения;
КонецПроцедуры