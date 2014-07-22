Days = require('./getDays')()
module.exports = ->
    obj = startDay: 0

    # Start Day of the week is Sunday by default,
    # but can be easily changed to any other day also

    obj.getCollectionForMonth = (year, month) ->
        size = Days.dayCountForMonth year, month
        startDate = new Date year, month, 1
        endDate = new Date year, month, size
        @getCollection startDate, endDate

    obj.getCollectionForYear = (year) ->
        startDate = new Date year, 0, 1
        endDate = new Date year, 11, 31
        @getCollection startDate, endDate


    obj.getCollection = (startDate, endDate) ->
        endDay = (@startDay + 6)%7
        weekList = []
        date = startDate
        count = 0

        while date.valueOf() <= endDate.valueOf()
            #console.log date, count
            #Start of the week
            if date.getDay() is @startDay or date.valueOf() is startDate.valueOf()
                wStartDate = date

            #end of week
            if date.getDay() is endDay or date.valueOf() is endDate.valueOf()
                weekList.push
                    value: count++
                    startDate: wStartDate
                    endDate: date
                    type: 'week'
                    props: [ Days.dayCount(wStartDate, date).toString() + 'd']

            #Go to next date
            date = Days.nextDate date
        weekList

    obj.getIncompleteStartDays = (date) ->
        dateDay = date.getDay()
        return 7 - (dateDay-@startDay) if @startDay < dateDay
        return @startDay - dateDay if @startDay > dateDay
        return 0

    obj.getIncompleteEndDays = (date) ->
        dateDay = date.getDay()
        return 1 + dateDay - @startDay if @startDay < dateDay
        return 8 - (@startDay - dateDay) if @startDay > dateDay
        return 1

    obj.weekCount = (startDate, endDate) ->
        count = 0
        date = startDate
        days = Days.dayCount startDate, endDate
        incompleteStartDays = @getIncompleteStartDays startDate
        incompleteEndDays = @getIncompleteEndDays endDate
        days = days - incompleteStartDays - incompleteEndDays

        count = days/7

        count++ if incompleteStartDays > 0
        count++ if incompleteEndDays > 0
        count

    obj