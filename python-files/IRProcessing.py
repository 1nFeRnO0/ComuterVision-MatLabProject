import gpiod
from gpiod.line import Direction, Value
from constant_lines import CHIP_NAME, RECIEVER_LINE, LED_LINE, RECIEVER_DELAY
from time import sleep

def send_signal():
    line = gpiod.request_lines(
                CHIP_NAME,
                consumer='LED_LINE-test',
                config={
                        LED_LINE: gpiod.LineSettings(
                                direction=Direction.OUTPUT, output_value=Value.ACTIVE
                            ),
                    }
                )
    line.set_value(LED_LINE, Value.ACTIVE)
    return line
            
def get_signal():
    with gpiod.request_lines(
                CHIP_NAME,
                consumer='RECIEVER_LINE-test',
                config={
                        RECIEVER_LINE: gpiod.LineSettings(
                                direction=Direction.INPUT
                            ),
                    }
                ) as request:
        sleep(RECIEVER_DELAY)
        val = request.get_value(RECIEVER_LINE)
        return 1 if val == Value.ACTIVE else 0
