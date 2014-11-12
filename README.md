#Schedule Query Langauge
![alt text](https://raw.githubusercontent.com/practo/sheql/master/public/images/scheql.png)


SHEQL is a schema less solution to the problem of storing repeated events in a calendar. It is inspired by CSS selectors.

#Features

1. A Far More powerful and customizable logic for repetition can be written.
2. A Schemaless Architecture.
3. A single change is required to update repeated events.
4. Platform independent.

[Learn more about the syntax](https://github.com/tusharmath/sheql/wiki/Rules).


##How to use from cli

1. run `npm install sheql -g`.
2. Example - __get all the tuesdays of the year, except if they fall on the last day of the month__
    ```
    sheql 'm.sep d:l[x+2].tue'
    ```
2. To use it as a package dependency, install it locally and use `require 'sheql'`.


##Using as a dependency

```js
var sheql = require('sheql');
var startDate = new Date(2010, 1,10);
var endDate = new Date(2110, 4,15);
var startDayOfWeek = 1; //Monday
sheql.getDates('m.sep d:l[x+2].tue', startDate, endDate, startDayOfWeek);
```


Contributors
[@atsiddiqui](https://github.com/atsiddiqui)
[@raj-nt](https://github.com/raj-nt)
