Days = require('./getDays')()
module.exports = ->
    monthName = [
        'jan', 'feb', 'mar',
        'apr', 'may', 'jun',
        'jul', 'aug', 'sep',
        'oct', 'nov', 'dec'
    ]

    obj = {}
    getStartDate = (startDate, year, month) ->
        tmpStartDate = new Date year, month, 1

        if tmpStartDate.valueOf() < startDate.valueOf()
            tmpStartDate = startDate

        tmpStartDate

    getEndDate = (endDate, year, month) ->
        tmpEndDate = new Date year, month, Days.dayCountForMonth year, month
        if tmpEndDate.valueOf() > endDate.valueOf()
            tmpEndDate = endDate
        tmpEndDate



    propCollection = (year, month) -> [monthName[month], Days.dayCountForMonth(year, month)+'d']


    obj.monthCountForYear = (startDate, endDate, year) ->
        startYear = startDate.getFullYear()
        endYear = endDate.getFullYear()
        if startYear is year and endYear is year
            return @monthCount startDate, endDate

        if startYear is year
            return @monthCount startDate, new Date year, 11, 31

        if endYear is year
            return @monthCount new Date(year, 0, 1), endDate
        12


    #Should return a count only
    obj.monthCount = (startDate, endDate) ->
        #Adding 12 months in a year
        months = (endDate.getFullYear() - startDate.getFullYear() + 1) * 12

        #Adding 12 months in a year
        months -= startDate.getMonth()
        months -= 12 - endDate.getMonth() - 1
        months

    obj.getCollectionForYear = (startDate, endDate, year)->

        startYear = startDate.getFullYear()
        endYear = endDate.getFullYear()

        if startYear is year and endYear is year
            return @getCollection startDate, endDate

        if startYear is year
            return @getCollection startDate, new Date year, 11, 31

        if endYear is year
            return @getCollection new Date(year, 0, 1), endDate

        return @getCollection new Date(year, 0, 1), new Date(year, 11, 31)

    obj.getCollection = (startDate, endDate) ->
        months =[]
        count = @monthCount startDate, endDate
        startMonth = startDate.getMonth()
        startYear = startDate.getFullYear()
        date = new Date startYear, startMonth, 1

        for i in [0...count]
            # console.log date

            year = date.getFullYear()
            month = date.getMonth()

            months.push
                type: 'month'
                props: propCollection year, month
                startDate: getStartDate startDate, year, month
                endDate: getEndDate endDate, year, month

            date.setMonth date.getMonth() + 1

        months

    obj