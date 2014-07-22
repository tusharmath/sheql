should = require "should"
describe "getWeeks", ->
    getWeeks = {}
    wk = {}
    dStart = ''
    dEnd = ''
    beforeEach ->
        wk = getWeeks()

    before ->
        getWeeks = require "../src/getWeeks"

    after ->
        delete require.cache[require.resolve "../src/getWeeks" ]

    it "should exist", ->
        should.exist wk

    describe "getCollection", ->
        it "should exist", -> should.exist wk.getCollection

        it "should return an array", ->
            dStart = new Date 2014, 1, 3
            dEnd = new Date 2014, 1, 20
            wk.getCollection( dStart, dEnd).length.should.equal 3

        it "should attach start and end dates", ->
            dStart = new Date 2013, 11, 27
            dEnd = new Date 2014, 1, 20
            [w1] = wk.getCollection(dStart, dEnd)
            w1.startDate.valueOf().should.equal dStart.valueOf()
            w1.endDate.valueOf().should.equal (new Date 2013, 11, 28).valueOf()

         it "should attach weeks size in days", ->
            dStart = new Date 2014, 5, 22
            dEnd = new Date 2014, 6, 1
            [w1, w2, w3] = wk.getCollection(dStart, dEnd)
            w1.props.should.eql ['7d']
            w2.props.should.eql ['3d']

    describe "getCollectionForMonth", ->
        it "should exist", -> should.exist wk.getCollectionForMonth

        it "should return an array", ->
            wk.getCollectionForMonth(2014, 0).length.should.equal 5


    describe "getCollectionForYear", ->
        it "should exist", -> should.exist wk.getCollectionForYear

        it "should return an array", ->
            wk.getCollectionForYear(2014).length.should.equal 53

    describe "getIncompleteEndDays", ->
        it "should return number of days", ->
            wk.getIncompleteEndDays new Date 2014, 0, 28
            .should.equal 3

            wk.getIncompleteEndDays new Date 2014, 1, 28
            .should.equal 6

            wk.getIncompleteEndDays new Date 2014, 1, 2
            .should.equal 1

            wk.getIncompleteEndDays new Date 2014, 1, 27
            .should.equal 5


        it "should handle variable startDay", ->
            wk.startDay = 4
            wk.getIncompleteEndDays new Date 2014, 1, 28
            .should.equal 2

            wk.startDay = 5
            wk.getIncompleteEndDays new Date 2014, 1, 26
            .should.equal 6


    describe "getIncompleteStartDays", ->
        it "should return number of days", ->
            wk.getIncompleteStartDays new Date 2014, 3, 2
            .should.equal 4

            wk.getIncompleteStartDays new Date 2014, 0, 2
            .should.equal 3

            wk.getIncompleteStartDays new Date 2014, 0, 5
            .should.equal 0

            wk.getIncompleteStartDays new Date 2014, 1, 3
            .should.equal 6

            wk.getIncompleteStartDays new Date 2000, 0, 1
            .should.equal 1

            wk.getIncompleteStartDays new Date 2014, 5, 6
            .should.equal 2

            wk.getIncompleteStartDays new Date 2014, 5, 3
            .should.equal 5

        it "should handle variable startDay", ->
            wk.startDay = 4
            wk.getIncompleteStartDays new Date 2014, 0, 2
            .should.equal 0

            wk.startDay = 3
            wk.getIncompleteStartDays new Date 2014, 5, 3
            .should.equal 1



    describe "weekCount", ->
        it "should exist", ->
            should.exist wk.weekCount

        it "should use the set first day of the week", ->
            dStart = new Date 2000, 0, 1
            dEnd = new Date 2000, 11, 31
            wk.startDay = 1
            wk.weekCount(dStart, dEnd).should.equal 53

        it "should return week count", ->
            dStart = new Date 2014, 1, 3
            dEnd = new Date 2014, 1, 20
            wk.weekCount(dStart, dEnd).should.equal 3

            dStart = new Date 2016, 3, 15
            dEnd = new Date 2016, 3, 23
            wk.weekCount(dStart, dEnd).should.equal 2

            dStart = new Date 2000, 0, 1
            dEnd = new Date 2000, 0, 31
            wk.weekCount(dStart, dEnd).should.equal 6

            dStart = new Date 2016, 0, 23
            dEnd = new Date 2016, 0, 31
            wk.weekCount(dStart, dEnd).should.equal 3


        it "should return week count for year", ->
            dStart = new Date 2014, 0, 10
            dEnd = new Date 2014, 1, 14
            wk.weekCount(dStart, dEnd).should.equal 6

        it "should return week count for same week", ->
            dStart = new Date 2013, 11, 30
            dEnd = new Date 2014, 0, 2
            wk.weekCount(dStart, dEnd).should.equal 1

