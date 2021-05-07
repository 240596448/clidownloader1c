```
$ releasecliexplorer --help

Приложение: ReleaseCliExplorer
 Консольный исследователь сайта releases.1c.ru

Строка запуска: ReleaseCliExplorer [ОПЦИИ]  КОМАНДА [аргументы...]

Опции:
  -v, --version         показать версию и выйти
  -u, --user, --login   имя пользователя (env $RCE_LOGIN)
  -p, --password        пароль (env $RCE_PASSWORD)

Доступные команды:
  e, explore            Обзор продуктов и скачивание
  n, news, whatsnew     Что нового (последние обновления, свежие резилы)
  r, report             Сформировать отчет по проектам в формате Markdown
  d, download           Скачать дистрибутив по ссылке
```
---
```
$ releasecliexplorer explore --help

Команда: e, explore
 Обзор продуктов и скачивание

Строка запуска: ReleaseCliExplorer e [ОПЦИИ]

Опции:
  -s, --pagesize        размер страницы (количество строк элементов) (по умолчанию 15)
  -o, --out             каталог сохранения скачиваемых файлов (по умолчанию ./)
```
---
```
$ releasecliexplorer news --help

Команда: n, news, whatsnew
 Что нового (последние обновления, свежие резилы)

Строка запуска: ReleaseCliExplorer n [ОПЦИИ]

Опции:
  -d, --days            показывать свежие релизы за # дней (по умолчанию 2)
  -t, --testing         выводить информацию о тестовых релизах
```
---
```
$ releasecliexplorer report --help

Команда: r, report
 Сформировать отчет по проектам в формате Markdown

Строка запуска: ReleaseCliExplorer r [ОПЦИИ]

Опции:
  -o, --out             каталог сохранения скачиваемых файлов или сформированого отчета (по умолчанию .)
  -t, --testing         выводить информацию о тестовых релизах
```
---
```
$ releasecliexplorer download --help

Команда: d, download
 Скачать дистрибутив по ссылке

Строка запуска: ReleaseCliExplorer d [ОПЦИИ] PATH

Аргументы:
  PATH          путь к дистрибутиву или прямая ссылка на скачивание, где
    * путь к дистрибутиву - ссылка URL типа https://releases.1c.ru/version_file?nick=
    * прямая ссылка - ссылка URL типа https://dl0?.1c.ru/public/file/get/

Опции:
  -o, --out     каталог сохранения скачиваемых файлов или имя файла (для опции force) (по умолчанию ./)
  -f, --force   сохранить принудительно, даже если это не файл
```
