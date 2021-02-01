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
    getById(id) {
        return database.get("user", id);
    }
    update(id, document) {
        return database.set("user", id, document);
    }
    getList() {
        return database.getList("user");
    }
}

module.exports = new UserModel();