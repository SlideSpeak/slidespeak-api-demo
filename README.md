
---

# 📚 SlideSpeak Presentation Generator

This project is a command-line tool that interacts with the **SlideSpeak API** to generate presentations based on textual input.

---

## 🚀 Getting Started

1. Set your **API key**:
   ```bash
   export SLIDE_SPEAK_API_KEY="your_api_key_here"
   ```

2. Use the `Makefile` to run the desired script:
   ```bash
   make up      # Start docker containers
   make ruby    # For the Ruby script
   make python  # For the Python script
   ```

3. Monitor progress and view generated presentations.

---

### Ruby Script Demo

![ruby script demo](https://github.com/user-attachments/assets/905b2446-3f32-4cf3-8552-41d2a1ed4542)

---

## 📋 Table of Contents

1. [Dependencies](#-dependencies)
2. [Make Commands](#-make-commands)
3. [Ruby Script](#-ruby-script)
4. [Python Script](#-python-script)
5. [API Endpoints](#-api-endpoints)
6. [API Key Setup](#-api-key-setup)

---

## 🛠 Dependencies

To run this project seamlessly, you need the following tools installed:

- **Docker Compose**: To containerize and run scripts.
- **Make**: Simplifies task execution using `Makefile`.

---

## ⚙️ Make Commands

This project comes with a **Makefile** to automate tasks. Below is a table of available commands:

| Command         | Description                                     |
|-----------------|-------------------------------------------------|
| `make up`       | Initialize docker containers (detached)         |
| `make down`     | Remove docker containers                        |
| `make ruby`     | Run the Ruby script to generate presentations.  |
| `make python`   | Run the Python script to generate presentations.|
| `make all`      | Run both the Ruby and Python scripts.           |

---

## 💎 Ruby Script

![ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/e786f654-9496-4e28-b868-ad4e8d74127a)

The Ruby script, `slidespeak_client.rb`, performs the following tasks:

1. Generates a presentation using the **SlideSpeak API**.
2. Polls the API for task status until the presentation is ready.

---

## 🐍 Python Script

The Python script, `slidespeak_generator.py`, provides similar functionality as the Ruby script:

1. Generates presentations using the **SlideSpeak API**.
2. Polls the task status until completion.
3. Outputs progress and task details in the terminal.

---

## 🌐 API Endpoints

This project uses the following **SlideSpeak API** endpoints:

### 1. Generate a Presentation

- **Method**: `POST`
- **Endpoint**: `/api/v1/presentation/generate`
- **Headers**:
  - `Content-Type: application/json`
  - `X-API-key: YOUR_API_KEY`
- **Payload**:
  ```json
  {
    "plain_text": "Key moments in the French Revolution",
    "length": 10,
    "theme": "default"
  }
  ```

- **Response*:
  ```rb
  {
    "e1ef5774-97a4-47f8-9295-c1ea69ad3a02"
  }
  ```

> Notes (https://docs.slidespeak.co/basics/openapi) Missing `task_result` on response sections

### 2. Get Task Status

- **Method**: `GET`
- **Endpoint**: `/api/v1/task_status/{task_id}`
- **Headers**:
  - `X-API-key: YOUR_API_KEY`
W
- **Response (SENT)*:
  ```rb
  {
    "task_id"=>"e1ef5774-97a4-47f8-9295-c1ea69ad3a02", "task_status"=>"SENT", "task_result"=>nil, "task_info"=>nil
  }
  ```

- **Response**:
  ```rb
  {
    "task_id"=>"e1ef5774-97a4-47f8-9295-c1ea69ad3a02",
    "task_status"=>"SUCCESS",
    "task_result"=>{
      "url"=>"https://slidespeak-files.s3.us-east-2.amazonaws.com/e6f70498-c6ae-4c16-a0de-663551698c5f.pptx"
    },
    "task_info"=>{
      "url"=>"https://slidespeak-files.s3.us-east-2.amazonaws.com/e6f70498-c6ae-4c16-a0de-663551698c5f.pptx"
    }
  }
  ```

---

## 🔑 API Key Setup

The SlideSpeak API requires an **API key** to authenticate requests. You must set the `SLIDE_SPEAK_API_KEY` environment variable before running the scripts.

### Steps to Set API Key:

1. Export the API key in your terminal:
   ```bash
   export SLIDE_SPEAK_API_KEY="your_api_key_here"
   ```

2. Verify the variable is set:
   ```bash
   echo $SLIDE_SPEAK_API_KEY
   ```
---

## 📂 Project Structure

```plaintext
project/
├── slidespeak_client.rb       # Ruby script
├── slidespeak_generator.py    # Python script
├── Makefile                   # Automation commands
├── docker-compose.yml         # Docker configuration
├── Dockerfile.ruby            # Dockerfile for Ruby
├── Dockerfile.python          # Dockerfile for Python
├── requirements.txt           # Python dependencies
└── Gemfile                    # Ruby dependencies
```

---
