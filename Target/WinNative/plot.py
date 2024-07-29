import pandas as pd
import matplotlib.pyplot as plt
import sys
import os
import shutil


plots = [
    ("GCAS", "gcas.svg", ["GCAS"]),
    ("Heading", "heading.svg", ["NAV_heading", "AFDS_heading", "Heading"]),
    ("Altitude", "altitude.svg", ["NAV_altitude", "Altitude"]),
    ("Elevation", "elevation.svg", ["TMAP_elevation"]),
    ("Velocity", "velocity.svg", ["NAV_hspeed", "Hspeed", "Airspeed"]),
    ("Position", "position.svg", ["Latitude", "Longitude"]),
    ("Verspeed", "verspeed.svg", ["Target_Vspeed", "Vspeed"]),
    ("Roll", "roll.svg", ["Target_roll", "Roll"]),
    ("Pitch", "pitch.svg", ["Target_pitch", "Pitch"]),
    ("Aileron", "aileron.svg", ["Target_aileron","Aileron"]),
    ("Elevator", "elevator.svg", ["Target_elevator","Elevator"]),
    ("Rudder", "rudder.svg", ["Target_rudder","Rudder"]),
    ("Throttles", "throttles.svg", ["Throttle1", "Throttle2"]),
    ("NAV_Distance", "distance.svg", ["NAV_distance"]),
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


def plot3D(filename, data, columns, mode):
    for col in columns:
        if not col in data.columns:
            print (f"Error: Unknown column '{col}'")
            sys.exit(1)

    # Plot the data
    fig = plt.figure(figsize=(20, 20))
    ax = fig.add_subplot(111, projection = '3d')
    if mode == 1:
        ax.view_init(elev=30, azim=-60, roll=0)
    else:
        ax.view_init(elev=15, azim=60, roll=0)
    ax.plot(data[columns[0]],data[columns[1]],data[columns[2]])

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

    print(f"{filename} -> 3Da")
    plot3D(f"{directory}/3Da.svg", data, ["Latitude", "Longitude", "Altitude"], 0)
    f1.write(f"<img src='3Da.svg'/>\n")
    f2.write(f"![](3Db.svg)\n")

    print(f"{filename} -> 3Db")
    plot3D(f"{directory}/3Db.svg", data, ["Latitude", "Longitude", "Altitude"], 1)
    f1.write(f"<img src='3Db.svg'/>\n")
    f2.write(f"![](3Db.svg)\n")


    f1.write("</body></html>\n")
    f1.close()
    f2.close()





sys.argv.pop(0)
for filename in sys.argv:
    plot_CSV(filename)
