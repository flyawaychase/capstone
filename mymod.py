import cv2
import sys
import os
import time

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
    
    return faces
    video_capture.release()
