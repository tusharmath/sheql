module.exports = ->
    obj = {}
    dayName = [
        'sun', 'mon'
        'tue', 'wed'
        'thr', 'fri'
        'sat'
    ]
    getPropCollection = (date) -> [dayName[date.getDay()], date.getDate().toString()]

    obj.nextDate = (date) ->
        date = new Date date.getFullYear(), date.getMonth(), date.getDate()
        date.setDate date.getDate()+1
        date

    obj.dayCountForMonth = (year, month) ->
        d = new Date year, month+1, 0
        d.getDate()

    obj.getCollection = (startDate, endDate) ->
        dates = []
        date = startDate
        while date.valueOf() <= endDate
            dates.push
                value: date
                type: 'date'
                props: getPropCollection date
            date = @nextDate date
        dates


    obj.dayCount = (startDate, endDate) ->
        one_day = 1000*60*60*24
        startDate_ms = startDate.valueOf()
        endDate_ms = endDate.valueOf()
        difference_ms = endDate_ms - startDate_ms
        return 1+difference_ms/one_day
    obj