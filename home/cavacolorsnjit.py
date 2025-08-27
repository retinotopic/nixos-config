import os
import subprocess
import tempfile
import signal
import sys
import numpy as np
from numba import njit

BARS_NUMBER = int(os.getenv("BARS_NUMBER", "12"))
OUTPUT_BIT_FORMAT = "16bit"
RAW_TARGET = "/dev/stdout"
SENSITIVITY = int(os.getenv("SENSITIVITY", "150"))

CONFIG_TPL = """
[general]
bars = {bars}
sensitivity = {sens}
[output]
method = raw
raw_target = {target}
bit_format = {fmt}
"""

SYMBOLS = ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]
COLORS  = ["d3c6aa","7fbbb3","d699b6","e67e80","e69875","dbbc7f","a7c080","83c092"]

_SPANS_BYTES = [f"<span foreground='#{COLORS[i]}'>{SYMBOLS[i]}</span>".encode("utf-8") for i in range(8)]
_SPAN_LEN = len(_SPANS_BYTES[0])
_SPANS_2D = np.empty((8, _SPAN_LEN), dtype=np.uint8)
for i, b in enumerate(_SPANS_BYTES):
    _SPANS_2D[i, :] = np.frombuffer(b, dtype=np.uint8)

_PREFIX = b'{"text":"'
_SUFFIX = b'"}\n'

@njit(fastmath=True)
def render_frame_inplace(values, denom, spans, span_len, out_buf):
    n = values.size
    pos = 0
    for i in range(n):
        v = int(values[i])
        t = (v << 3) // denom
        if t > 7:
            t = 7
        for k in range(span_len):
            out_buf[pos + k] = spans[t, k]
        pos += span_len

def main():
    config = CONFIG_TPL.format(
        bars=BARS_NUMBER,
        sens=SENSITIVITY,
        target=RAW_TARGET,
        fmt=OUTPUT_BIT_FORMAT,
    )

    if OUTPUT_BIT_FORMAT == "16bit":
        dtype = np.uint16
        bytenorm = 65535
    else:
        dtype = np.uint8
        bytenorm = 255

    itemsize = np.dtype(dtype).itemsize
    chunk = itemsize * BARS_NUMBER
    denom = bytenorm + 1

    with tempfile.NamedTemporaryFile() as cfg:
        cfg.write(config.encode())
        cfg.flush()

        proc = subprocess.Popen(["cava", "-p", cfg.name], stdout=subprocess.PIPE)

        def _cleanup(signum=None, frame=None):
            try:
                proc.terminate()
            except Exception:
                pass
            sys.exit(0)

        signal.signal(signal.SIGINT, _cleanup)
        signal.signal(signal.SIGTERM, _cleanup)

        src = proc.stdout
        fd_out = sys.stdout.fileno()

        in_buf = bytearray(chunk)
        values = np.frombuffer(in_buf, dtype=dtype, count=BARS_NUMBER)

        frame_len = BARS_NUMBER * _SPAN_LEN
        frame = np.empty(frame_len, dtype=np.uint8)
        mv_frame = memoryview(frame)

        writev = os.writev

        while True:
            # proc.stdout.raw.readinto
            nread = src.readinto(in_buf)
            if not nread or nread < chunk:
                break

            render_frame_inplace(values, denom, _SPANS_2D, _SPAN_LEN, frame)

            writev(fd_out, (_PREFIX, mv_frame, _SUFFIX))

if __name__ == "__main__":
    main()
