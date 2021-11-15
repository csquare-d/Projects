# -*- coding: utf-8 -*-
"""
Created on Mon Apr  5 13:21:15 2021

@author: csqua
"""

"""
Basic analysis of COVID-19 data

"""

#%%

# imports

import pandas as pd


#%% read in data

county = pd.read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')
state = pd.read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv')

# get column information
state.info()


#%% data cleaning

# convert dates
state['date'] = pd.to_datetime(state['date'])
# get column information
state.info()

#%% basic data exploration

# see number of rows
print(state.count())



#%% summary statistics
state.describe(include='all')

#%% aggregate

# get total daily cases in the US

# important note for aggregation: How do you need your data to look?
# check out https://pandas.pydata.org/pandas-docs/stable/user_guide/groupby.html

daily = state.groupby('date').sum()

daily.tail()

#%% plot chart

# see https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.plot.html

#linear
daily['cases'].plot.line()

# log scale (good for visualizing exponentail growth)
daily['cases'].plot.line(logy=True, legend=True)

#%% today's lab

# plot in a single chart (with log scale) total cases and total deaths.

daily[['cases','deaths']].plot.line(logy=True, legend=True, title='Deaths and Total Cases Over Time')

