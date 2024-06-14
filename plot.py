import pandas as pd
import matplotlib.pyplot as plt
import sys
import os
import shutil

#"NAV_heading, Heading, NAV_altitude, Altitude, NAV_velocity, Velocity, " &
#                "Latitude, Longitude, " & 
#                "Target_vertspeed, Vertspeed, Target_roll, Roll, Tartget_pitch, Pitch, " &
#                "Aileron, Elevator, Rudder, Throttle1, Throttle2"

plots = [
    ("Heading", "heading.svg", ["NAV_heading", "Heading"]),
    ("Altitude", "altitude.svg", ["NAV_altitude", "Altitude"]),
    ("Velocity", "velocity.svg", ["NAV_velocity", "Velocity"]),
    ("Position", "position.svg", ["Latitude", "Longitude"]),
    ("Verspeed", "verspeed.svg", ["Target_vertspeed", "Vertspeed"]),
    ("Roll", "roll.svg", ["Target_roll", "Roll"]),
    ("Pitch", "pitch.svg", ["Tartget_pitch", "Pitch"]),
    ("Aileron", "aileron.svg", ["Aileron"]),
    ("Elevator", "elevator.svg", ["Elevator"]),
    ("Rudder", "rudder.svg", ["Rudder"]),
    ("Throttles", "throttles.svg", ["Throttle1", "Throttle2"]),
]





def read_CSV(filename):
    # Read the CSV file into a DataFrame
    data = pd.read_csv(filename)
    return data


def plot(filename, data, columns):
    for col in columns:
        if not col in data.columns:
            print (f"Error: Unknown column '{col}'")
            sys.exit(1)

    # Plot the data
    plt.figure(figsize=(10, 5))
    title=""
    for col in columns:
        plt.plot(data[col], label=col)
        if title != "":
            title += ", "
        title = title + col
    plt.title(title)
    plt.legend()

    plt.savefig(filename, format='svg')
    plt.close()


def plot_CSV(filename):
    data = read_CSV(filename)
    directory = "result_" + (os.path.splitext(filename)[0])
    print(directory)
    try:
        shutil.rmtree(directory)
    except:
        pass
    os.makedirs(directory)

    f1 = open(f"{directory}/index.html", "w")
    f1.write(f"<h1>{filename}</h1>\n")

    f2 = open(f"{directory}/README.md", "w")
    f2.write(f"# {filename}\n")


    for (name, plotname, columns) in plots:
        print(f"{filename} -> {name}")
        plot(f"{directory}/{plotname}", data, columns)
        f1.write(f"<img src='{plotname}'/>\n")
        f2.write(f"![]({plotname})\n")

    f1.write("</body></html>\n")
    f1.close()
    f2.close()

sys.argv.pop(0)
for filename in sys.argv:
    plot_CSV(filename)
