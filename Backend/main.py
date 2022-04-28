from time import sleep

def foto():
    from picamera import PiCamera
    camera = PiCamera()
    camera.resolution = (1024, 768)
    camera.start_preview()
    # Camera warm-up time
    sleep(2)
    camera.capture('foo.jpg')

def test():
    test = "var test"
    print("print test")
    return test
    
test()