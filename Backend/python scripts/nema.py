import RPi.GPIO as GPIO
from RpiMotorLib import RpiMotorLib
    
def moveNema(cm, clockwise=False):
    cms_vuelta = 3,77
    steps_vuelta = 200
    # Cm's a steps
    total_steps = (cm * steps_vuelta) / cms_vuelta

    # Define GPIO pins
    GPIO_pins = (21, 21, 21) # Microstep Resolution MS1-MS3 -> GPIO Pin
    direction = 5       # Direction -> GPIO Pin
    step = 6      # Step -> GPIO Pin

    # Declare an named instance of class pass GPIO pins numbers
    mymotortest = RpiMotorLib.A4988Nema(direction, step, GPIO_pins, "A4988")

    # call the function, pass the arguments
    mymotortest.motor_go(clockwise, "Full", total_steps, .001, False, .05)

    # good practise to cleanup GPIO at some point before exit
    GPIO.cleanup()

