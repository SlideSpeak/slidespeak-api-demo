import os
import requests
import time

API_KEY = os.getenv("SLIDE_SPEAK_API_KEY")
BASE_URL = "https://api.slidespeak.co/api/v1"

if not API_KEY:
    print("Error: SLIDE_SPEAK_API_KEY environment variable not set.")
    exit(1)

def generate_presentation(plain_text, theme=None, length=10):
    url = f"{BASE_URL}/presentation/generate"
    headers = {
        "Content-Type": "application/json",
        "X-API-key": API_KEY,
    }
    payload = {"plain_text": plain_text, "theme": theme, "length": length}
    print(f"POST {url}")
    response = requests.post(url, json=payload, headers=headers)
    return response.json()

def get_task_status(task_id):
    url = f"{BASE_URL}/task_status/{task_id}"
    headers = {"X-API-key": API_KEY}

    response = requests.get(url, headers=headers)
    return response.json()

print("Generating presentation about the French Revolution...")
response = generate_presentation("The French Revolution was a period of radical social and political upheaval in France from 1789 to 1799.")

if "task_id" in response:
    task_id = response["task_id"]
    print(f"Task ID: {task_id}")
    print("Polling for completion...")

    while True:
        status = get_task_status(task_id)
        print(f"Status: {status['task_status']}")
        if status['task_status'] == "SUCCESS":
            print("Presentation generation complete!")
            print("*" * 42)
            print(f"Download your presentation here: {status['task_result']['url']}")
            print("*" * 42)
            break
        time.sleep(2)
else:
    print("Error generating presentation.")
