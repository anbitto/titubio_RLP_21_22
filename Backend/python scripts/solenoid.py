import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)  # GPIO Numbers instead of board numbers

RELAIS_1_GPIO = 17
GPIO.setup(RELAIS_1_GPIO, GPIO.OUT)  # GPIO Assign mode


def solenoid_low():
    GPIO.output(RELAIS_1_GPIO, GPIO.LOW)  # out
    GPIO.cleanup()


def solenoid_high():
    GPIO.output(RELAIS_1_GPIO, GPIO.HIGH)  # on
    GPIO.cleanup()

