#!/usr/bin/env python
# coding: utf-8
"""
Created on coursework export (Activity 09)

Fetch OpenWeatherMap forecast for Rome, build a DataFrame, optionally append to MySQL.

@author josea
@author José Alberto Rocha Munguía
"""

import requests
import pandas as pd
import numpy as np
from keys import *

city = "Rome"
country = "IT"
response = requests.get(
    f"http://api.openweathermap.org/data/2.5/forecast/"
    f"?q={city},{country}&appid={OWM_key}&units=metric&lang=en"
)
response.raise_for_status()

# Convert API payload to a Python dict
data = response.json()
print(data)

forecast_list = data.get("list", [])

times = []
temperatures = []
humidities = []
weather_statuses = []
wind_speeds = []
rain_volumes = []
snow_volumes = []

for entry in forecast_list:
    times.append(entry.get("dt_txt", np.nan))
    temperatures.append(entry.get("main", {}).get("temp", np.nan))
    humidities.append(entry.get("main", {}).get("humidity", np.nan))
    weather_statuses.append(entry.get("weather", [{}])[0].get("main", np.nan))
    wind_speeds.append(entry.get("wind", {}).get("speed", np.nan))
    rain_volumes.append(entry.get("rain", {}).get("3h", np.nan))
    snow_volumes.append(entry.get("snow", {}).get("3h", np.nan))

df = pd.DataFrame({
    "time": times,
    "temperature": temperatures,
    "humidity": humidities,
    "weather_status": weather_statuses,
    "wind_speed": wind_speeds,
    "rain_volume_3h": rain_volumes,
    "snow_volume_3h": snow_volumes,
    "municipality_iso_country": "Rome,IT",
})

print(df.head())

# Optional: load into local MySQL (requires db_config.py + running server)
try:
    import sqlalchemy
    from db_config import schema, host, user, password, port

    # Align column names with weather_data table where possible
    db_df = df.rename(columns={
        "time": "weather_datetime",
        "wind_speed": "wind",
        "rain_volume_3h": "rain_qty",
        "snow_volume_3h": "snow",
    })
    # Table expects weather_status / temperature / humidity / municipality_iso_country
    db_df = db_df[[
        "weather_datetime", "temperature", "humidity", "weather_status",
        "wind", "rain_qty", "snow", "municipality_iso_country",
    ]]

    con = f"mysql+pymysql://{user}:{password}@{host}:{port}/{schema}"
    db_df.to_sql("weather_data", if_exists="append", con=con, index=False)
    print("Rows appended to weather_data.")
except ImportError:
    print("sqlalchemy/pymysql not installed — DataFrame ready, skipped DB load.")
except Exception as exc:
    print("DB load skipped:", exc)
