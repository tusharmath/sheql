var exe = require('./lib/executor')();
module.exports.getDates = function (str, startDate, endDate, startOfWeek) {
	return exe.executor(str, startDate, endDate, startOfWeek);
};