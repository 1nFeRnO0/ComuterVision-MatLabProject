# Synchronous grab
from vimba import *
from cv2 import imshow

Vimba.get_instance().set_network_discovery(True)

with Vimba.get_instance() as vimba:
    if vimba.GeVTLIsPresent.get():
        print('looking for cams')
        vimba.GeVDiscoveryAllDuration.set(250)
        vimba.GeVDiscoveryAllAuto.run()
    cams = vimba.get_all_cameras ()
    print(cams)
    with cams [0] as cam:
        # Aquire single frame synchronously
        frame = cam.get_frame ()

        # Aquire 10 frames synchronously
        for frame in cam.get_frame_generator(limit =10):
            imshow('Look', frame)
