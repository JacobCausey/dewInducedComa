#BUILD ENVIROMENT

# FROM node:16.15.0 as build

# ARG EXPO_TOKEN
# ENV EXPO_TOKEN $EXPO_TOKEN

# WORKDIR /app
# ENV PATH /app/node_modules/.bin:$PATH
# COPY package.json ./
# #COPY package-lock.json ./
# RUN npm install
# COPY . ./
# RUN npm run test
# RUN rm ./package-lock.json
# RUN npm install eas-cli --global
# RUN npx eas-cli build --profile preview --platform android --non-interactive

FROM maven:3.6.3-adoptopenjdk-14 AS MAVEN_BUILD

WORKDIR /opt/stedi

COPY . ./

RUN mvn clean package

FROM adoptopenjdk/openjdk14

COPY --from=MAVEN_BUILD /opt/stedi/target/StepTimerWebsocket-1.0-SNAPSHOT.jar /stedi.jar

ENTRYPOINT ["java", "-jar", "/stedi.jar"]

EXPOSE 4567