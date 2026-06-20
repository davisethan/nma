from os import getenv
from pathlib import Path

import duckdb
import pandas as pd
from dotenv import load_dotenv

load_dotenv()
data_path = Path(getenv("DATA_PATH"))

results = pd.read_csv(data_path / "results.csv")
query = (Path(__file__).parent / "query.sql").read_text()
df = duckdb.sql(query).df()
df.to_csv(data_path / "analysis.csv", index=False)
