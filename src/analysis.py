from os import getenv
from pathlib import Path

import duckdb
import pandas as pd
from dotenv import load_dotenv

load_dotenv()
data_path = Path(getenv("DATA_PATH"))

results = pd.read_csv(data_path / "results.csv")
netmeta = (Path(__file__).parent / "netmeta.sql").read_text()
gemtc = (Path(__file__).parent / "gemtc.sql").read_text()

duckdb.sql(netmeta).df().to_csv(data_path / "netmeta.csv", index=False)
duckdb.sql(gemtc).df().to_csv(data_path / "gemtc.csv", index=False)
