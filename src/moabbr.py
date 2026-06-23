import json
import subprocess

import pandas as pd

IMAGE = "moabbr"


def nma(df: pd.DataFrame) -> dict:
    proc = subprocess.run(
        ["docker", "run", "--rm", "-i", IMAGE, "nma"],
        input=df.to_csv(index=False).encode(),
        capture_output=True,
        check=True,
    )
    return json.loads(proc.stdout)


def bnma(df: pd.DataFrame) -> dict:
    proc = subprocess.run(
        ["docker", "run", "--rm", "-i", IMAGE, "bnma"],
        input=df.to_csv(index=False).encode(),
        capture_output=True,
        check=True,
    )
    return json.loads(proc.stdout)
