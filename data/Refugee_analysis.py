__author__ = 'stevenydc'

import pandas as pd


df = pd.read_csv("psq-tms.csv")
df["Population type"].unique()
df[(df["Population type"] == "Asylum seekers")]




