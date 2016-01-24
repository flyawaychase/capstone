import time, threading
import cv2, sys, os

#cascPath = sys.argv[1]


def facecap():
    faceCascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
    video_capture = cv2.VideoCapture(0)
    ret, frame = video_capture.read()

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    faces = faceCascade.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=10,
        minSize=(30, 30),
       # flags=cv2.cv.CV_HAAR_SCALE_IMAGE
    )
    n = time.ctime();
    n = n.replace(' ','_')
    n = n.replace(':','')

    for i, (x,y,w,h) in enumerate(faces):
        face = frame[y:y+h,x:x+w]
        cv2.imwrite(os.path.join('facedata', n+"-"+str(i)+  ".jpg"), face)

    # Draw a rectangle around the faces
    #for (x, y, w, h) in faces:
    #    cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)

    # Display the resulting frame
    #cv2.imshow('Video', frame)
    threading.Timer(5, facecap).start()

facecap()