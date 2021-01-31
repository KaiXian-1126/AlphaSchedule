const database = require("../database")
class CalendarModel {
    constructor() {
        if (this.instance) return this.instance;
        CalendarModel.instance = this;
    }
    create(document) {
        return database.create("calendar", document);
    }
    get(id) {
        return database.get("calendar", id);
    }
    delete(id) {
        return database.delete("calendar", id);
    }
}

module.exports = new CalendarModel();