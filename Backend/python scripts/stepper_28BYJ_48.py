import RPi.GPIO as GPIO
from RpiMotorLib import RpiMotorLib

SPACE_BETWEEN_LINES = 1

def move_next_line():
    cms_vuelta = 7
    steps_vuelta = 4096
    total_steps = (SPACE_BETWEEN_LINES * steps_vuelta) / cms_vuelta

    GpioPins = [27, 22, 23, 24]

    # Declare an named instance of class pass a name and motor type
    mymotortest = RpiMotorLib.BYJMotor("MyMotorOne", "28BYJ")

    # call the function pass the parameters
    mymotortest.motor_run(GpioPins, .005, total_steps, False, False, "full", .05)

    # good practise to cleanup GPIO at some point before exit
    GPIO.cleanup()
