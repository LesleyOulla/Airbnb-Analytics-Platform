# Airbnb Analytics Platform

Plateforme analytique pour l'analyse des données Airbnb, construite avec DuckDB, dbt et Streamlit.

---

## Présentation du projet

Ce projet met en place une architecture medallion (Bronze, Silver, Gold) pour analyser les logements, les hôtes, les avis clients et l'impact des nuits de pleine lune sur ces avis.

Les données sont transformées via dbt, stockées dans DuckDB et restituées via une application Streamlit.

---

## Architecture

```
dbt Project
  |
  |-- Bronze    : Ingestion brute des données CSV/JSON
  |-- Silver    : Nettoyage, typage, renommage
  |-- Gold      : Agrégations, vues métier, données produit
                        |
                   DuckDB (moteur analytique)
                        |
                   Streamlit (dashboard)
                        |
                 Utilisateurs métier
```

---

## Structure du projet

```
airbnb_project/
|-- models/
|   |-- bronze/
|   |   |-- bronze_hosts.sql
|   |   |-- bronze_listings.sql
|   |   |-- bronze_reviews.sql
|   |-- silver/
|   |   |-- silver_hosts.sql
|   |   |-- silver_listings.sql
|   |   |-- silver_reviews.sql
|   |   |-- schema.yml
|   |-- gold/
|       |-- dim_hosts.sql
|       |-- dim_listings.sql
|       |-- fact_reviews.sql
|       |-- full_moon_reviews.sql
|-- seeds/
|   |-- seed_full_moon_dates.csv
|-- app.py
|-- dbt_project.yml
|-- README.md
```

---

## Installation et exécution

Prérequis : Python 3.9+

### 1. Cloner le dépôt

```bash
git clone https://github.com/LesleyOulla/Airbnb-Analytics-Platform.git
cd Airbnb-Analytics-Platform
```

### 2. Installer les dépendances

```bash
pip install dbt-duckdb streamlit duckdb pandas
```

### 3. Configurer dbt

Dans `~/.dbt/profiles.yml` :

```yaml
airbnb_project:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: /chemin/vers/airbnb_project/airbnb.duckdb
      threads: 1
```

### 4. Télécharger les données

```bash
mkdir raw_data && cd raw_data
curl -O https://logbrain-datasets.s3.eu-west-1.amazonaws.com/airbnb/hosts.csv
curl -O https://logbrain-datasets.s3.eu-west-1.amazonaws.com/airbnb/reviews.csv
curl -O https://logbrain-datasets.s3.eu-west-1.amazonaws.com/airbnb/listings.csv
curl -O https://logbrain-datasets.s3.eu-west-1.amazonaws.com/airbnb/seed_full_moon_dates.csv
cd ..
```

### 5. Lancer le pipeline dbt

```bash
dbt seed
dbt run
dbt test
```

### 6. Lancer l'application Streamlit

```bash
streamlit run app.py
```

---

## Fonctionnalités

**Couche Bronze**
Ingestion brute des fichiers sources dans DuckDB, sans transformation.

**Couche Silver**
Nettoyage et typage des données, renommage des colonnes, filtrage des avis vides.

**Couche Gold**
- dim_hosts : dimension hôtes avec gestion des valeurs nulles
- dim_listings : dimension logements avec nettoyage des prix
- fact_reviews : table de faits des avis clients
- full_moon_reviews : croisement des avis avec les dates de pleine lune

**Tests qualité**
Vérification de l'unicité et de la non-nullité sur les clés primaires des tables silver.

**Dashboard Streamlit**
Filtre par type de nuit, graphique de distribution des sentiments, tableau de données interactif.

---

## Répartition des tâches

| Tâche | Responsable |
|---|---|
| Initialisation du projet dbt et GitHub | Lesley |
| Couche Bronze | Lesley |
| Couche Silver | Binôme |
| Couche Gold | Binôme |
| Tests qualité dbt | Binôme |
| Dashboard Streamlit | Lesley |
| Documentation | Lesley |

---

