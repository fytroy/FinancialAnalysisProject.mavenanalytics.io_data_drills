SELECT 
    Date,
    Close_Price,
    AVG(Close_Price) OVER (
        ORDER BY Date
        ROWS BETWEEN 49 PRECEDING AND CURRENT ROW
    ) AS SMA_50
FROM 
    stock_prices
ORDER BY 
    Date;