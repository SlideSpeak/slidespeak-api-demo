
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

Run it via the Makefile:
```bash
make ruby
```

---

## 🐍 Python Scripts

### **1. Simple Presentation Generator**

The **simple Python script**, `slidespeak_generator.py`, mirrors the Ruby script functionality for generating presentations:

1. Generates presentations using the **SlideSpeak API**.
2. Polls the task status until completion.
3. Outputs progress and task details in the terminal.
   - No Save to csv

Run it via:
```bash
make python_simple
```

---

### **2. Presentation Editor**

The **Python editor script**, `slidespeak_editor.py`, enables dynamic editing of existing presentations:

1. Allows users to upload a presentation file or from a URL.
2. Retrieves slide and shape data from the presentation.
3. Lets users interactively select slides and shapes to edit.
4. Sends edits to the `/api/v1/presentation/edit` API endpoint.
5. Retrieves a new presentation URL with the applied changes.
6. Allows to save presentation slides and shapes to a json.

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

<details>
  <summary>See the JSON generated by the python CLI</summary>

```json
{
  "presentation": [
    {
      "slide_number": 1,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "<No text>"
        },
        {
          "name": "Text 2",
          "content": "<No text>"
        },
        {
          "name": "Text 3",
          "content": "<No text>"
        },
        {
          "name": "Text 4",
          "content": "<No text>"
        },
        {
          "name": "Text 5",
          "content": "<No text>"
        },
        {
          "name": "Text 6",
          "content": "Exploring the Adventures and Challenges in the Land of the Shire, Mordor, and Beyond"
        },
        {
          "name": "Text 7",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 8",
          "content": "<No text>"
        }
      ]
    },
    {
      "slide_number": 2,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "<No text>"
        },
        {
          "name": "Text 2",
          "content": "<No text>"
        },
        {
          "name": "Text 3",
          "content": "<No text>"
        },
        {
          "name": "Text 4",
          "content": "Lord of the Rings\nKey Characters\nPlot Summary\nJourney to Mordor\nBattle of Helm's Deep\nFellowship of the Ring\nReturn of the King\nGollum's Betrayal\nThe One Ring\nThe Shire"
        },
        {
          "name": "Text 5",
          "content": "01\n02\n03\n04\n05\n06\n07\n08\n09\n10"
        },
        {
          "name": "Text 6",
          "content": "Table of contents"
        }
      ]
    },
    {
      "slide_number": 3,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "01"
        },
        {
          "name": "Text 2",
          "content": "02"
        },
        {
          "name": "Text 3",
          "content": "03"
        },
        {
          "name": "Text 4",
          "content": "<No text>"
        },
        {
          "name": "Text 5",
          "content": "04"
        },
        {
          "name": "Text 6",
          "content": "05"
        },
        {
          "name": "Text 7",
          "content": "<No text>"
        },
        {
          "name": "Text 8",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 9",
          "content": "Themes"
        },
        {
          "name": "Text 10",
          "content": "Friendship, Sacrifice, Power, Good vs. Evil\nDeep exploration of moral and ethical dilemmas"
        },
        {
          "name": "Text 11",
          "content": "Characters"
        },
        {
          "name": "Text 12",
          "content": "Frodo Baggins, Gandalf, Aragorn, Legolas, Gimli, Samwise Gamgee\nIconic heroes on a quest to destroy the One Ring"
        },
        {
          "name": "Text 13",
          "content": "Setting"
        },
        {
          "name": "Text 14",
          "content": "Middle-earth\nRichly detailed fictional world with diverse races and cultures"
        },
        {
          "name": "Text 15",
          "content": "Publication Year"
        },
        {
          "name": "Text 16",
          "content": "1954-1955\nEpic fantasy novel released in three volumes"
        },
        {
          "name": "Text 17",
          "content": "Author"
        },
        {
          "name": "Text 18",
          "content": "J.R.R. Tolkien\nRenowned British writer and academic"
        },
        {
          "name": "Text 19",
          "content": "Lord of the Rings"
        },
        {
          "name": "Text 20",
          "content": "1"
        }
      ]
    },
    {
      "slide_number": 4,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "01"
        },
        {
          "name": "Text 2",
          "content": "02"
        },
        {
          "name": "Text 3",
          "content": "03"
        },
        {
          "name": "Text 4",
          "content": "<No text>"
        },
        {
          "name": "Text 5",
          "content": "04"
        },
        {
          "name": "Text 6",
          "content": "05"
        },
        {
          "name": "Text 7",
          "content": "<No text>"
        },
        {
          "name": "Text 8",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 9",
          "content": "Gimli"
        },
        {
          "name": "Text 10",
          "content": "A fierce dwarf warrior and loyal companion to Legolas, forming an unlikely friendship."
        },
        {
          "name": "Text 11",
          "content": "Legolas"
        },
        {
          "name": "Text 12",
          "content": "A skilled elven archer and member of the Fellowship, known for his keen eyesight and agility."
        },
        {
          "name": "Text 13",
          "content": "Gandalf"
        },
        {
          "name": "Text 14",
          "content": "The wise and powerful wizard who guides and aids the Fellowship on their quest."
        },
        {
          "name": "Text 15",
          "content": "Aragorn"
        },
        {
          "name": "Text 16",
          "content": "The rightful heir to the throne of Gondor, also known as Strider, a skilled ranger and leader."
        },
        {
          "name": "Text 17",
          "content": "Frodo Baggins"
        },
        {
          "name": "Text 18",
          "content": "The humble hobbit tasked with destroying the One Ring in the fires of Mount Doom."
        },
        {
          "name": "Text 19",
          "content": "Key Characters"
        },
        {
          "name": "Text 20",
          "content": "2"
        }
      ]
    },
    {
      "slide_number": 5,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "<No text>"
        },
        {
          "name": "Text 2",
          "content": "03"
        },
        {
          "name": "Text 3",
          "content": "02"
        },
        {
          "name": "Text 4",
          "content": "01"
        },
        {
          "name": "Text 5",
          "content": "<No text>"
        },
        {
          "name": "Text 6",
          "content": "<No text>"
        },
        {
          "name": "Text 7",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 8",
          "content": "The final battle for Middle-earth unfolds as Sauron's forces march on Gondor.\nFrodo reaches Mount Doom to destroy the Ring, while Aragorn claims his rightful place as king."
        },
        {
          "name": "Text 9",
          "content": "The Return of the King"
        },
        {
          "name": "Text 10",
          "content": "The fellowship is divided as Frodo and Sam continue towards Mordor.\nMeanwhile, Aragorn leads the defense of Helm's Deep against Saruman's forces."
        },
        {
          "name": "Text 11",
          "content": "The Two Towers"
        },
        {
          "name": "Text 12",
          "content": "The Fellowship of the Ring"
        },
        {
          "name": "Text 13",
          "content": "Frodo Baggins embarks on a perilous journey to destroy the One Ring.\nHe is joined by a diverse group including Aragorn, Legolas, Gimli, Gandalf, and others."
        },
        {
          "name": "Text 14",
          "content": "Plot Summary"
        },
        {
          "name": "Text 15",
          "content": "3"
        }
      ]
    },
    {
      "slide_number": 6,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "<No text>"
        },
        {
          "name": "Text 2",
          "content": "<No text>"
        },
        {
          "name": "Text 3",
          "content": "<No text>"
        },
        {
          "name": "Text 4",
          "content": "01"
        },
        {
          "name": "Text 5",
          "content": "02"
        },
        {
          "name": "Text 6",
          "content": "03"
        },
        {
          "name": "Text 7",
          "content": "<No text>"
        },
        {
          "name": "Text 8",
          "content": "<No text>"
        },
        {
          "name": "Text 9",
          "content": "04"
        },
        {
          "name": "Text 10",
          "content": "<No text>"
        },
        {
          "name": "Text 11",
          "content": "05"
        },
        {
          "name": "Text 12",
          "content": "<No text>"
        },
        {
          "name": "Text 13",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 14",
          "content": "Frodo and Sam are captured by Orcs and must find a way to escape and continue their quest to Mordor."
        },
        {
          "name": "Text 15",
          "content": "Captured by Orcs"
        },
        {
          "name": "Text 16",
          "content": "Frodo makes a fateful decision at Amon Hen, leading to the breaking of the Fellowship."
        },
        {
          "name": "Text 17",
          "content": "Ambushed at Amon Hen"
        },
        {
          "name": "Text 18",
          "content": "The Fellowship faces the ancient evil lurking within the Mines of Moria."
        },
        {
          "name": "Text 19",
          "content": "Encountering the Mines of Moria"
        },
        {
          "name": "Text 20",
          "content": "The Fellowship navigates the treacherous paths and tunnels of the Misty Mountains."
        },
        {
          "name": "Text 21",
          "content": "Crossing the Misty Mountains"
        },
        {
          "name": "Text 22",
          "content": "Frodo, Sam, Merry, and Pippin begin their perilous journey from the peaceful Shire."
        },
        {
          "name": "Text 23",
          "content": "Setting out from the Shire"
        },
        {
          "name": "Text 24",
          "content": "Journey to Mordor"
        },
        {
          "name": "Text 25",
          "content": "4"
        }
      ]
    },
    {
      "slide_number": 7,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "<No text>"
        },
        {
          "name": "Text 2",
          "content": "<No text>"
        },
        {
          "name": "Text 3",
          "content": "<No text>"
        },
        {
          "name": "Text 4",
          "content": "<No text>"
        },
        {
          "name": "Text 5",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 6",
          "content": "<No text>"
        },
        {
          "name": "Text 7",
          "content": "Helm's Deep, a fortress in the mountains of Rohan\nSurrounded by imposing walls and a deep ravine"
        },
        {
          "name": "Text 8",
          "content": "The Setting"
        },
        {
          "name": "Text 9",
          "content": "Battle of Helm's Deep"
        },
        {
          "name": "Text 10",
          "content": "5"
        }
      ]
    },
    {
      "slide_number": 8,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "01"
        },
        {
          "name": "Text 2",
          "content": "02"
        },
        {
          "name": "Text 3",
          "content": "03"
        },
        {
          "name": "Text 4",
          "content": "<No text>"
        },
        {
          "name": "Text 5",
          "content": "04"
        },
        {
          "name": "Text 6",
          "content": "05"
        },
        {
          "name": "Text 7",
          "content": "<No text>"
        },
        {
          "name": "Text 8",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 9",
          "content": "Legacy of the Fellowship"
        },
        {
          "name": "Text 10",
          "content": "Their actions shaped the fate of Middle-earth.\nRemembered as heroes who stood against the darkness."
        },
        {
          "name": "Text 11",
          "content": "Bond of Friendship"
        },
        {
          "name": "Text 12",
          "content": "Developed strong bonds and camaraderie during their journey.\nShowed courage, loyalty, and sacrifice for the greater good."
        },
        {
          "name": "Text 13",
          "content": "Challenges and Trials"
        },
        {
          "name": "Text 14",
          "content": "Faced dangers such as the Mines of Moria and the betrayal of Boromir.\nTested their unity and resolve against the forces of darkness."
        },
        {
          "name": "Text 15",
          "content": "Mission to Destroy the One Ring"
        },
        {
          "name": "Text 16",
          "content": "Tasked with taking the Ring to Mount Doom to destroy it.\nLed by Frodo Baggins, the Ring-bearer."
        },
        {
          "name": "Text 17",
          "content": "Formation of the Fellowship"
        },
        {
          "name": "Text 18",
          "content": "Nine members chosen to represent different races of Middle-earth."
        },
        {
          "name": "Text 19",
          "content": "Fellowship of the Ring"
        },
        {
          "name": "Text 20",
          "content": "6"
        }
      ]
    },
    {
      "slide_number": 9,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "<No text>"
        },
        {
          "name": "Text 2",
          "content": "<No text>"
        },
        {
          "name": "Text 3",
          "content": "<No text>"
        },
        {
          "name": "Text 4",
          "content": "<No text>"
        },
        {
          "name": "Text 5",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 6",
          "content": "<No text>"
        },
        {
          "name": "Text 7",
          "content": "Aragorn is crowned King of Gondor"
        },
        {
          "name": "Text 8",
          "content": "3019"
        },
        {
          "name": "Text 9",
          "content": "Return of the King"
        },
        {
          "name": "Text 10",
          "content": "7"
        }
      ]
    },
    {
      "slide_number": 10,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "01"
        },
        {
          "name": "Text 2",
          "content": "02"
        },
        {
          "name": "Text 3",
          "content": "03"
        },
        {
          "name": "Text 4",
          "content": "<No text>"
        },
        {
          "name": "Text 5",
          "content": "04"
        },
        {
          "name": "Text 6",
          "content": "05"
        },
        {
          "name": "Text 7",
          "content": "<No text>"
        },
        {
          "name": "Text 8",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 9",
          "content": "Betrayal of Frodo"
        },
        {
          "name": "Text 10",
          "content": "Ultimately, Gollum's betrayal culminates in a pivotal moment where he betrays Frodo, leading to a critical turning point in the quest to destroy the Ring."
        },
        {
          "name": "Text 11",
          "content": "Plotting with Sauron"
        },
        {
          "name": "Text 12",
          "content": "Gollum's true allegiance is revealed as he conspires with Sauron to reclaim the Ring for himself."
        },
        {
          "name": "Text 13",
          "content": "Deception of Frodo"
        },
        {
          "name": "Text 14",
          "content": "Gollum initially befriends Frodo and Sam, pretending to guide them to Mordor."
        },
        {
          "name": "Text 15",
          "content": "Transformation into Gollum"
        },
        {
          "name": "Text 16",
          "content": "Over centuries, the Ring corrupts Gollum, turning him into a twisted and deceitful creature."
        },
        {
          "name": "Text 17",
          "content": "Discovery of the Ring"
        },
        {
          "name": "Text 18",
          "content": "Gollum discovers the One Ring in the depths of the Misty Mountains."
        },
        {
          "name": "Text 19",
          "content": "Gollum's Betrayal"
        },
        {
          "name": "Text 20",
          "content": "8"
        }
      ]
    },
    {
      "slide_number": 11,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "01"
        },
        {
          "name": "Text 2",
          "content": "02"
        },
        {
          "name": "Text 3",
          "content": "04"
        },
        {
          "name": "Text 4",
          "content": "03"
        },
        {
          "name": "Text 5",
          "content": "<No text>"
        },
        {
          "name": "Text 6",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 7",
          "content": "<No text>"
        },
        {
          "name": "Text 8",
          "content": "Only destroyed by casting it back into the fires of Mount Doom where it was originally forged.\nThe fate of Middle-earth hinges on the destruction of the One Ring."
        },
        {
          "name": "Text 9",
          "content": "Destruction"
        },
        {
          "name": "Text 10",
          "content": "Engraved with the words in Black Speech, \"One Ring to rule them all, One Ring to find them, One Ring to bring them all and in the darkness bind them.\"\nThe inscription reveals the Ring's true purpose and nature."
        },
        {
          "name": "Text 11",
          "content": "Inscription"
        },
        {
          "name": "Text 12",
          "content": "Grants invisibility to its wearer but corrupts their mind and soul.\nPossesses the ability to control the other Rings of Power."
        },
        {
          "name": "Text 13",
          "content": "Power"
        },
        {
          "name": "Text 14",
          "content": "Origin"
        },
        {
          "name": "Text 15",
          "content": "Crafted by the Dark Lord Sauron in the fires of Mount Doom.\nForged with the intent to rule over all other Rings of Power."
        },
        {
          "name": "Text 16",
          "content": "The One Ring"
        },
        {
          "name": "Text 17",
          "content": "9"
        }
      ]
    },
    {
      "slide_number": 12,
      "shapes": [
        {
          "name": "Text 0",
          "content": "GOLLUM"
        },
        {
          "name": "Text 1",
          "content": "01"
        },
        {
          "name": "Text 2",
          "content": "02"
        },
        {
          "name": "Text 3",
          "content": "03"
        },
        {
          "name": "Text 4",
          "content": "<No text>"
        },
        {
          "name": "Text 5",
          "content": "04"
        },
        {
          "name": "Text 6",
          "content": "05"
        },
        {
          "name": "Text 7",
          "content": "<No text>"
        },
        {
          "name": "Text 8",
          "content": "The Epic Saga of Middle-earth"
        },
        {
          "name": "Text 9",
          "content": "Party Tree"
        },
        {
          "name": "Text 10",
          "content": "Site of many festive gatherings"
        },
        {
          "name": "Text 11",
          "content": "Rolling Hills"
        },
        {
          "name": "Text 12",
          "content": "Iconic landscape of the Shire"
        },
        {
          "name": "Text 13",
          "content": "Bag End"
        },
        {
          "name": "Text 14",
          "content": "Home of Bilbo and Frodo Baggins"
        },
        {
          "name": "Text 15",
          "content": "Green Dragon Inn"
        },
        {
          "name": "Text 16",
          "content": "Popular meeting place for hobbits"
        },
        {
          "name": "Text 17",
          "content": "Hobbiton"
        },
        {
          "name": "Text 18",
          "content": "Charming village in the heart of the Shire"
        },
        {
          "name": "Text 19",
          "content": "The Shire"
        },
        {
          "name": "Text 20",
          "content": "10"
        }
      ]
    }
  ]
}
```

</details>

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