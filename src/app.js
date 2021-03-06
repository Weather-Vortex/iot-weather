/*
Provide local weather data to remote server.

Copyright (C) 2021  Daniele Tentoni

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

"use strict";

const express = require("express");
const weather = require("./storage/weather.storage");

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/current", weather.readAll);

app.get("/info", (req, res, next) =>
  res.status(200).json({ name: process.env.DEVICE_NAME, files: weather.files })
);

const port = process.env.PORT || 15600;

app.listen(port, () => {
  console.log("Application running on http://localhost:%i", port);
});

module.exports = app;
