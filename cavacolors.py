#!/usr/bin/env python3
import os
import struct
import subprocess
import tempfile
# import json
import signal
import sys

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

def main():
    config = CONFIG_TPL.format(
        bars=BARS_NUMBER,
        sens=SENSITIVITY,
        target=RAW_TARGET,
        fmt=OUTPUT_BIT_FORMAT,
    )
    bytetype, bytesize, bytenorm = ("H", 2, 65535) if OUTPUT_BIT_FORMAT == "16bit" else ("B", 1, 255)

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

        chunk = bytesize * BARS_NUMBER
        fmt = bytetype * BARS_NUMBER
        src = proc.stdout

        denom = bytenorm + 1
        while True:
            data = src.read(chunk)
            if len(data) < chunk:
                break
            values = struct.unpack(fmt, data)

            parts = []
            for v in values:
                idx = int(v * 8 / denom)
                if idx > 7:
                    idx = 7
                parts.append(f"<span foreground='#{COLORS[idx]}'>{SYMBOLS[idx]}</span>")
            
            text = "".join(parts)
            print(text, flush=True)
            # print(json.dumps({"text": text}), flush=True)

if __name__ == "__main__":
    main()
