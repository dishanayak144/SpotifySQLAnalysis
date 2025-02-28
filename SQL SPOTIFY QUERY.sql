-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE SPOTIFY (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

--EDA

SELECT COUNT (*) FROM SPOTIFY;

SELECT COUNT (DISTINCT artist) FROM SPOTIFY;

SELECT COUNT (DISTINCT album) FROM SPOTIFY;

SELECT DISTINCT album_type FROM SPOTIFY;

SELECT MAX(duration_min) FROM SPOTIFY;

SELECT MIN(duration_min) FROM SPOTIFY;

SELECT * FROM SPOTIFY
WHERE duration_min=0;

DELETE FROM SPOTIFY
WHERE duration_min=0;
SELECT * FROM SPOTIFY
WHERE duration_min=0;

SELECT COUNT (*) FROM SPOTIFY;

SELECT COUNT(DISTINCT channel) FROM SPOTIFY;
SELECT DISTINCT most_played_on FROM SPOTIFY;

---------------------------------------------
-- DATA ANALYSIS -- LEVEL 1
---------------------------------------------

--((1))SONGS WITH MORE THAN 1B STREAMS-

SELECT * FROM SPOTIFY
WHERE STREAM > 1000000000;

--((2))ALL Albums along with their respective artists-

SELECT
	DISTINCT ALBUM
FROM SPOTIFY
ORDER BY 1;
SELECT
	DISTINCT ALBUM, ARTIST
FROM SPOTIFY
ORDER BY 1;

--((3))total number of comments for tracks where licensed = TRUE--


SELECT DISTINCT LICENSED FROM SPOTIFY;

SELECT SUM(COMMENTS) AS Total_comments FROM SPOTIFY
WHERE LICENSED= 'true';

--((4))ALL tracks that belong to the album type single.-

SELECT * FROM SPOTIFY
WHERE ALBUM_TYPE ILIKE 'SINGLE';


--((5))Count the total number of tracks by each artis--

SELECT * FROM SPOTIFY;
SELECT 
	ARTIST, ---1
	COUNT(*) AS Total_no_songs ---2
FROM SPOTIFY
GROUP BY ARTIST
ORDER BY 2 ASC;

---------------------------------------------
-- DATA ANALYSIS -- LEVEL 2
---------------------------------------------

--((1))average danceability of tracks in each album-

SELECT * FROM SPOTIFY;
SELECT 
	ALBUM,
	AVG(DANCEABILITY) AS AVG_danceability
FROM SPOTIFY
GROUP BY 1
ORDER BY 2 DESC;


--((2))top 20 tracks with the highest energy values-

SELECT * FROM SPOTIFY;

SELECT 
	TRACK,
	MAX(ENERGY)
FROM SPOTIFY
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20;


--((3))all tracks along with their views and likes where official_video = TRUE--

SELECT * FROM SPOTIFY;
SELECT
	TRACK,
	SUM(VIEWS) AS TOT_views,
	SUM(LIKES) AS TOT_likes
FROM SPOTIFY
WHERE official_video= 'true'
GROUP BY 1
ORDER BY 3 DESC;


--((4))For each album, calculate the total views of all associated tracks-

SELECT * FROM SPOTIFY;

SELECT
	ALBUM,
	TRACK,
	SUM(VIEWS) AS TOT_album_views
FROM SPOTIFY
GROUP BY 1,2
ORDER BY 3 DESC ;

--((5))Retrieve the track names that have been streamed on Spotify more than YouTube-


SELECT * FROM SPOTIFY;

SELECT * FROM
(
SELECT 
	TRACK,
	--MOST_PLAYED_ON,
	COALESCE(SUM(CASE WHEN most_played_on='Spotify' THEN STREAM END),0) AS stream_onspotify,
	COALESCE(SUM(CASE WHEN most_played_on='Youtube' THEN STREAM END),0) AS stream_onyt
FROM SPOTIFY
GROUP BY 1
)
AS T1
WHERE 
	stream_onspotify > stream_onyt
	AND
	stream_onyt<>0;

---------------------------------------------
-- DATA ANALYSIS -- LEVEL 3
---------------------------------------------

--((1))top 3 most-viewed tracks for each artist using window functions-
-- Total views for each track for each artist-
-- track with highest view for each artist --
-- dense rank
-- cte and filder rank<= 3

SELECT * FROM SPOTIFY;


WITH RANKING_ARTIST
AS
(SELECT 
	ARTIST,
	TRACK,
	SUM(VIEWS) AS TOT_VIEWS,
	DENSE_RANK() OVER(PARTITION BY ARTIST ORDER BY SUM(VIEWS) DESC) AS RANK
FROM SPOTIFY
GROUP BY 1, 2
ORDER BY 1,3 DESC
)
SELECT * FROM RANKING_ARTIST
WHERE RANK <= 3;

--((2))a query to find tracks where the liveness score is above the average-

SELECT * FROM SPOTIFY
WHERE LIVENESS > 0.1936;
SELECT  AVG(LIVENESS) FROM SPOTIFY; --- 0.1936

-- OR

SELECT
	TRACK,
	ARTIST,
	LIVENESS
FROM SPOTIFY 
WHERE LIVENESS > (SELECT AVG(LIVENESS) FROM SPOTIFY);


--((3))Use a WITH clause to calculate the difference between 
--     the highest and lowest energy values for tracks in each album-

SELECT * FROM SPOTIFY;

WITH CTE
AS
(SELECT
	ALBUM,
	--TRACK,
	MAX(ENERGY) AS HIGH_energy,
	MIN(ENERGY) AS LOW_energy
FROM SPOTIFY
GROUP BY 1
)
SELECT
	ALBUM,
	HIGH_energy-LOW_energy AS DIFF_energy
FROM CTE
ORDER BY 2 DESC;


--- END ---



