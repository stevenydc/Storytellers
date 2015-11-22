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
df.fillna(0)
df = df.replace(to_replace = "*", value = 0)


# Destination/Origin combinations

Des_Ori = pd.Series(df["Destination"] + "," + df["Origin"])
# Des_Ori_pair = np.array([row.split(",") for row in Des_Ori.unique()])
Des_Ori_pair = pd.DataFrame([row.split(",") for row in Des_Ori.unique()])
Des_Ori_pair.drop(2, axis=1, inplace=True)
Des_Ori_pair.columns = ["Destination", "Origin"]




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
Total refugee from a country over 2000-2013 (inclusive) time frame
'''
Total_rfg = []

# country = "Syrian Arab Republic"
country = "Iraq"

for year in range(2000,2014):
    Total_rfg.append(sum(df[df["Origin"] == country][year].astype(int)))
P.ylabel("Number of Refugees")
P.xlabel("years")
P.title(country)

# P.axis([2000, 2013,0, 1000000 ])
P.plot(Total_rfg)

'''
END
'''




'''
Total Refugee Data
'''
# Creating Destination Origin pairs



year = 2013
output = []
# Destination = "Afghanistan"
Target_Origin = "Iraq"

# Need to limit the country origins
myPairs = Des_Ori_pair[Des_Ori_pair["Origin"] == Target_Origin]



for idx, entry in myPairs.iterrows():
    Destination = entry["Destination"]
    Origin = entry["Origin"]
    total = sum(df[(df["Destination"] == Destination) & (df["Origin"] == Origin)][year].astype(int))
    if (total <= 10):
        continue
    else:
        output.append([Destination, Origin, total])



# test = pd.DataFrame(output, columns=["Destination", "Origin", "Count"])

test = pd.DataFrame(output, columns=["creditor", "debtor", "amount"])
test["risk"] = np.zeros(test.shape[0])
test.to_csv("Refugee_Data.csv", index=False)