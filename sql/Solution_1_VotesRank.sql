
---------------- Method 1--------------------
SELECT v1.name, v1.votes, COUNT(v2.votes) AS Rank
FROM votes v1
JOIN votes v2 ON v1.votes < v2.votes OR (v1.votes=v2.votes and v1.name = v2.name)
GROUP BY v1.name, v1.votes
ORDER BY v1.votes DESC, v1.name DESC; 

---------------- Method 2--------------------

SELECT name, votes, @rank := @rank + 1 AS rank
FROM  votes v, (SELECT @rank := 0) r
ORDER BY  votes desc;


---------------Method 3------------------
SELECT 
  name, 
  votes,
  CASE 
    WHEN @pRank = votes THEN @rank 
    WHEN @pRank := votes THEN @rank := @rank + 1
  END AS rank
FROM votes v,
(SELECT @rank :=0, @pRank := NULL) r
ORDER BY votes desc