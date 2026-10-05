# 📊 Big Data (4th semester)

Coursework from **Fundamentos para Big Data** — weather & flights API collection plus a MySQL schema.

**Author:** José Alberto Rocha Munguía

## 📦 Contents

| Folder | Topic |
|---|---|
| `activity-06-weather-api/` | OpenWeatherMap forecast → pandas (`collect_weather_data.ipynb`) |
| `activity-07-flights-api/` | AeroDataBox arrivals for `LIRF` → DataFrame |
| `activity-09-weather-to-sql/` | Same weather pipeline + MySQL `gans` schema/load |

## 🔐 Secrets (local only)

API keys and DB passwords are **not** in this repository.

```bash
cd activity-06-weather-api
cp keys.example.py keys.py   # then paste your OWM key

cd ../activity-07-flights-api
cp keys.example.py keys.py   # OWM + RapidAPI flights key

cd ../activity-09-weather-to-sql
cp keys.example.py keys.py
cp db_config.example.py db_config.py
```

`keys.py` / `db_config.py` are gitignored.

> If these keys were ever pushed to a public repo before, **rotate them** on OpenWeatherMap / RapidAPI.

## ▶️ Run

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt

# Weather notebook / script
jupyter notebook activity-06-weather-api/collect_weather_data.ipynb
# or
cd activity-09-weather-to-sql && python collect_weather_data.py

# MySQL schema
mysql -u root -p < activity-09-weather-to-sql/tables.sql
mysql -u root -p < activity-09-weather-to-sql/insert.sql
```

## 📝 Notes

- Original Spanish comments kept where they helped; new docs/comments are in English.
- Activity 09 `insert.sql` uses correct `VALUES` and Rome lat/elevation ordering.
- Flight API has a low free-tier quota — avoid repeated calls.
