
---

# 📚 SlideSpeak Presentation Manager

This project is a command-line tool that interacts with the **SlideSpeak API** to generate, edit, and manage presentations dynamically. It offers multiple scripts in **Ruby** and **Python** for generating and editing presentations via the API.

---

### Ruby demo

![ruby script demo](https://github.com/user-attachments/assets/82680c02-53d1-4038-9fee-929cb5c1b1f6)

### Python demo

![python script demo](https://github.com/user-attachments/assets/e0565828-1c77-4d83-a995-785cf3c499c6)

---

## 🚀 Getting Started

1. Set your **API key**:
   ```bash
   export SLIDE_SPEAK_API_KEY="your_api_key_here"
   ```

2. Use the `Makefile` to run the desired script:
   ```bash
   make up             # Start docker containers
   make ruby           # Run the Ruby presentation generator
   make python_simple  # Run the Python simple generator script
   make python         # Run the Python edit script
   ```

3. Monitor progress, generate presentations, and edit slides dynamically.

---

## 📋 Table of Contents

1. [Dependencies](#-dependencies)
2. [Make Commands](#-make-commands)
3. [Ruby Script](#-ruby-script)
4. [Python Scripts](#-python-scripts)
5. [API Endpoints](#-api-endpoints)
6. [API Key Setup](#-api-key-setup)
7. [Project Structure](#-project-structure)

---

## 🛠 Dependencies

To run this project seamlessly, you need the following tools installed:

- **Docker Compose**: To containerize and run scripts.
- **Make**: Simplifies task execution using `Makefile`.

---

## ⚙️ Make Commands

This project includes a **Makefile** for automation. Below is a table of available commands:

| Command           | Description                                               |
|-------------------|-----------------------------------------------------------|
| `make up`         | Initialize docker containers (detached).                  |
| `make down`       | Stop and remove docker containers.                        |
| `make ruby`       | Run the Ruby presentation generator script.               |
| `make python`     | Run the Python edit presentation script.                  |
| `make python_simple` | Run the Python simple presentation generator script.  |
| `make all`        | Execute all scripts (`ruby`, `python_simple`, and `python`).|

---

## 💎 Ruby Script

The **Ruby script**, `slidespeak_generator.rb`, performs the following tasks:

1. Generates a presentation using the **SlideSpeak API**.
2. Polls the API for task status until the presentation is ready.
3. Saves task details (ID, status, and download link) into a CSV file for persistence.
4. Offers an interactive menu for:
   - Viewing generated presentations.
   - Saving slides and shapes to a JSON file.
   - Dynamic navigation of slides and shapes.

Run it via the Makefile:
```bash
make ruby
```

---

## 🐍 Python Scripts

### **1. Simple Presentation Generator**

The **simple Python script**, `slidespeak_simple_generator.py`, mirrors the Ruby script functionality for generating presentations:

1. Generates presentations using the **SlideSpeak API**.
2. Polls the task status until completion.
3. Outputs progress and task details in the terminal.

Run it via:
```bash
make python_simple
```

---

### **2. Presentation Editor**

The **Python editor script**, `slidespeak_editor.py`, enables dynamic editing of existing presentations:

1. Allows users to upload a presentation file.
2. Retrieves slide and shape data from the presentation.
3. Lets users interactively select slides and shapes to edit.
4. Sends edits to the `/edit` API endpoint.
5. Retrieves a new presentation URL with the applied changes.

Run it via:
```bash
make python
```

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

- **Response**:
  ```json
  {
    "task_id": "e1ef5774-97a4-47f8-9295-c1ea69ad3a02"
  }
  ```

---

### 2. Get Task Status

- **Method**: `GET`
- **Endpoint**: `/api/v1/task_status/{task_id}`
- **Headers**:
  - `X-API-key: YOUR_API_KEY`

- **Response**:
  ```json
  {
    "task_id": "e1ef5774-97a4-47f8-9295-c1ea69ad3a02",
    "task_status": "SUCCESS",
    "task_result": {
      "url": "https://slidespeak-files.s3.us-east-2.amazonaws.com/e6f70498-c6ae-4c16-a0de-663551698c5f.pptx"
    },
    "task_info": {
      "url": "https://slidespeak-files.s3.us-east-2.amazonaws.com/e6f70498-c6ae-4c16-a0de-663551698c5f.pptx"
    }
  }
  ```

---

### 3. Edit a Presentation

- **Method**: `POST`
- **Endpoint**: `/api/v1/presentation/edit`
- **Headers**:
  - `X-API-key: YOUR_API_KEY`
- **Files**:
  - `pptx_file`: Binary content of the PPTX file.
- **Data**:
  ```json
  {
    "config": {
      "replacements": [
        {
          "shape_name": "TARGET_TITLE",
          "content": "My New Title"
        }
      ]
    }
  }
  ```

- **Response**:
  ```json
  {
    "url": "https://slidespeak-files.s3.us-east-2.amazonaws.com/updated-presentation.pptx"
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
./
├── slidespeak_generator.rb        # Ruby generator script
├── slidespeak_simple_generator.py # Simple Python generator script
├── presentation_manager.py        # Simple Python generator script
├── slidespeak_editor.py           # Python editor script
├── Makefile                       # Automation commands
├── docker-compose.yml             # Docker configuration
├── Dockerfile.ruby                # Dockerfile for Ruby
├── Dockerfile.python              # Dockerfile for Python
├── requirements.txt               # Python dependencies
└── Gemfile                        # Ruby dependencies
```

---

> Notes: 
  (https://docs.slidespeak.co/basics/openapi) Missing `task_result` on response sections.
  Edit endpoint is not clear, and it is missing API header specification