import time

def get_time() -> str:

    """
    Return the current time for your locale.
    """

    unfiltered_time = time.localtime()
    current_time = time.strftime("%H:%M:%S" , unfiltered_time)
    return current_time