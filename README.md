# Chat Application

This Chat Application provides a real-time messaging platform where users can interact with an automated assistant and other users. Built with Ruby on Rails and leveraging Hotwire's Turbo and Stimulus libraries, it offers a dynamic and responsive user experience without the need for complex front-end frameworks.

## Features

- **Real-time messaging** with automated responses from an assistant.
- **Filtering** by gender and category to efficiently find and chat with assistants.
- **Asynchronous** processing of messages from users for a responsive UI.
- **Turbo Frames** scoping of messages for efficient DOM updates.
- **Persisted** messages for future reference.
- **SPA experience** with Turbo Streams for a real-time experience.
- **Load balancing** implementation (round robin like) allowing an equal sharing (>98% efficiency) load on multiple servers to handle incoming requests.

## Technology Stack

- **Backend**: Ruby on Rails
- **Frontend**: Hotwire (Turbo + Stimulus), HTML, CSS
- **Background Processing**: Sidekiq with Redis
- **Database**: PostgreSQL
- **Deployment**: Configured for deployment to Heroku

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- **Docker and Docker Compose**: The local dev application uses Docker for PostgreSQL and Redis services.
- **Ruby version**: Ensure you have Ruby 3.3.0 installed.
- **PostgreSQL**: The application uses PostgreSQL as its database.


### Installation
1. Clone the repository:
```bash
git clone https://github.com/DonGiulio/chat-api-connector.git
cd chat-api-connector
```

2. Configuration

Configurations can be fetched via environment variables, clone the `.env.example` file to `.env` and fill in the necessary details.

3. Start postgresql and redis via docker

```bash
docker-compose up -d
```
 
4. Install dependencies:

```bash
bundle install
```

5. Setup the database:

```bash
rails db:create db:migrate db:seed
```

6. Start the Rails server:

```bash
rails server
```

7. (Optional) Start Sidekiq for background processing:

```bash
bundle exec sidekiq
```

### Usage
Visit http://localhost:3000 to view the application.
Log in or sign up to start chatting.
Use the chat interface to send messages and receive responses from the assistant.

### Testing
Run rspec to execute the test suite:

```bash
bundle exec rspec
```

### Deployment
The application is configured for deployment to Heroku. Ensure you have set up the necessary environment variables and add-ons (like Heroku PostgreSQL and Redis).

### Contributing
Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

1. Fork the Project
2. Create your Feature Branch (git checkout -b feature/AmazingFeature)
3. Commit your Changes (git commit -m 'Add some AmazingFeature')
4. Push to the Branch (git push origin feature/AmazingFeature)
5. Open a Pull Request

### License
Distributed under the MIT License. See LICENSE for more information.

### Contact
Giulio Giraldi

Project Link: https://github.com/DonGiulio/chat-api-connector
