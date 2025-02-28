# Spotify Advanced SQL Project and Query Optimization

![Spotify Logo](https://github.com/dishanayak144/SpotifySQLAnalysis/blob/main/Spotify%20Logo%20JPG.jpg)

## Overview
This project focuses on the practical application of advanced SQL skills in the context of a Spotify dataset. The workflow encompasses database normalization, complex query development, and rigorous query optimization. The objective is to demonstrate proficiency in data manipulation and analysis, deriving actionable insights from a large-scale dataset.


## Project Steps

### 1. Data Exploration
Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:
- `Artist`: The performer of the track.
- `Track`: The name of the song.
- `Album`: The album to which the track belongs.
- `Album_type`: The type of album (e.g., single or album).
- Various metrics such as `danceability`, `energy`, `loudness`, `tempo`, and more.

### 4. Querying the Data
After the data is inserted, various SQL queries can be written to explore and analyze the data. Queries are categorized into "Level 1", "Level 1", "Level 3".

#### Level 1 Queries
- Simple data retrieval, filtering, and basic aggregations.
  
#### Level 2 Queries
- More complex queries involving grouping, aggregation functions, and joins.
  
#### Level 3 Queries
- Nested subqueries, window functions, CTEs, and performance optimization.

## Query Optimization Technique 

To improve query performance, we carried out the following optimization process:

- **Initial Query Performance Analysis Using `EXPLAIN`**
    - We began by analyzing the performance of a query using the `EXPLAIN` function.
    - The query retrieved tracks based on the `artist` column, and the performance metrics were as follows:
        - Execution time (E.T.): **13.332 ms**
        - Planning time (P.T.): **0.181 ms**

- **Index Creation on the `artist` Column**
    - To optimize the query performance, we created an index on the `artist` column. This ensures faster retrieval of rows where the artist is queried.

- **Performance Analysis After Index Creation**
    - After creating the index, we ran the same query again and observed significant improvements in performance:
        - Execution time (E.T.): **0.175 ms**
        - Planning time (P.T.): **0.231 ms**

This optimization shows how indexing can drastically reduce query time, improving the overall performance of our database operations in the Spotify project.
---







