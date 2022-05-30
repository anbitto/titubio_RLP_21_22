import RPi.GPIO as GPIO
# import the library
from RpiMotorLib import RpiMotorLib
    
def moveNema(cm, clockwise=False):
    cms_vuelta = 3,77
    steps_vuelta = 200

    #define GPIO pins
    GPIO_pins = (14, 15, 18) # Microstep Resolution MS1-MS3 -> GPIO Pin
    direction= 20       # Direction -> GPIO Pin
    step = 21      # Step -> GPIO Pin

    # Declare an named instance of class pass GPIO pins numbers
    mymotortest = RpiMotorLib.A4988Nema(direction, step, GPIO_pins, "A4988")

    #cm's a steps
    total_steps = (cm * steps_vuelta) / cms_vuelta

    # call the function, pass the arguments
    mymotortest.motor_go(clockwise, "Full", total_steps, .01, False, .05)

    # good practise to cleanup GPIO at some point before exit
    GPIO.cleanup()

moveNema(3,77)

def moveSpace():
    cms_vuelta = 3,77
    steps_vuelta = 200
    total_steps = (0.5 * steps_vuelta) / cms_vuelta

moveSpace()