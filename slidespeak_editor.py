import os
from rich.console import Console
import questionary
from presentation_manager import Presentation

console = Console()

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

presentations = []

def load_presentation():
    source_type = questionary.select(
        "Load a presentation from:",
        choices=["File", "URL"]
    ).ask()

    if source_type == "File":
        file_path = questionary.path("Select a PPTX file:").ask()
        if not file_path.endswith(".pptx"):
            print("❌ Invalid file format. Only .pptx files are supported.")
            return
        presentations.append(Presentation(file=file_path))

    elif source_type == "URL":
        url = questionary.text("Enter the URL to the PPTX file:").ask()
        presentations.append(Presentation(url=url))

    print("✅ Presentation loaded successfully!")

def list_presentations():
    if not presentations:
        print("No presentations loaded yet.")
        return
    print("\nLoaded Presentations:")
    for idx, pres in enumerate(presentations, 1):
        print(f"{idx}. {pres.file_path}")

def save_presentation_json():
    list_presentations()
    choice = questionary.select("Select a presentation to save:", choices=[str(i+1) for i in range(len(presentations))]).ask()
    pres = presentations[int(choice) - 1]
    output_file = questionary.text("Enter output file name:", default="output.json").ask()
    pres.save_json(output_file)

def show_presentation():
    list_presentations()
    if not presentations:
        return

    # Select a presentation to view
    choice = questionary.select(
        "Select a presentation to view:",
        choices=[f"{idx + 1}. {pres.file_path}" for idx, pres in enumerate(presentations)]
    ).ask()
    pres = presentations[int(choice.split(".")[0]) - 1]

    slides = pres.get_slides()
    slide_choices = [f"Slide {slide['slide_number']}" for slide in slides]

    while True:
        selected_slide = questionary.select("Choose a slide to view:", choices=slide_choices).ask()
        slide_number = int(selected_slide.split(" ")[1])
        slide = slides[slide_number - 1]

        console.print(f"\n📊 [bold cyan]Slide {slide_number}:[/bold cyan]")
        for shape in slide["shapes"]:
            print(f" - Shape Name: '{shape['name']}' | Content: '{shape['content']}'")

        cont = questionary.confirm("Do you want to view another slide?").ask()
        if not cont:
            break

def edit_presentation():
    list_presentations()
    choice = questionary.select("Select a presentation to edit:", choices=[str(i+1) for i in range(len(presentations))]).ask()
    pres = presentations[int(choice) - 1]

    edits = {"replacements": []}

    while True:
        slides = pres.get_slides()
        slide_choices = [f"Slide {slide['slide_number']}" for slide in slides]
        selected_slide = questionary.select("Choose a slide to edit:", choices=slide_choices).ask()
        slide_number = int(selected_slide.split(" ")[1])

        slide = slides[slide_number - 1]
        shape_names = [shape["name"] + " (" + shape["content"][:10] + ")" for shape in slide["shapes"]]
        shape_names_dict = {shape["name"] + " (" + shape["content"][:10] + ")": shape["name"] for shape in slide["shapes"]}

        shape_name = questionary.select("Choose a shape to modify:", choices=shape_names).ask()
        new_content = questionary.text(f"Enter new content for '{shape_name}':").ask()

        edits["replacements"].append({
            "shape_name": shape_names_dict[shape_name],
            "content": new_content
        })

        cont = questionary.confirm("Edit more shapes?").ask()
        if not cont:
            break

    try:
        new_presentation = Presentation.edit_presentation(pres.file_path, edits)
        presentations.append(new_presentation)
        print("✅ New presentation added successfully!")
    except Exception as e:
        print(e)

def main():
    while True:
        console.print("[bold cyan]Presentation Manager CLI[/bold cyan]\n")

        action = questionary.select(
            "Choose an action:",
            choices=[
                "Load a presentation",
                "List loaded presentations",
                "Show a presentation (slides and shapes)",
                "Save presentation JSON",
                "Edit a presentation",
                "Exit"
            ]
        ).ask()
        clear_screen()
        if action == "Load a presentation":
            load_presentation()
        elif action == "List loaded presentations":
            list_presentations()
        elif action == "Show a presentation (slides and shapes)":
            show_presentation()
        elif action == "Save presentation JSON":
            save_presentation_json()
        elif action == "Edit a presentation":
            edit_presentation()
        elif action == "Exit":
            console.print("\n👋 [green]Goodbye![/green]")
            break

if __name__ == "__main__":
    main()
