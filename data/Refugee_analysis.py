__author__ = 'stevenydc'

import pandas as pd
import numpy as np
import pylab as P



df = pd.read_csv("psq-tms.csv")
df["Population type"].unique()

trial1 = (df["Population type"] == "Asylum seekers")

trial2 = (df["Population type"] == "Refugees")

# sum(trial1|trial2)


df = df[trial1|trial2]

df.columns = ["Destination", "Origin", "Type", 2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013]
df.index = range(len(df))

# Destination/Origin combinations
Des_Ori = pd.Series(df["Destination"] + "," + df["Origin"])
df = df.replace(to_replace = "*", value = 0)



'''
Refugee data from specific origin to specific destination
'''
sub_df = []
for x in range(2000,2014):
    val = df.loc[0][x]
    if (val != val): val = 0
    sub_df.append([x, val])

sub_df = pd.DataFrame(sub_df, columns=["Date", "count"])
P.plot(sub_df["Date"], sub_df["count"])
'''
END
'''


'''
'''
Total_rfg = []
country = "Syrian Arab Republic"
for year in range(2000,2014):
    Total_rfg.append(sum(df[df["Origin"] == country][year].astype(int)))
'''
'''

