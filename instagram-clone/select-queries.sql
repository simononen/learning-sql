-- Find the 5 oldes users

SELECT username AS 'User Name', created_at AS 'Date Joined'
FROM users
ORDER BY created_at ASC
LIMIT 5;

-- Most Popular Registration Date
SELECT
    DAYNAME(created_at) AS 'Day of joining',
    COUNT(DAYNAME(created_at)) AS 'Number of users'
FROM users
GROUP BY DAYNAME(created_at)
ORDER BY COUNT(DAYNAME(created_at)) DESC;

-- Identify Inactive Users
SELECT
    u.username AS 'Inactive users'
FROM users u
LEFT JOIN photos p
ON u.id = p.user_id
WHERE p.user_id IS NULL;

-- Most likes on a single photo
SELECT
    u.username,
    p.image_url,
    COUNT(l.photo_id) AS total
FROM users u
INNER JOIN photos p
ON u.id = p.user_id
INNER JOIN likes l
ON p.id = l.photo_id
GROUP BY p.image_url
ORDER BY total DESC
LIMIT 1;

-- Average time a user posts
SELECT
    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS Average;

-- The top 5 most commonly used hashtags
SELECT
    t.tag_name,
    COUNT(t.id) AS 'Number of tags'
FROM tags t
INNER JOIN photo_tags pt
ON t.id = pt.tag_id
GROUP BY t.id
ORDER BY COUNT(t.id) DESC
LIMIT 5;

-- Users who have liked every single post on the site
SELECT
    u.username,
    COUNT(l.user_id) AS total
FROM users u
INNER JOIN likes l
ON u.id = l.user_id
GROUP BY u.id
HAVING total = (SELECT COUNT(*) FROM photos);
