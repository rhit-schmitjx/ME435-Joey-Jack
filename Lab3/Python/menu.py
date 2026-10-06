import plateLoader

def main():
    print("Serial Menu")
    # loader = plateLoader.PlateLoader("/dev/ttyUSB0")
    loader = plateLoader.PlateLoader()
    loader.connect()
    print("0. Exit")
    print("1. RESET")
    print("2. X-AXIS")
    print("3. GRIPPER")
    print("4. Z-AXIS")
    print("5. MOVE")
    print("6. Status")
    while True:
        selection = int(input("Selection: "))
        if selection == 0:
            break
        elif selection == 1:
            response = loader.send_command("RESET")
            print(response)
        elif selection == 2:
            num = int(input("Location: "))
            loader.send_command("X-AXIS" + " "+ str(num))
        elif selection == 3:
            print("1. Open")
            print("2. Close")
            selection1 = int(input("Selection: "))
            if selection1 == 1:
                loader.send_command("GRIPPER OPEN")
            elif selection1 == 2:
                loader.send_command("GRIPPER CLOSE")
        elif selection == 4:
            loader.send_command("Z-AXIS")
        elif selection == 5:
            loader.send_command("MOVE")
        elif selection == 6:
            loader.send_command("LOADER_STATUS")
        else:
            print("Invalid selection")
main()