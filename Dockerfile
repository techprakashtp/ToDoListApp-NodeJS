# First Stage

 FROM node:14-alpine AS base
    
 WORKDIR /app
 
 COPY package*.json ./
 
 COPY . .
 
 RUN rm -Rf node_modules
 
 RUN npm install 
 
 
 # Second Stage
 FROM node:14-slim AS production

 WORKDIR /app

 COPY --from=base /app .

 EXPOSE 3000

 CMD [ "node", "index.js" ]
