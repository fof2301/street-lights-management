# Simple HTTP Server Example
# Control an LED and read a Button using a web browser

import time
import network
import socket
from machine import Pin
import time

ldr= machine.ADC(27)
led_1 = Pin(13, Pin.OUT)
led_2 = Pin(12, Pin.OUT)
led_3 = Pin(11, Pin.OUT)
led_1_State = 'LED State Unknown'
led_2_State = 'LED State Unknown'
led_3_State = 'LED State Unknown'


auto = False

ssid = 'Fof'
password = '12345678'

wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect(ssid, password)

html = """<!DOCTYPE html>
<html>
<head> <title>Pico W</title> </head>
<body>
<p>%s</p>
</body>
</html>
"""

# Wait for connect or fail
max_wait = 10
while max_wait > 0:
    if wlan.status() < 0 or wlan.status() >= 3:
        break
    max_wait -= 1
    print('waiting for connection...')
    time.sleep(1)
    
# Handle connection error
if wlan.status() != 3:
    raise RuntimeError('network connection failed')
else:
    print('Connected')
    status = wlan.ifconfig()
    print( 'ip = ' + status[0] )
    
    
# Open socket
addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]
s = socket.socket()
s.bind(addr)
s.listen(1)
print('listening on', addr)

# Listen for connections, serve client
while True:
    try:       
        cl, addr = s.accept()
        print('client connected from', addr)
        request = cl.recv(1024)
        print("request:")
        print(request)
        request = str(request)
        l1_off = request.find('l1off')
        l1_mid = request.find('l1mid')
        l1_hi= request.find('l1hi')
        
        if l1_off == 8:
            print("led on")
            led_1.value(0)
            led_2.value(0)
            led_3.value(0)
        if l1_mid == 8:
            print("led off")
            led_2.value(0)
            led_1.value(1)
            led_3.value(0)
        if l1_hi == 8:
            print("led on")
            led_3.value(1)
            led_2.value(1)
            led_1.value(1)
        
        led_1_State = "0" if led_1.value() == 0 else "1" # a compact if-else statement
        led_2_State = "0" if led_2.value() == 0 else "1" # a compact if-else statement
        led_3_State = "0" if led_3.value() == 0 else "1" # a compact if-else statement
        
        if(ldr.read_u16())<600:
            ldr_state='low'        
        if(ldr.read_u16()>900):
            ldr_state='mid'
       
        if(ldr.read_u16()>1400):
            ldr_state='hi'
        print(ldr.read_u16())
        
        # Create and send response
        stateis = led_1_State + led_2_State + led_3_State + "," + ldr_state
        response = html % stateis
        cl.send('HTTP/1.0 200 OK\r\nContent-type: text/html\r\n\r\n')
        cl.send(response)
        cl.close()
        
    except OSError as e:
        cl.close()
        print('connection closed')