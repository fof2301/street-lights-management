from machine import Pin
import time

import umail
import network

# Your network credentials
ssid = 'meraWifi' # Replace with the name of your network
password = 'ychvv9aq0t' # Replace with your network password

# Email details
sender_email = 'psprime2002@gmail.com' # Replace with the email address of the sender
sender_name = 'Priyanshu' # Replace with the name of the sender
sender_app_password = 'tjtauaedzpikjtfk' # Replace with the app password of the sender's email account
recipient_email ='srivastavapriyanshu014@gmail.com' # Replace with the email address of the recipient
email_subject ='Faulty Street light' # Subject of the email

def connect_wifi(ssid, password):
  # Connect to your network using the provided credentials
  station = network.WLAN(network.STA_IF)
  station.active(True)
  station.connect(ssid, password)
  # Wait for the connection to be established
  while station.isconnected() == False:
    pass
  print('Connection successful') # Print a message if the connection is successful
  print(station.ifconfig()) # Print the network configuration
    
# Connect to your network
connect_wifi(ssid, password)

led = Pin(11,Pin.OUT)
led_h = machine.ADC(26)

led.value(1)
em=0
while True:
    print(led_h.read_u16())
    if(led.value()==1 and led_h.read_u16()==65535 and em==0):
        print("LED is NOT working. Maintainance Required")
        # Send the email
# Connect to the Gmail's SSL port
        smtp = umail.SMTP('smtp.gmail.com', 465, ssl=True)
# Login to the email account using the app password
        smtp.login(sender_email, sender_app_password)
# Specify the recipient email address
        smtp.to(recipient_email)
# Write the email header
        smtp.write("From:" + sender_name + "<"+ sender_email+">\n")
        smtp.write("Subject:" + email_subject + "\n")
# Write the body of the email
        smtp.write("Maintainance required on light number 3 of street light 1")
# Send the email
        smtp.send()
        print("Email sent for repair.")
        em=1
        time.sleep(1)
    if(led.value()==1 and led_h.read_u16()>20000 and led_h.read_u16()!=65535):
        print("LED is ON. Working Fine.")
    if(led.value()==0 and led_h.read_u16()<1000):
        print("LED is OFF.Working Fine")
    time.sleep(2)
