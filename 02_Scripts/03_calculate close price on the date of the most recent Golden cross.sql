WITH MovingAverages AS (
    SELECT 
        Date,
        [Close],
        -- Calculate 50-Day SMA
        AVG([Close]) OVER (
            ORDER BY Date 
            ROWS BETWEEN 49 PRECEDING AND CURRENT ROW
        ) AS SMA_50,
        -- Calculate 200-Day SMA
        AVG([Close]) OVER (
            ORDER BY Date 
            ROWS BETWEEN 199 PRECEDING AND CURRENT ROW
        ) AS SMA_200
    FROM 
        stock_prices
),
CrossoverCheck AS (
    SELECT 
        Date,
        [Close],
        SMA_50,
        SMA_200,
        -- Get previous day's values to check for the "Cross"
        LAG(SMA_50) OVER (ORDER BY Date) AS Prev_SMA_50,
        LAG(SMA_200) OVER (ORDER BY Date) AS Prev_SMA_200
    FROM 
        MovingAverages
)
SELECT 
    [Close]
FROM 
    CrossoverCheck
WHERE 
    Prev_SMA_50 < Prev_SMA_200  -- Yesterday: 50-day was BELOW 200-day
    AND SMA_50 > SMA_200        -- Today: 50-day is ABOVE 200-day
ORDER BY 
    Date DESC  -- Get the most recent crossover event