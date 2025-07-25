# Use a base image with Java and Tomcat
FROM tomcat:10.0

# Set the working directory inside the container
WORKDIR /usr/local/tomcat/webapps/

# Remove default ROOT application (optional, if you want your app to be ROOT)
RUN rm -rf ROOT

# Copy the WAR file from the Jenkins workspace into the webapps directory
# The WAR file will be named retail-app.war after Maven build
COPY target/retail-app.war .

# Rename the WAR file to ROOT.war if you want it accessible at the root context
RUN mv retail-app.war ROOT.war

# Expose the Tomcat default port
EXPOSE 8080

# Command to run Tomcat (default for this image)
CMD ["catalina.sh", "run"]
