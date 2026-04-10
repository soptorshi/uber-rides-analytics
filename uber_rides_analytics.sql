-- Uber Rides Analytics SQL Queries

-- Vehicle Type v/s Avg. Distance
SELECT `Vehicle Type`, 
        ROUND(AVG(CAST(NULLIF(`Ride Distance`, 'null') AS FLOAT64)),2) AS avg_distance 
FROM `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
WHERE `Ride Distance` != 'null'
GROUP BY `Vehicle Type`;


-- Vehicle type v/s rider cancellation
select `Vehicle Type`, count(`Booking ID`) as cancelled_rides
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
where `Booking Status` = 'Cancelled by Customer'
group by `Vehicle Type`
order by cancelled_rides desc;


-- most used vehicle type
select `Vehicle Type`, count(`Booking ID`) as Ride_count
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
where `Booking Status` = 'Completed'
group by `Vehicle Type` 
order by Ride_count desc;


-- most used payment method
Select `Payment Method`, count(`Booking ID`) as Usage
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
where `Payment Method` != 'null'
group by `Payment Method`
order by Usage desc;


-- vehicle vs no driver found
select `Vehicle Type`, count(`Booking ID`) as No_driver_found
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
where `Booking Status` = 'No Driver Found'
group by `Vehicle Type`
order by No_driver_found desc;


-- Avg fare for each vehicle type 
select `Vehicle Type`, ROUND(AVG(CAST(`Booking Value` as FLOAT64)),2) as Average_fare
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
where `Booking Status` = 'Completed'
or `Ride Distance` != 'null'
or `Booking Value` != 'null'
group by `Vehicle Type`
order by Average_fare desc;


-- Avg fare per km for each vehicle type 
select `Vehicle Type`, 
        (ROUND(AVG(CAST(`Booking Value` AS FLOAT64)/CAST(`Ride Distance` AS FLOAT64)),2)) as Average_Rs_per_km
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
where `Booking Status` = 'Completed'
or `Ride Distance` != 'null'
or `Booking Value` != 'null'
group by `Vehicle Type`
order by Average_Rs_per_km desc;


-- Customer cancellations rate v/s Vehicle type
select `Vehicle Type`,
        round(
          sum(
            case when `Booking Status` = 'Cancelled by Customer'
            then 1 else 0 end
          ) * 100 / count (*), 2
        ) as Cancellation_rate
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
group by `Vehicle Type`
order by Cancellation_rate desc;


-- Avg rating v/s vehicle type
SELECT 
    `Vehicle Type`,
    ROUND(AVG(CAST(NULLIF(`Driver Ratings`, 'null') AS FLOAT64)), 2) AS Avg_Rating
FROM `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
GROUP BY `Vehicle Type`;


-- Vehicle type v/s revenue
select `Vehicle Type`, sum(
  cast(nullif(`Booking Value`,'null') as FLOAT64)
) as revenue_Rs
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
group by `Vehicle Type`;


-- peak hours
SELECT 
  case 
    when extract(hour from `Time`) between 5 and 11 then 'Morning' 
    when extract(hour from `Time`) between 12 and 16 then 'Afternoon' 
    when extract(hour from `Time`) between 17 and 21 then 'Evening'
    else 'Night'  
    end as time_of_day, count(`Booking ID`) as rides
from `rapid-hall-283607.sql_practice.Uber_NCR_ride_bookings`
group by time_of_day;
