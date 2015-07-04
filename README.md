#Schedule Query Langauge
![alt text](https://raw.githubusercontent.com/practo/sheql/master/public/images/scheql.png)


SHEQL is a schema less solution to the problem of storing repeated events in a calendar. It is inspired by CSS selectors.

#Features

1. A Far More powerful and customizable logic for repetition can be written.
2. A Schemaless Architecture.
3. A single change is required to update repeated events.
4. Platform independent.

[Learn more about the syntax](https://github.com/tusharmath/sheql/wiki/Rules).


#Elements
They are analogous to tag names in HTML.

1. `y` - Representing years

2. `m` - Representing months

3. `w` - Representing weeks

4. `d` - Representing days

#Element Properties
Properties are like css classes applied on tags. Each tag has its own set of classes (properties as we call them here).

###Years

1. `365d`, `366d` - Filters all the years in the given range which have 365 days or 366 days (AKA leap year)

2. `52w` -  Filters all the years based on the total number of weeks that fall in that year. First day of the week is Sunday be default.

3. `2015` - Filter based on the year value.

###Months

1. `31d`, `30d`, `29d`, `28d` - Filters all the the months based on the total days that are in that month.

2. `4w`, `5w` - Filter out months based on the number of weeks in it.

3. `jan` ... `dec` - Filtering based on the month name.

###Weeks
1. `7d`, `4d` - Filter outs weeks based on the total number of days in it.

###Days

1. `21` - Filter based on the date value.

2. `sat`, `sun`, ... `fri` - Filter days on the day of the week.

##Filters

Filters can be applied on any type of element. They can use the element's properties also.

###Dot notation 
Use it to filter out elements that have the specified property.

```css
y.365d /*Selects non-leap years*/
m.jan  /*Select the month January*/
```

###exclamation notation
Use it to filter out elements that do NOT have the specified property.
```css
m!jan /*all months except january*/
```

###nth element
Use it to filter out the nth element
```css
d:n[x+3] /*All days except the first 2*/
d:n[3]   /*3 day only*/
d:n[2x]  /*All alternate days*/
```

###lth element
Use it to filter out the nth element for the last element.
```css
d:l[x+3] /*All days except the last 2*/
```

#Examples


**Yearly repeated on the 45th day**

```css
y d:n[45]
```

**Monthly 1st sat**

```css
m d.sat:n[1]
```

**Monthly 1st day if it's a sat**

```css
m d:n[1].sat
```

**monthly last sat**

```css
m d.sat:l[1]
```

**monthly second last sat**

```css
m d.sat:l[2]
```

**monthly all sat**

```css
m d.sat
```

**every 3rd months 2nd sat**

```css
m:n[3x] d.sat:n[2]
```

**every 1st of every month**

```css
m d:n[1]
```

**Every alternate month second week, first mondays**

```css
m:n[2x] w:n[2] d.mon
```

**Every alternate month second monday**

```css
m:n[2x] d.mon:n[2]
```

**100th day of each year**

```css
y d:n[100]
```

**14th Feb every yr**

```css
y m:n[1] d:n[14]
y m.feb d:n[14]
y m.feb d.14
```

**Every 20th day**

```css
d:n[20x]
```


**every mar-dec weekdays**

```css
y m:n[-x+3] d:n[x+1]:n[-x+1]
```

**every day in jan except fridays**

```css
m.jan d!fri
```

**every alternate month's first and third saturday**

```css
m:n[2x] d.sat:l[x+2]:n[2x+1]
```

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

