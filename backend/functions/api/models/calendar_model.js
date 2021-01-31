const database = require("../database")
class CalendarModel {
    constructor() {
        if (this.instance) return this.instance;
        CalendarModel.instance = this;
    }
    create(document) {
        return database.create("calendar", document);
    }
}

module.exports = new CalendarModel();