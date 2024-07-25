FROM nginx

# Copy the Angular frontend project to /opt
COPY angular-frontend /opt

# Set the working directory to /opt/angular-frontend
WORKDIR /opt/angular-frontend

# Update package lists and install nodejs and npm
RUN apt update && apt install -y nodejs npm

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Ensure the file exists before running the sed command
RUN ls /opt/angular-frontend/src/app/services/worker.service.ts

# Replace the localhost with the public IP of Backend App in WorkerService
RUN sed -i 's|http://localhost:8080|http://18.175.121.191:8080|' src/app/services/worker.service.ts

# Install project dependencies
RUN npm install

# Build the Angular project
RUN ng build

# Expose port 40080
EXPOSE 40080

# Serve the application
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "40080"]


