import streamlit as st
import duckdb
import pandas as pd

conn = duckdb.connect('../airbnb_project/airbnb.duckdb')

st.title("Airbnb Analytics Platform")

option = st.selectbox("Filtrer par type de nuit", ["Toutes", "full moon", "not full moon"])

if option == "Toutes":
    df = conn.execute("SELECT * FROM full_moon_reviews").df()
else:
    df = conn.execute(f"SELECT * FROM full_moon_reviews WHERE is_full_moon = '{option}'").df()

st.subheader("Distribution des sentiments")
sentiment_df = df.groupby("sentiment").size().reset_index(name="count")
st.bar_chart(sentiment_df.set_index("sentiment"))

st.subheader("Données")
st.dataframe(df, use_container_width=True)