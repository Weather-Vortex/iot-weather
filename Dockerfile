#
# Provide local weather data to remote server.
#
# Copyright (C) 2021  Daniele Tentoni
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

FROM node:14-alpine

ENV WORKINGDIR=/app

RUN mkdir -p ${WORKINGDIR}

WORKDIR ${WORKINGDIR}

# Install Dependencies
RUN pwd
RUN ls -la
COPY ./package*.json ${WORKINGDIR}/

RUN cd ${WORKINGDIR} && npm install --silent

# Copy app source code
COPY ./src/ ${WORKINGDIR}/src/

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Exports
# Ignored by Heroku by default
# https://help.heroku.com/PPBPA231/how-do-i-use-the-port-environment-variable-in-container-based-apps
# EXPOSE 15600  

CMD ["npm", "start"]