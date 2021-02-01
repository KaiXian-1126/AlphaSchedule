const userModel = require("../models/user_model")
const express = require("express");
const router = express.Router();

//For add new user
router.post("/create", createUser);
//For get user list
router.get('/', getUserList);
async function createUser(req, res, next) {
    const data = req.body;
    try {
        const result = await userModel.create(data);
        if (!result) return res.sendStatus(409);
        return res.status(201).json(result);
    } catch (e) {
        return next(e);
    }
}
async function getUserList(req, res, next) {
    try {
        const result = await userModel.getList();
        return res.json(result);
    } catch (e) {
        return next(e);
    }
}
module.exports = router;