SEARCH_LEN = 15

# def search_for(buff: str, starting_point: int):
#     searching_buff = buff[0:starting_point]
#     looking_length = len(buff) - len(searching_buff)
#     while True:
#

# def longest_repeatition(long: str, short: str):
#     best_match = -1
#     i = 1
#     while True:
#         found = long.rfind(short[0:i]) # Takes from 0 to i-1
#         if found == -1:
#             return best_match
#         else:
#             best_match = found

class LZCompress:
    def __init__(self, data):
        self.current = 0
        self.data :str = data
        self.decompressed = ""
        self.compressed = []
    # Helpers functions
    def get_searching_window(self):
        window_start = 0 if self.current < SEARCH_LEN else self.current - SEARCH_LEN
        window_end = self.current - 1
        return self.data[window_start:window_end]
    # Main functions
    def compress(self):
        while self.current <= len(self.data):
            if self.current == 0:
                self.compressed.append((0, 0, self.data[0]))
                self.current += 1
            else:
                searching_window = self.get_searching_window()
                sub_length = 1
                last_tag = (0, 0, self.data[self.current])
                while True:
                    sub_item = self.data[self.current: self.current+sub_length]
                    found_i = self.data.rfind(sub_item)
                    if found_i <= -1:
                        self.compressed.append(last_tag)
                        self.current += 1
                        break
                    else:
                        d = self.current - found_i
                        l = sub_length
                        try:
                            a = self.data[found_i+sub_length]
                        except:
                            a = ""
                        last_tag = (d, l, a)
                        sub_length += 1
        return self.compressed

data = "ABAABABAABBBBBBBA" # A B AA BAB AABB BBBBBA
compresser = LZCompress(data)
compresser.compress()
