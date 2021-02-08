const eventModel = require('../models/event_model');
const calendarModel = require("../models/calendar_model")
const express = require('express');
const router = express.Router();

//add new event to calendar
router.post("/create/:calendarid", createEvent);
//For get specific calendar
router.get("/get/:eventid", getEvent);
//For get specific calendar
router.get("/getList/:calendarid", getEventList);
//For get specific calendar
router.patch("/update/:eventid", updateEvent);
//For delete the calendar
router.delete("/delete/:eventid", deleteEvent);

async function createEvent(req, res, next) {
    const calendarid = req.params.calendarid;
    const data = req.body;

    try {
        const calendar = await calendarModel.get(calendarid);
        if (!calendar) return res.sendStatus(404);

        const result = await eventModel.create(data);
        if (!result) return res.sendStatus(409);

        calendar.eventList.push(result.id);
        const updateCalendar = await calendarModel.update(calendarid, calendar);
        if (!updateCalendar) return res.sendStatus(404);
        return res.status(201).json(result);
    } catch (e) {
        return next(e);
    }
}

async function getEvent(req, res, next) {
    const eventid = req.params.eventid;
    try {
        const result = await eventModel.getById(eventid);
        if (!result) return res.sendStatus(404);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
}

async function getEventList(req, res, next) {
    const calendarid = req.params.calendarid;
    try {
        const calendar = await calendarModel.get(calendarid);
        if (!calendar) return res.sendStatus(404);
        const getList = calendar.eventList;
        var eventList = [];
        for (i = 0; i < getList.length; i++) {
            const event = await eventModel.getById(getList[i]);
            if (!event) return res.sendStatus(404);
            eventList.push(event);
        }
        return res.json(eventList);
    } catch (e) {
        return next(e);
    }
}

async function updateEvent(req, res, next) {
    const id = req.params.eventid;
    const data = req.body;
    try {
        const event = await eventModel.getById(id);
        if (!event) return res.sendStatus(404);

        // Merge existing fields with the ones to be updated
        Object.keys(data).forEach((key) => (event[key] = data[key]));

        const updateResult = await eventModel.update(id, event);
        if (!updateResult) return res.sendStatus(404);

        return res.json(event);
    } catch (e) {
        return next(e);
    }
}

async function deleteEvent(req, res, next) {
    const id = req.params.eventid;
    try {
        const event = await eventModel.getById(id);
        if (!event) return res.sendStatus(404);
        //get calendar
        const calendar = await calendarModel.get(event.calendarId);
        if (!calendar) return sendStatus(404);
        //remove event from calendar
        for (i = 0; i < calendar.eventList.length; i++) {
            if (calendar.eventList[i] == id) {
                calendar.eventList.splice(i, 1);
            }
        }
        var result1 = await calendarModel.update(event.calendarId, calendar);
        if (!result1) return res.sendStatus(404);
        // delete event from event collection
        const result = await eventModel.delete(id);
        if (!result) return res.sendStatus(404);
        return res.sendStatus(200);
    } catch (e) {
        return next(e);
    }

}

module.exports = router;