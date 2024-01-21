import serial
import time
import threading
import serial.tools.list_ports
import random

class PlasmoTronDriver:
    def __init__(self, port, baudrate=57600):

        ports_available = serial.tools.list_ports.comports()
        print( [port.device for port in ports_available])


    
        self.serial = serial.Serial(port, baudrate, timeout=1)
       


        self.read_thread = threading.Thread(target=self.read_from_port)
        self.read_thread.daemon = True
        self.keep_reading = True
        time.sleep(2)  # wait for the Serial connection to initialize

    def start_reading(self):
        self.read_thread.start()

    def read_from_port(self):
        while self.keep_reading:
            if self.serial.in_waiting:
                line = self.serial.readline().decode().strip()
                if line:
                    print(line)  # Or handle it as you see fit

    def send_command(self, command):
        full_command = f"{command}\n"
        self.serial.write(full_command.encode())
        time.sleep(0.1)  # wait for command to be processed

    def move_x(self, value):
        self.send_command(f"X:{value}")

    def home_x(self):
        self.send_command("homeX")

    def move_y(self, value):
        self.send_command(f"Y:{value}")

    def home_y(self):
        self.send_command("homeY")

    def move_door(self, value):
        self.send_command(f"door:{value}")

    def grab(self, plate_position):
        self.send_command(f"grab:{plate_position}")

    def drop(self, plate_position):
        self.send_command(f"drop:{plate_position}")

    def close_door(self):
        self.send_command("close")

    def open_door(self):
        self.send_command("open")

    def gas_pulse(self, value):
        self.send_command(f"gas:{value}")

    def fan_off(self):
        self.send_command("fanoff")

    def fan_on(self):
        self.send_command("fanon")

    def set_temperature(self, value):
        self.send_command(f"temperature:{value}")

    def shuffle(self, empty_pos):
        self.send_command(f"shuffle:{empty_pos}")

    def close(self):
        self.keep_reading = False
        self.read_thread.join()
        self.serial.close()


if __name__ == "__main__":
    driver = PlasmoTronDriver("/dev/cu.usbserial-10")
    
    time.sleep(5)  # sleep 30 seconds to allow the Arduino to initialize
    driver.shuffle(0)
    while True:
        time.sleep(20)
    # driver.start_reading()
    # vacant_pos = 0
    # while True:
    #     time.sleep(20)
    #     min_pos = 0
    #     max_pos = 7
    #     temp_pos = random.randint(min_pos, max_pos)
    #     while temp_pos == vacant_pos:
    #         temp_pos = random.randint(min_pos, max_pos)
    #     driver.grab()
        
