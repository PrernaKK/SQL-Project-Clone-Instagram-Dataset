use ig_clone;

#Q2: We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users
order by created_at 
limit 5;

#Q3: To target inactive users in an email ad campaign, find the users who have never posted a photo.
select * from users u
left join photos p
on u.id=p.user_id
where user_id is NULL;

#Q4: Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
with CTE_count_photoLikes as
(select photo_id, count(photo_id) as cnt from likes 
group by photo_id)

select u.id as user_id,username, p.id as pic_id from users u
inner join photos p
on u.id=p.user_id
where p.id in (select photo_id from CTE_count_photoLikes
				where cnt=(select max(cnt) from CTE_count_photoLikes));

#Q5: The investors want to know how many times does the average user post.
select ROUND((select count(*) from photos)/(select count(*) from users),0) as avg_userPost;

#Q6: A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select tag_id, tag_name, COUNT(tag_name) as cnt
from tags t
inner join photo_tags pt on t.id = pt.tag_id
group by t.id
order by cnt desc
limit 5;

#Q7: To find out if there are bots, find users who have liked every single photo on the site.
select user_id, username from likes l
inner join users u
on l.user_id=u.id
group by user_id
having count(user_id)=(Select count(*) from photos)
order by user_id;

#Q8: Find the users who have created instagram id in may and select top 5 newest joinees from it?
select * from users
where monthname(created_at)='May'
order by created_at desc
limit 5;

#Q9: Can you help me find the users whose name starts with c and ends with any 
#number and have posted the photos as well as liked the photos?
select id,username from users
where username regexp '^c.*[0-9]$' and id in (select user_id from photos)
and id in(select user_id from likes);

#Q10: Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
select user_id, count(user_id) as cnt from photos
group by user_id
having count(user_id) between 3 and 5
order by cnt desc
limit 30;






