SELECT ms.music_style_name , count(mms.musician_id) 
FROM music_style ms 
JOIN musician_music_style mms ON ms.music_style_id =mms.music_style_id 
GROUP BY ms.music_style_name;

SELECT COUNT(t.track_id) 
FROM album a 
JOIN track t ON t.album_id = a.album_id 
WHERE a.year_of_release IN (2019,2020);


SELECT a.album_name , AVG(t.duration) 
FROM album a 
JOIN track t ON t.album_id = a.album_id 
GROUP BY a.album_name;

SELECT DISTINCT m.musician_name 
FROM musician m
JOIN musician_album ma2 ON ma2.musician_id = m.musician_id 
WHERE ma2.musician_id NOT IN (SELECT ma.musician_id 
FROM album a
LEFT JOIN musician_album ma ON a.album_id = ma.album_id 
WHERE a.year_of_release IN (2020));


SELECT c.collection_name 
FROM collection c 
JOIN collection_track ct ON ct.collection_id =c.collection_id 
JOIN track t ON t.track_id = ct.track_id 
JOIN album a ON a.album_id = t.album_id 
JOIN musician_album ma ON ma.album_id =a.album_id 
JOIN musician m ON m.musician_id = ma.musician_id 
WHERE m.musician_name ='Dabro';

SELECT a.album_name
FROM album a 
JOIN musician_album ma ON ma.album_id = a.album_id 
WHERE ma.musician_id IN (SELECT mms.musician_id
FROM musician_music_style mms
group by mms.musician_id
HAVING COUNT(mms.music_style_id)>1);


SELECT t.track_name 
FROM track t 
LEFT JOIN collection_track ct ON ct.track_id = t.track_id 
WHERE ct.track_id IS NULL;

SELECT m.musician_name
FROM track t 
JOIN album a ON a.album_id = t.album_id 
JOIN musician_album ma ON ma.album_id =a.album_id 
JOIN musician m ON m.musician_id = ma.musician_id 
WHERE t.duration IN (SELECT MIN(t.duration) FROM track t);


SELECT a.album_name
FROM album a 
WHERE album_id IN (SELECT t.album_id 
FROM track t 
GROUP BY t.album_id 
HAVING ( COUNT(track_id) = (SELECT MIN (k) 
FROM (SELECT COUNT(track_id) k
FROM track t 
GROUP BY album_id) as X)));

