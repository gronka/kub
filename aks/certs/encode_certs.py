#!/usr/bin/env python

import base64
from typing import List

output: List[str] = []

with open("ca-bundle.crt", "r") as fil:
    collecting_cert = False
    current_cert = ""
    previous_line = ""
    comment = ""
    counter = 1

    for line in fil:
        if "BEGIN CERT" in line:
            collecting_cert = True
            comment = previous_line[:-1]

        if collecting_cert:
            current_cert += line

        if "END CERT" in line:
            collecting_cert = False
            encoded = base64.b64encode(bytes(current_cert, "utf-8"))
            output.append(f"  {comment}")
            output.append(f"  ca{counter}.crt: |")
            output.append(f"    {encoded.decode('ascii')}")

            current_cert = ""
            counter += 1

        previous_line = line


print(base64.b64decode(output[2]))
with open("encoded.crt", "+w") as output_file:
    output_file.write("\n".join(output))
