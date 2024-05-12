# Use the official Gradle image as a parent image
FROM gradle:7.5.0-jdk17 AS build

# Set the working directory inside the container
WORKDIR /home/gradle/src

# Copy the local code to the container's workspace
COPY --chown=gradle:gradle . /home/gradle/src

# Build the application using Gradle
RUN gradle build --no-daemon

# Use the official OpenJDK image to create a lean production image
FROM openjdk:17-slim


# Copy the built jars from the previous stage
COPY --from=build /home/gradle/src/build/libs/cloud-app-0.0.1-SNAPSHOT.jar /app/application.jar


# Run the application
CMD ["java", "-jar", "/app/application.jar"]
