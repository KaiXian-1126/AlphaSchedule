const database = require("../database")
class UserModel {
    constructor() {
        if (this.instance) return this.instance;
        UserModel.instance = this;
    }
    create(document) {
        return database.create("user", document);
    }
    get(id) {
        return database.get("user", id);
    }
}

module.exports = new UserModel();