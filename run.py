

from amacro.Device import Device
from amacro.Settings import Settings
from amacro.OCR import OCR

from amacro.printing import myPrint

settings = Settings()
settings.ANDROID_SDK_PATH = '/home/me/Apps/android-sdk-linux'

device = Device(settings)

# device.adbDevices()
device.setActive('192.168.100.10:5555')


ocr = OCR(settings)

# ocr.train(fontfile="eng.Supercell-Magic.exp0.ttf", method="tesseract", training_text="/home/me/clash/coc_training_text.txt")

device.takeScreenshot("test.png")


myPrint("hello")