# import RPi.GPIO as GPIO
import math


# import the library
# from RpiMotorLib import RpiMotorLib

def moveStepper(cm, clockwise=False):
    cms_vuelta = 3.77
    steps_vuelta = 4096

    GpioPins = [18, 23, 24, 25]

    # Declare an named instance of class pass a name and motor type
    mymotortest = RpiMotorLib.BYJMotor("MyMotorOne", "28BYJ")

    total_steps = (cm * steps_vuelta) / cms_vuelta

    # call the function pass the parameters
    mymotortest.motor_run(GpioPins, .005, total_steps, clockwise, False, "full", .05)

    # good practise to cleanup GPIO at some point before exit
    GPIO.cleanup()


# moveStepper(7)


def movePagina():
    cms_hoja = 27.5
    cms_vuelta = 3.77
    steps_vuelta = 4096
    cms_letra_espacio = 2

    total_steps = math.ceil((cms_letra_espacio * steps_vuelta) / cms_vuelta)
    print(total_steps)
    total_vueltas = cms_hoja / cms_vuelta
    total_lineas = math.floor(cms_hoja / cms_letra_espacio)
    print(total_lineas)


movePagina()
