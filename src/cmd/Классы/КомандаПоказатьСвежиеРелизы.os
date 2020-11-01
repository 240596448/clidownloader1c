
///////////////////////////////////////////////////////////////////////////////////////////////////
// Прикладной интерфейс

Процедура ОписаниеКоманды(Команда) Экспорт

    Команда.Опция("d days", 2, "показывать свежие релизы за # дней")
            .ТЧисло();

    Команда.Опция("t testing", Ложь, "выводить информацию о тестовых релизах")
            .ТБулево()
            .ПоУмолчанию(Ложь);

    Команда.Опция("s pagesize", 15, "размер страницы (количество строк элементов)")
            .ТЧисло();

КонецПроцедуры

// Выполняет логику команды
// 
// Параметры:
//   ПараметрыКоманды - Соответствие ключей командной строки и их значений
//
Функция ВыполнитьКоманду(Знач ПараметрыКоманды) Экспорт
    ВызватьИсключение "Не реализовано"
КонецФункции